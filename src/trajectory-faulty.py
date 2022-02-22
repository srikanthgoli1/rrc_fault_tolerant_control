"""
Description of what this file does.
"""

import os
import sys
cur_path=os.path.abspath(os.path.dirname(__file__))
sys.path.insert(0, cur_path+"/..")

from src.utility.logger import *

from dronekit import connect, mavutil, VehicleMode, LocationGlobalRelative
import time

logging.debug('Beginning of code...')


class Autopilot:
    """ A Dronekit autopilot connection manager. """
    def __init__(self, connection_string, *args, **kwargs):
        logging.debug('connecting to Drone (or SITL/HITL) on: %s', connection_string)
        self.master = connect(connection_string, wait_ready=True)

        # Add a heartbeat listener
        def heartbeat_listener(_self, name, msg):
            self.last_heartbeat = msg

        self.heart = heartbeat_listener

        logging.info('Drone connection successful')

    def __enter__(self):
        ''' Send regular heartbeats while using in a context manager. '''
        logging.info('__enter__ -> reviving heart (if required)')
        # Listen to the heartbeat
        self.master.add_message_listener('HEARTBEAT', self.heart)
        return self

    def __exit__(self, *args):
        ''' Automatically disarm and stop heartbeats on error/context-close. '''
        logging.info('__exit__ -> disarming, stopping heart and closing connection')
        # TODO: add reset parameters procedure. Can be based on flag?
        # Disarm if not disarmed
        if self.master.armed:
            self.master.armed = False
        # Kill heartbeat
        self.master.remove_message_listener('HEARTBEAT', self.heart)
        # Close Drone connection
        logging.info('disconnect -> closing Drone connection') 
        self.master.close()

if __name__ == '__main__':
    # Set up option parsing to get connection string
    import argparse  
    parser = argparse.ArgumentParser(description='Description of what this file does.')
    parser.add_argument('--connect', 
                    help="Vehicle connection target string. If not specified, SITL automatically started and used.")
    args = parser.parse_args()

    connection_string = '127.0.0.1:14551'
    # connection_string = args.connect
    sitl = None

    if not connection_string:
        logging.critical("No connection string specified, exiting code.")
        exit()


    with Autopilot(connection_string) as drone:
        logging.debug("Ready: %s", drone)

        def set_servo(motor_num, pwm_value):
            pwm_value_int = int(pwm_value)
            msg = drone.master.message_factory.command_long_encode(
                0, 0, 
                mavutil.mavlink.MAV_CMD_DO_SET_SERVO,
                0,
                motor_num,
                pwm_value_int,
                0,0,0,0,0
                )
            drone.master.send_mavlink(msg)

        def set_motor_mode(motor_num, set_reset):
            # get servo function - what this motor does
            logging.debug("GOT PARAM: %s", drone.master.parameters[f'SERVO{motor_num}_FUNCTION'])
            time.sleep(1)

            # set servo function - change to 1 for RCPassThru
            drone.master.parameters[f'SERVO{motor_num}_FUNCTION'] = set_reset
            time.sleep(1)

        set_motor_mode(1, 33)
        set_motor_mode(2, 34)
        set_motor_mode(3, 35)
        set_motor_mode(4, 36)
        set_motor_mode(5, 37)
        set_motor_mode(6, 38)

        logging.debug("Basic pre-arm checks")
        # Don't try to arm until autopilot is ready
        while not drone.master.is_armable:
            logging.debug(" Waiting for vehicle to initialise...")
            time.sleep(1)

        print("Arming motors")
        # Copter should arm in GUIDED mode
        drone.master.mode = VehicleMode("GUIDED")
        drone.master.armed = True

        # Confirm vehicle armed before attempting to take off
        while not drone.master.armed:
            print(" Waiting for arming...")
            time.sleep(1)

        print("Taking off!")
        drone.master.simple_takeoff(10)  # Take off to target altitude

        # Wait until the vehicle reaches a safe height before processing the goto
        #  (otherwise the command after Vehicle.simple_takeoff will execute
        #   immediately).
        while True:
            print(" Altitude: ", drone.master.location.global_relative_frame.alt)
            # Break and return from function just below target altitude.
            if drone.master.location.global_relative_frame.alt >= 10 * 0.95:
                print("Reached target altitude")
                break
            time.sleep(1)
            

        logging.debug("Set default/target airspeed to 3")
        drone.master.airspeed = 3

        logging.debug("Going towards first point for 30 seconds ...")
        point1 = LocationGlobalRelative(-35.361354, 149.165218, 20)
        drone.master.simple_goto(point1)

        # sleep so we can see the change in map
        time.sleep(5)

        logging.debug("Last Heartbeat: %s", drone.last_heartbeat)

        set_motor_mode(5, 1)
        set_motor_mode(6, 1)

        set_servo(5, 1000)
        set_servo(6, 1000)

        time.sleep(10)