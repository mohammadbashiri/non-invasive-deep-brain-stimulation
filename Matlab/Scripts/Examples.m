close all; clear all;

%%
% This script includes example of generating figure for VCN neurons
% 
% Author: Mohammad Bashiri
% Date (Last Update): 09/08/2018
%  
% NOTES:
%   - All the units are SI units
%
%

%% VCN model simulation
%% Initializing simulation parameters

tend = 0.2; % second
fs   = 1e6; % Hz
t    = (1:tend*fs)/fs; % second

%% Stimulation signals

stim_util = stim_util();
base_freq = 3000; % Hz
Tonset    = .05; % onset delay

% define the currents (amplitude in Ampere)
I1      = 5e-9 * stim_util.sin(t(1), base_freq, 0, t);
I2      = 5e-9 * stim_util.sin(t(1), base_freq + 30, 0, t);
I3      = 0e-9 * stim_util.sin(t(1), base_freq, 0, t);

I       = I1 + I2 + I3;

% manipulate the stimulation signal
I(1:Tonset*fs) = 0; % delay signal onset
% I_stim         = I .* stim_util.slope(0.05, 0.15, t); % apply a slope
% I_stim         = max(I) .* stim_util.chirp(t, 10, t(end), 1000, 'quadratic'); % apply a chirp
% I_stim         = I .* stim_util.pulse(0.05, .005, .01, t); % apply pulse

%% Specify VCN neuron type and run the simulation
neuron_type = 'II';
Vm = VCN(I_stim, neuron_type, fs); 

%% Visualize
figure;
subplot(5,1,[1, 2]); plot(t, I_stim); ylim([min(I_stim) + min(I_stim)*0.1, max(I_stim) + max(I_stim)*0.1]);
% legend('Stimulation Current', 'Location', 'northwest');
ylabel({'$I (A)$'},'Interpreter','latex');

subplot(5,1,[3, 4, 5]); plot(t, Vm); ylim([min(Vm) + min(Vm)*0.1, max(Vm) + max(Vm)*0.1]);
% legend('Action Potential', 'Location', 'southwest')
xlabel({'$Time (s)$'},'Interpreter','latex');
ylabel({'$Membrane voltage (V)$'},'Interpreter','latex');

suptitle({['Type ', neuron_type, ' Model'], '(Phasic Neuron)'});
