
from __future__ import print_function
import time
from dronekit import connect, VehicleMode, LocationGlobalRelative
import csv
import math
from pymavlink import mavutil
# Set up option parsing to get connection string
import argparse


parser = argparse.ArgumentParser()
parser.add_argument('--connect', default='127.0.0.1:14551')
args = parser.parse_args()

connection_string = args.connect
sitl = None


# Start SITL if no connection string specified
if not connection_string:
    import dronekit_sitl
    sitl = dronekit_sitl.start_default()
    connection_string = sitl.connection_string()

"""
GNSSfix Type: (Global Navigation Satellite System)
0: no fix
1: dead reckoning only
2: 2D-fix
3: 3D-fix
4: GNSS + dead reckoning combined, 
5: time only fix
"""

# Connect to the Vehicle
print('Connecting to vehicle on: %s' % connection_string)
vehicle = connect(connection_string, wait_ready=True)

def put_data():
    #print(mavutil.mavlink.ESTIMATOR_STATUS_FLAGS)
#   print(mavutil.mavlink.ESTIMATOR_STATUS.flags)
    print('Position: %s'% vehicle.location.global_relative_frame)
    h = round(vehicle.gps_0.eph,2)
    v = round(vehicle.gps_0.epv,2)
    e = round(vehicle.gps_0.fix_type,2)
    s = round(vehicle.gps_0.satellites_visible,2)
    p = round(math.sqrt(h**2 + v**2),2)
    print('Hdop: '+str(h/100), ', Vdop: '+ str(v/100), ', Fix_type: '+ str(e), ', Satellites_visible: '+ str(s) )
    print('Calculations(in m*m): Drms - horizontal: '+ str(h*25), ', CEP50: '+ str(h*25*0.75/100)+ ' radius of around: '+ str(math.sqrt((h*25*0.75/100)/3.14))+ 'm', ', CEP95: '+ str(h*25*2/100) )
    print('Calculations(in m*m): Drms - Vertical: '+ str(v*25), ', CEP50: '+ str(v*25*0.75/100) + ' radius of around: '+ str(math.sqrt((v*25*0.75/100)/3.14))+ 'm', ', CEP95: '+ str(v*25*2/100) )
    print('Calculations(in m*m): Drms - Position: '+ str(p*25), ', CEP50: '+ str(p*25*0.75/100) + ' radius of around: '+ str(math.sqrt((p*25*0.75/100)/3.14))+ 'm', ', CEP95: '+ str(p*25*2/100) )
    
    if(s< 4):
        print("less setelites, sending error")
    else:
        print('Number of satellites > 4')


    world = 12
    data = [str(vehicle.location.global_relative_frame.lat), str(vehicle.location.global_relative_frame.lon), str(vehicle.location.global_relative_frame.alt), str(h), str(v), str(e), str(s), str(p)]
    with open('gps_data.csv', 'a') as f:
        writer = csv.writer(f)
        writer.writerow(data)


def arm_and_takeoff(aTargetAltitude):
    """
    Arms vehicle and fly to aTargetAltitude.
    """

    print("Basic pre-arm checks")
    # Don't try to arm until autopilot is ready
    while not vehicle.is_armable:
        print(" Waiting for vehicle to initialise...")
        time.sleep(1)

    print("Arming motors")
    # Copter should arm in GUIDED mode
    vehicle.mode = VehicleMode("GUIDED")
    vehicle.armed = True

    # Confirm vehicle armed before attempting to take off
    while not vehicle.armed:
        print(" Waiting for arming...")
        time.sleep(1)

    print("Taking off!")
    vehicle.simple_takeoff(aTargetAltitude)  # Take off to target altitude

    # Wait until the vehicle reaches a safe height before processing the goto
    #  (otherwise the command after Vehicle.simple_takeoff will execute
    #   immediately).
    while True:
        print(" Altitude: ", vehicle.location.global_relative_frame.alt)
        # Break and return from function just below target altitude.
        if vehicle.location.global_relative_frame.alt >= aTargetAltitude * 0.95:
            print("Reached target altitude")
            break
        time.sleep(1)

put_data()
arm_and_takeoff(10)

print("Set default/target airspeed to 3")
vehicle.airspeed = 3
print('Position: %s'% vehicle.location.global_frame)

x1_lat = vehicle.location.global_frame.lat
x1_long = vehicle.location.global_relative_frame.lon
x2_lat = -35.361354
x2_long = 149.165218
x3_lat = -35.363244
x3_long = 149.168801

print(x1_lat)
print(x2_long)

#print('Position: %s'% vehicle.location.global_relative_frame)

print("Going towards first point for 30 seconds ...")
point1 = LocationGlobalRelative(x2_lat, x2_long, 20)
vehicle.simple_goto(point1)

time.sleep(0)
print('Position: %s'% vehicle.location.global_relative_frame)

# sleep so we can see the change in map
for i in range(0, 30):
    put_data()
    time.sleep(1)

print("Going towards second point for 30 seconds (groundspeed set to 10 m/s) ...")
point2 = LocationGlobalRelative(x3_lat, x3_long, 20)
vehicle.simple_goto(point2, groundspeed=10)

# sleep so we can see the change in map
time.sleep(0)
print('Position: %s'% vehicle.location.global_relative_frame)

for i in range(0, 30):
    put_data()
    time.sleep(1)


print("Returning to Launch")
vehicle.mode = VehicleMode("RTL")


# Close vehicle object before exiting script
print("Close vehicle object")
vehicle.close()

# Shut down simulator if it was started.
if sitl:
    sitl.stop()

