# motor_fault_sim_dataset
## What this repository contains?
- Python code
  - For a normal trajectory
  - For a motor fault induced during normal trajectory
  - For reading sensor data during a flight
  - For introducing a sensor fault during flight
- Generated datasets
  - [set-1](dist/set-1) - Motor fault data is logged for 4 different drone frames (Quad+, QuadX, Hexa+, HexaX)

## Getting started with code

### Pre-requisites

- Python 3.8
- SITL (preferred) OR Actual drone

  (This needs to have the SERVOn_FUNCTION parameters; which are missing in the ArduPilot firmware, but available on the PX4 firmware)
  - Pixhawk hardware running [ArduPilot](https://github.com/ArduPilot/ardupilot) (and not [PX4](https://github.com/PX4/PX4-Autopilot)) firmware. Should also contain SERVOn_FUNCTION params.
  - OR the official [ArduPilot SITL](https://ardupilot.org/dev/docs/sitl-simulator-software-in-the-loop.html). You can read more about [setting up SITL here](https://ardupilot.org/dev/docs/SITL-setup-landingpage.html#sitl-setup-landingpage).
- Ground Station software
  - APM Planner - [Install guide](https://ardupilot.org/planner2/docs/installing-apm-planner-2.html)
  - OR QGroundControl - [Install guide](https://docs.qgroundcontrol.com/master/en/getting_started/download_and_install.html)
- MAVExplorer.py - [Install guide](https://ardupilot.org/dev/docs/using-mavexplorer-for-log-analysis.html) (MAVExplorer can be used for generating graphs from log files)

### Setting up
- Clone this repository
- Open the repository project in your IDE, or cd your command prompt to the directory
- Run `pip install -r requirements.txt` (Python 2), <br>
or `pip3 install -r requirements.txt` (Python 3) <br>
in the command prompt
- (Optional for Windows) You need the `<Your Drive>/ArduPilot/Tools/autotest/` folder in your $PATH Environment Variable. This folder contains the `sim_vehicle.py` file. Alternatively, to run the simulation, you can cd to this directory and run the `sim_vehicle.py` file whenever needed. 

### Run a sample code simulation

1. Drone simulation without any faults
- Run the SITL simulator <br>
`sim_vehicle.py -v ArduCopter`
- Run the ground station software (APM/QGC) (if it already isn't running)
- Wait for a few seconds for SITL to connect to the ground station <br>
In case the ground station does not directly connect to the SITL, you can manually try connecting to `127.0.0.1` on ports 14450, 14451, 5760 over UDP.
- Open `trajectory-healthy.py` in case you want to edit; or directly run it <br>
`python trajectory-healthy.py`
- Code will automatically exit on completion
- You can download the log file from SITL [as mentioned here](https://ardupilot.org/dev/docs/using-sitl-for-ardupilot-testing.html#accessing-log-files)
- (Optional) You can generate graphs from this log file by running <br>
`MAVExplorer.py <path-to-log-file>.log`

2. Drone simulation with faulty motor(s)

3. 



(https://ardupilot.org/dev/docs/using-sitl-for-ardupilot-testing.html#using-sitl-for-ardupilot-testing)