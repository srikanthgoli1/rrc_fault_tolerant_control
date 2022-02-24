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

% Select the dataset array you wish to work on (Baro, Gyro, EKF, ...)
selectedArray = DATASET.RATE;

% Find closest timestamp in the BARO (Barometer) data array.
% val stores the time value in us
% key stores the key of that timestamp in BARO. i.e. this is the closest
% timestamp in BARO, when compared to the input SERVO1_FUNCTION timestamp's
% last call.
[val, key] = min(abs(selectedArray.TimeUS-lastParamTimestamp));
RATELastTimestamp=selectedArray.TimeUS(key);

% TODO: Marker
disp("RATELastTimestamp: " + RATELastTimestamp);

% The selected array can now be observed from the selected key onwards.
% i.e. this is the timestamp after which motor fault occurs.

% Create plots
x = (selectedArray.TimeUS);
t = tiledlayout(3,2);

rateP = selectedArray.P;
t1 = nexttile;
plot(x, rateP);
line([RATELastTimestamp RATELastTimestamp], ylim, 'Color',[1,0,0]);
xlabel(t1,'Time in microseconds');
ylabel(t1,'P');

ratePDes = selectedArray.PDes;
t2 = nexttile;
plot(x, ratePDes);
line([RATELastTimestamp RATELastTimestamp], ylim, 'Color',[1,0,0]);
xlabel(t2,'Time in microseconds');
ylabel(t2,'P Desired');

rateY = selectedArray.Y;
t3 = nexttile;
plot(x, rateY);
line([RATELastTimestamp RATELastTimestamp], ylim, 'Color',[1,0,0]);
xlabel(t3,'Time in microseconds');
ylabel(t3,'Y');

rateYDes = selectedArray.YDes;
t4 = nexttile;
plot(x, rateYDes);
line([RATELastTimestamp RATELastTimestamp], ylim, 'Color',[1,0,0]);
xlabel(t4,'Time in microseconds');
ylabel(t4,'Y Desired');

rateR = selectedArray.R;
t5 = nexttile;
plot(x, rateR);
line([RATELastTimestamp RATELastTimestamp], ylim, 'Color',[1,0,0]);
xlabel(t5,'Time in microseconds');
ylabel(t5,'R');

rateRDes = selectedArray.RDes;
t6 = nexttile;
plot(x, rateRDes);
line([RATELastTimestamp RATELastTimestamp], ylim, 'Color',[1,0,0]);
xlabel(t6,'Time in microseconds');
ylabel(t6,'R Desired');