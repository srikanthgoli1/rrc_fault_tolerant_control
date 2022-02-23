Table of Contents:
- [What this repository contains?](#what-this-repository-contains)
- [Getting started with code](#getting-started-with-code)
  - [Pre-requisites](#pre-requisites)
  - [Setting up](#setting-up)
  - [Run a sample code](#run-a-sample-code)
    - [Drone simulation without any faults (trajectory-healthy.py)](#drone-simulation-without-any-faults-trajectory-healthypy)
    - [Drone simulation with faulty motor(s) (trajectory-faulty.py)](#drone-simulation-with-faulty-motors-trajectory-faultypy)
    - [Read a Dataset (read_dataset.m)](#read-a-dataset-read_datasetm)

## What this repository contains?
- Python code
  - [trajectory-healthy.py](src/trajectory-healthy.py) - For a normal trajectory
  - [trajectory-faulty.py](src/trajectory-faulty.py) - For a motor fault induced during normal trajectory
  - For reading sensor data during a flight
  - For introducing a sensor fault during flight
- MATLAB code
  - [read_dataset.m](src_matlab/read_dataset.m) - For reading a dataset file and making sense of it
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

### Run a sample code

#### Drone simulation without any faults ([trajectory-healthy.py](src/trajectory-healthy.py))
- Run the SITL simulator <br>
`sim_vehicle.py -v ArduCopter`
- Run the ground station software (APM/QGC) (if it already isn't running)
- Wait for a few seconds for SITL to connect to the ground station <br>
In case the ground station does not directly connect to the SITL, you can manually try connecting to `127.0.0.1` on ports 14450, 14451, 5760 over UDP.
- Open `trajectory-healthy.py` in case you want to edit; or directly run it <br>
`python trajectory-healthy.py`
  - (Optional) In case your code does not connect to the SITL, you might want to change the connection_string value. This can be done by [passing an argument](src/trajectory-healthy.py#L56), or by [modifying the value in code](src/trajectory-healthy.py#L63).
- Code will automatically exit on completion
- You can download the log file from SITL [as mentioned here](https://ardupilot.org/dev/docs/using-sitl-for-ardupilot-testing.html#accessing-log-files)
- (Optional) You can generate graphs from this log file by running <br>
`MAVExplorer.py <path-to-log-file>.log`

#### Drone simulation with faulty motor(s) ([trajectory-faulty.py](src/trajectory-faulty.py))
- Run the SITL simulator <br>
`sim_vehicle.py -v ArduCopter`
- Run the ground station software (APM/QGC) (if it already isn't running)
- Wait for a few seconds for SITL to connect to the ground station <br>
In case the ground station does not directly connect to the SITL, you can manually try connecting to `127.0.0.1` on ports 14450, 14451, 5760 over UDP.
- Open `trajectory-faulty.py` in case you want modify which motors should stop working:
  - [Line 99](src/trajectory-faulty.py#L99) - In case of QuadCopter simualtion, keep the next two lines commented. In case of HexaCopter simualtion, uncomment the next two lines.
  - [Line 146](src/trajectory-faulty.py#L146) - Use `set_motor_mode(MOTOR_NUMBER, FUNCTION)` function to set a value of 1 for all the motors you wish to override (in flight, by overtaking control from the AutoPilot code)
  - [Line 149](src/trajectory-faulty.py#L149) - Use `set_servo(MOTOR_NUMBER, PWM_VALUE)` function to send a PWM signal to one of the overridden (in previous step) motors. This will not work if the motor is still in control with the AutoPilot. (i.e. if previous step is skipped)
- Run `python trajectory-faulty.py`
  - (Optional) In case your code does not connect to the SITL, you might want to change the connection_string value. This can be done by [passing an argument](src/trajectory-faulty.py#L56), or by [modifying the value in code](src/trajectory-faulty.py#L63).
- Code will automatically exit on completion
- You can download the log file from SITL [as mentioned here](https://ardupilot.org/dev/docs/using-sitl-for-ardupilot-testing.html#accessing-log-files)
- (Optional) You can generate graphs from this log file by running <br>
`MAVExplorer.py <path-to-log-file>.log`

#### Read a Dataset ([read_dataset.m](src_matlab/read_dataset.m))
- Open the `read_dataset.m` file in MATLAB
- Make sure the `read_dataset.m` file and the `dist` folder are added to the MATLAB current path
  - You can do this by simply right-clicking on the file/folder in the file manager (on left side panel) and selecting Add to Path > Selected Folders and Subfolders
- a