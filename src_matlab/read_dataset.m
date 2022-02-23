% Choose which log file to read
filename = 'dist/set-1/quad-x/m1.mat';

% Choose variables to read - you can open the .mat file and read the (upto
% 4 digit) var names. You can add the desired var names here.
varsToRead = {'AHR2','ATT','BARO','IMU','MAG','PARM','RATE','SIM'};

DATASET = load(filename, varsToRead{:});

% Change searchParam value; by replacing the 1 to any other integer in
% [1,2,3,4] for QuadCopter or [1,2,3,4,5,6] for HexaCopter
searchParam = 'SERVO1_FUNCTION';

searchParamUses = ~cellfun('isempty',strfind(cellstr(DATASET.PARM.Name),searchParam));
searchLastParamUse = find(searchParamUses);

% Index of Last usage of param stored here
lastParamUse = searchLastParamUse(end);

% Timestamp (TimeUS) variable of the above packet - this is the time in
% microseconds, when the motor is overridden. Fault occurs immediately
% after this.
lastParamTimestamp = DATASET.PARM.TimeUS(lastParamUse);

% Find closest timestamp in the BARO (Barometer) data array.
% val stores the time value in us
% key stores the key of that timestamp in BARO. i.e. this is the closest
% timestamp in BARO, when compared to the input SERVO1_FUNCTION timestamp's
% last call.
[val, key] = min(abs(DATASET.BARO.TimeUS-lastParamTimestamp));
altitudeAtLastTimestamp=DATASET.BARO.Alt(key);

% The altitude array can now be observed from the selected key onwards.
% i.e. this is the timestamp after which motor fault occurs.
newAltitudeArrray = DATASET.BARO.Alt(key:end);
plot(newAltitudeArrray);