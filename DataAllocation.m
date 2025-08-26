%% Data Collection - SQL Results

% Three sets of uncompensated open-loop data
% 100% input power from heaters
% Allow to reach a max. of 300 deg C
% Determine tau if applicable
% Track every 0.5 deg at a sampling rate of 0.1 seconds

clear all
clc
close all

% load in excel data sheet
machineData = readtable('UncompensatedZone1Data.xlsx'); % Use your actual filename
t = machineData.Time;
u = machineData.Power;
y = machineData.Temperature;

% store values in a struct with 3 fields (power, temperature, time)
UncZone1Data = struct('u', u, 'y', y, 't', t);

% diff yields the time steps
ts = mean(diff(UncZone1Data.t));  % seconds, sampling time estimate