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

rateP = selectedArray.P;
ratePDes = selectedArray.PDes;
t1 = nexttile;
plot(x, rateP);
hold on;
plot(x, ratePDes, 'Color',[1,0.7,0]);
line([RATELastTimestamp RATELastTimestamp], ylim, 'Color',[1,0,0]);
xlabel(t1,'Time in microseconds');
ylabel(t1,'P and P Desired');
legend('P','PDes','ERR');

rateY = selectedArray.Y;
rateYDes = selectedArray.YDes;
t2 = nexttile;
plot(x, rateY);
hold on;
plot(x, rateYDes, 'Color',[1,0.7,0]);
line([RATELastTimestamp RATELastTimestamp], ylim, 'Color',[1,0,0]);
xlabel(t2,'Time in microseconds');
ylabel(t2,'Y and Y Desired');
legend('Y','YDes','ERR');

rateR = selectedArray.R;
rateRDes = selectedArray.RDes;
t3 = nexttile;
plot(x, rateR);
hold on;
plot(x, rateRDes, 'Color',[1,0.7,0]);
line([RATELastTimestamp RATELastTimestamp], ylim, 'Color',[1,0,0]);
xlabel(t3,'Time in microseconds');
ylabel(t3,'R and R Desired');
legend('R','RDes','ERR');