close all; clear all;
%
% This script is used to generate figures for the paper 
% 
% Author: Mohammad Bashiri
% Date (Last Update): 09/08/2018
%  
%
%% VCN model simulation

clear all

% initializing simulation param
tend = 200e-3; % 2sec
fs   = 1e6;

neuron_type = 'II';
slope = 1; %.00005;
stim_freq = 3000;

% initialize stimulaiton current
I_stim1 = 5;    % nA 
freq1   = stim_freq;    % Hz

I_stim2 = 5;     % nA 
freq2   = stim_freq + 30;  % Hz

I_stim3 = 0;     % nA 
freq3   = stim_freq + 1.02;  % Hz

VCN( I_stim1, freq1, I_stim2, freq2, I_stim3, freq3, tend, fs, slope, neuron_type );