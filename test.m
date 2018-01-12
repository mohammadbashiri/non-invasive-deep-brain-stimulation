close all; clear all;

% we are gonna load in the data saved from analytical solution
load('R_H.mat'); 
dataL_H  = fliplr(dataR_H);
dataAM_H = (dataL_H + dataR_H) - abs(dataL_H - dataR_H); 
figure; plot(1:numel(dataL_H), dataL_H,...
             1:numel(dataR_H), dataR_H,...
             1:numel(dataR_H), dataAM_H,...
             'LineWidth', 3);
title('Unnormalized values')
grid; axis tight

% normalize them (max AM signal must be 1)
dataR_H  = dataR_H/max(dataAM_H);
dataL_H  = dataL_H/max(dataAM_H);
dataAM_H = dataAM_H/max(dataAM_H);
figure; plot(1:numel(dataL_H), dataL_H,...
             1:numel(dataR_H), dataR_H,...
             1:numel(dataR_H), dataAM_H,...
             'LineWidth', 3);
title('Unnormalized values')
grid; axis tight

%% Some explanation up to this point

% No we are gonna test what is the amplitude needed for the modulated
% signal to make the neuron spike. Then we multiply the normalized values
% with that value. The we check if the new values of the pure sinudoids
% elicit action potential near the electrodes!

% check the value -> 35 (each 17.5)

%% Simulation

% initializing simulation param
tend = 500;
fs   = 100;
dt   = 1/fs; % 0.01

% initialize stimulaiton current
I_stim1 = 17.5;    % nA 
freq1   = 1.0;     % 0.01 => 10 Hz

I_stim2 = 17.5;    % nA 
freq2   = 1.01;    % 0.01 => 10 Hz

I_stim3 = 0;       % nA 
freq3   = 1.02;    % 0.01 => 10 Hz

slope = .05; % this is in the units of the current over time!
MHH( I_stim1, freq1, I_stim2, freq2, I_stim3, freq3, tend, dt, slope );

%% Effect of pure sinusoids near electrode

% Multiply the normalized data with the value found above (35)
dataR_H  = dataR_H * 35;
dataL_H  = dataL_H * 35;
dataAM_H = dataAM_H * 35;
figure; plot(1:numel(dataL_H), dataL_H,...
             1:numel(dataR_H), dataR_H,...
             1:numel(dataR_H), dataAM_H,...
             'LineWidth', 3);
title('Scaled')
grid; axis tight

%%
% now we can simply pick two arbitrary points near the electrode and see if
% we see action potential

index = 400;
dataL_point  = dataL_H(index);
dataR_point  = dataR_H(index);
dataAM_point = dataAM_H(index);

figure; plot(1:numel(dataL_H), dataL_H,...
             1:numel(dataR_H), dataR_H,...
             1:numel(dataR_H), dataAM_H,...
             'LineWidth', 3); grid; axis tight;
hold on; 
scatter(index, dataL_point, 50, 'k'); 
scatter(index, dataR_point, 50, 'k');
scatter(index, dataAM_point, 50, 'k'); hold off;

% initializing simulation param
tend = 500;
fs   = 100;
dt   = 1/fs; % 0.01

% initialize stimulaiton current
I_stim1 = dataL_point;     % nA 
freq1   = 1.0;    % 0.01 => 10 Hz

I_stim2 = dataR_point;   % nA 
freq2   = 1.01;    % 0.01 => 10 Hz

I_stim3 = 0;   % nA 
freq3   = 1.02;    % 0.01 => 10 Hz

slope = 3e-5; % change to 1, if you do not want a ramp

MHH( I_stim1, freq1, I_stim2, freq2, I_stim3, freq3, tend, dt, slope );

%% VCN model
clear all

% initializing simulation param
tend = 1000e-3;
fs   = 30e3;

% initialize stimulaiton current
I_stim1 = 2.5;    % nA 
freq1   = 10;    % Hz

I_stim2 = 0;     % nA 
freq2   = 1010;  % Hz

I_stim3 = 0;     % nA 
freq3   = 1.02;  % Hz

slope =  .00005;

VCN( I_stim1, freq1, I_stim2, freq2, I_stim3, freq3, tend, fs, slope, 'II' );