close all; clear all;

% we are gonna load in the data saved from analytical solution
folder  = 'Figures\dipole_distance\';
degrees = '0\';
path    = strcat(folder, degrees);

% load data
load(strcat(path, 'R_H.mat')); 
load(strcat(path, 'L_H.mat'));

% compute the amplitude modulated and dc (just addition) amplitudes
dataAM_H = (dataL_H + dataR_H) - abs(dataL_H - dataR_H);
dataDC_H = dataL_H + dataR_H;
figure; plot(1:numel(dataL_H), dataL_H,...
             1:numel(dataR_H), dataR_H,...
             1:numel(dataR_H), dataAM_H,...
             1:numel(dataR_H), dataDC_H,...
             'LineWidth', 3);
title('Unnormalized')
grid; axis tight

% i need to know if high frequency with double to 