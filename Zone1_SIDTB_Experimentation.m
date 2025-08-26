%% Heater Band Zone 1 Simulation - System ID Toolbox Test
% This simulation covers the use of MATLABs System Identification Toolbox.
% This will be used to derive a plant transfer function for zone 1 of the
% systems Extruder. Data is pulled from physical system operating in manual
% mode at 100% output power. 
% 
% clear all
% close all
% clc

PlantTest

%% Data Section
s = tf('s'); % creates special variable 's' that can be used to create a transfer function model
time = 800; % elapsed time (secs), 12 mins
w = 250; % setpoint, °C
x = 100; % initial temp of zone, °C

%% Plant Model Derivation, Open-Loop and Uncompensated Closed-Loop Step Response
% Plant model generated from tfest command of system ID toolbox. Dataset
% comes from SQL server. 

% Plant Transfer Function derived from SQL data
Gp = Gp_Zone1;
t = 0:Ts:time;  % Time vector (seconds)

figure
step(Gp + x, t); % simulated open loop step response

hold on
grid on

Gcl_unc = feedback(Gp + x, 1); % uncompensated closed-loop feedback

step(Gp * (w - x) + x, t); % uncompensated closed loop step response

hold on 

%% Controller Implementation and Parameters
% PID Parameters for this specific heater zone are pulled from PLC

% PID Parameters Zone 1
Kp = 10; % proportional gain
Td = 25; % derivative time delay
Ti = 100; % integral action time delay
ts = 2; % sampling time
a = 0.1; % coefficient for derivative-action delay, not very sure what this does and needs more research
c = 0; % derivative action weighting
b = 2.5211000E-01; % proportional action weighting

% Siemens Controller Implementation
Gc = Kp*(b + 1/(Ti*s) + (Td*s/(a*Td*s+1))*c); % Siemens PID_TEMP alg. pulled from Siemens documentation

% the feedback function directly applies the feedback to the controller 
% rather than using the variables 'w' (setpoint) and 'x' (process value) 
% from the siemens algorithm. this is why there is a slight alteration to 
% the controller function we see in the documentation.

Gcl_com = feedback(Gc*Gp, 1); % compensated system feedback
step(Gcl_com * (w - x) + x, t, 'm'); % simulated step input for compensated system

title("Zone 1 Step Responses")
legend("Open-Loop", "Uncompensated Closed-Loop", "Compensated Closed-Loop", Location="east")
xlim([0 time]);
ylim([100 w+20]);
% sp.TimeUnit = "minutes"; % was using this to show plot in minutes

%% PID Tuning Section

% section shows the compensated closed loop response. this is what will be
% used when tuning the PID in this simulation. the previous plots are meant
% for evaluation. to change the plot, you will have to adjust the PID
% values in the previous section labeled as "Controller Implementation and
% Parameters"

figure
Gcl_com = feedback(Gc*Gp, 1); % compensated system feedback
step(Gcl_com * (w - x) + x, t, 'm'); % simulated step input for compensated system
grid on
title("Compensated Closed-Loop Step Response")
xlim([0 time]);
ylim([100 w+40]);
