
load UncZone1Data.mat % table that was created from SQL data

Ts = mean(diff(t));  % seconds, sampling time estimate

% Create iddata object
data_id = iddata(y, u, Ts);
np = 1; % number of poles
nz = 0; % number of zeros

Gp_Zone1 = tfest(data_id, np, nz);
compare(data_id, Gp_Zone1)
