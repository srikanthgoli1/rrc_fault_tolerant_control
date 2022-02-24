filename = 'dist/set-1/quad-x/m2.mat';
varsToRead = {'AHR2','ATT','BARO','IMU','MAG','PARM','RATE','SIM'};
DATASET = load(filename, varsToRead{:});
searchParam = 'SERVO2_FUNCTION';

searchParamUses = ~cellfun('isempty',strfind(cellstr(DATASET.PARM.Name),searchParam));
searchLastParamUse = find(searchParamUses);
lastParamUse = searchLastParamUse(end);

% NOTE: This is when the SERVO1_FUNCTION override is sent to drone
lastParamTimestamp = DATASET.PARM.TimeUS(lastParamUse);
disp("lastParamTimestamp: " + lastParamTimestamp);
% TimeUS: 73274845

selectedArray = DATASET.RATE;
[val, key] = min(abs(selectedArray.TimeUS-lastParamTimestamp));

% TODO: This is the closest timestamp to lastParamTimestamp in the
% DATASET.RATE Array.
% Both timestamps are slightly different, since each module works at a
% different speed.
RATELastTimestamp=selectedArray.TimeUS(key);
disp("RATELastTimestamp: " + RATELastTimestamp);
% TimeUS: 73269014

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