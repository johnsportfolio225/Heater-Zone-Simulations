%% Heater Band Zones Simulation
% Next stage of simulation after 'Zone1Test.m'. This code serves as a 
% simulation of all eight zones. Refer to 'Zone1Test.m' for guidance and 
% explanations

clear all
close all
clc

%% Data Section
s = tf('s'); % creates special variable 's' that can be used to create a transfer function model
time = 800; % elapsed time (secs), 12 mins
w = 250; % setpoint, °C

% initial temp of zone, °C (this will vary, look at SQL data when available
x = [100, 100, 100, 100, 100, 100, 100, 100]; % initial temperature of zone

ssT = x + 0.632 * (w - x); % 63.2% Steady State Temperature Change

% will need to determine wattage of each heater
power = [2000, 3000, 3000, 3000, 3000, 3000, 3000, 1000]; % heater wattage, W

% will need to determine tau for each zone
tau = [65, 65, 65, 65, 65, 65, 65, 65]; % thermal time constant

% will need to determine for each zone, but not entirely necessary
tau_null = [167, 167, 167, 167, 167, 167, 167, 167]; % thermal time constant for compensated closed-loop system

%% Controller Parameters
% PID Parameters for this specific heater zone are pulled from 
% S:\Electrical & Controls\AMC160\AMC160_ExtruderZonePIDParameters.

% PID Parameters Zones 1 - 8
Kp = [10.0, 2.512243, 2.705058, 2.902283, 2.9, 3.587241, 3.629854, 2.89523]; % proportional gain
Ti = [100.0, 99.51765, 107.6981, 98.82712, 95.0, 89.25153, 76.33755, 134.5546]; % derivative time delay
Td = [25.0, 25.21677, 27.25217, 25.0027, 25.0, 22.60847, 19.337365, 34.11558]; % integral action time delay
ts = [2.5211000E-01, 2.550063E-01, 2.573011E-01, 0.25766585, 2.580306E-01, 2.555074E-01, 0.25549115, 2.540359E-01]; % sampling time
a = 0.1; % coefficient for derivative-action delay
c = 0; % derivative action weighting
b = 2.5211000E-01; % proportional action weighting

%% Plant Model, Open-Loop and Compensated Closed-Loop Step Response

for zone = 1:8
    
    figure(zone)

    % Open-Loop Gain
    K = (w - x(zone))/power(zone); % °C/W, for every watt of heat dissipated, the temperature will rise by 'K'

    % Plant Transfer Function
    Gp = K/(tau(zone)*s+1); % first order thermal system (Classical Controls)
    t = 0:ts(zone):time;  % Time vector (seconds), 0.1s time step

    step(Gp * power(zone) + x(zone), t); % simulated open loop step response
    hold on

    Gcl_unc = feedback(Gp, 1); % uncompensated closed-loop feedback
    step(Gp * (w - x(zone)) + x(zone), t); % uncompensated closed loop step response

    hold on

    % Siemens Controller Implementation
    Gc = Kp(zone)*(b + 1/(Ti(zone)*s) + (Td(zone)*s/(a*Td(zone)*s+1))*c); % Siemens PID_TEMP alg. pulled from Siemens documentation

    Gcl_com = feedback(Gc*Gp, 1); % compensated system feedback
    step(Gcl_com * (w - x(zone)) + x(zone), t); % simulated step input for compensated system
    
    hold off
    grid on
    title(['Zone ', num2str(zone), ' Step Response Set'])
    legend("Open-Loop", "Uncompensated Closed-Loop", "Compensated Closed-Loop", Location="east")
    xlim([0 time]);
    ylim([100 w+20]);
end

%% Compensated Closed-Loop Step Response Collection

figure
hold on

for zone = 1:8
    K = (w - x(zone))/power(zone); % Open-Loop Gain
    Gp = K/(tau(zone)*s+1); % Plant Transfer Function
    Gc = Kp(zone)*(b + 1/(Ti(zone)*s) + (Td(zone)*s/(a*Td(zone)*s+1))*c); % Siemens PID_TEMP alg.
    t = 0:ts(zone):time;
    Gcl_com = feedback(Gc*Gp, 1); % compensated system feedback
    step(Gcl_com * (w - x(zone)) + x(zone), t); % simulated step input for compensated system
end

hold off
grid on
title("Compensated Closed-Loop Step Responses")
legend("Zone 1", "Zone 2", "Zone 3", "Zone 4", "Zone 5", "Zone 6", "Zone 7", "Zone 8", Location="northwest")
xlim([0 time]);
ylim([100 w+20]);

