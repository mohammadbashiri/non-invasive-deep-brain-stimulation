%% Figure from the original paper (sanity check) 
% It shows that type II neuron elicites a signle spike when a pulse input
% current is injected

% Initializing simulation parameters
tend = 0.5; % second
fs   = 1e6; % Hz
t    = (1:tend*fs)/fs; % second

% Stimulation signals
stim_util = stim_util();
Tonset    = .05; % onset delay

I              = ones(size(t)) * .3e-9;
I(1:Tonset*fs) = 0; % delay signal onset
I_stim         = I .* stim_util.pulse(0.05, .1, .04, t); % apply pulse

% Specify VCN neuron type and run the simulation
neuron_type = 'II';
Vm = VCN(-I_stim, neuron_type, fs);

% Visualize
figure;
plot(t, I_stim);
opt.XLabel = 'Time (ms)'; % xlabel
opt.YLabel = 'Current (A)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(I_stim) + min(I_stim)*0.1, max(I_stim) + max(I_stim)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

figure;
plot(t, Vm);
opt.XLabel = 'Time, t (ms)'; % xlabel
opt.YLabel = 'membrane Voltage, V (V)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(Vm) + min(Vm)*0.1, max(Vm) + max(Vm)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

% suptitle({['Type ', neuron_type, ' Model'], '(Phasic Neuron)'});

%% Figure 2C: response to TI stimulation at the superficial regions

% Stimulation signals
stim_util = stim_util();
base_freq = 3000; % Hz
Tonset    = .05; % onset delay

% define the currents (amplitude in Ampere)
I1      = 5e-9 * stim_util.sin(t(1), base_freq, 0, t);
I2      = 5e-9 * stim_util.sin(t(1), base_freq + 30, 0, t);
I       = I1 + I2;

I(1:Tonset*fs) = 0; % delay signal onset
I_stim = I;

% Specify VCN neuron type and run the simulation
neuron_type = 'II';
Vm = VCN(-I_stim, neuron_type, fs);

% Visualize
figure;
plot(t, I_stim);
opt.XLabel = 'Time (ms)'; % xlabel
opt.YLabel = 'Current (A)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(I_stim) + min(I_stim)*0.1, max(I_stim) + max(I_stim)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

figure;
plot(t, Vm);
opt.XLabel = 'Time, t (ms)'; % xlabel
opt.YLabel = 'membrane Voltage, V (V)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(Vm) + min(Vm)*0.1, max(Vm) + max(Vm)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

% suptitle({['Type ', neuron_type, ' Model'], '(Phasic Neuron)'});


%% Figure 2D: response to TI stimulation at depth

% Stimulation signals
stim_util = stim_util();
base_freq = 3000; % Hz
Tonset    = .05; % onset delay

% define the currents (amplitude in Ampere)
I1      = 5e-9 * stim_util.sin(t(1), base_freq, 0, t);
I2      = 5e-9 * stim_util.sin(t(1), base_freq + 30, 0, t);
I       = I1 + I2;

I(1:Tonset*fs) = 0; % delay signal onset
I_stim = I;

% Specify VCN neuron type and run the simulation
neuron_type = 'II';
Vm = VCN(-I_stim, neuron_type, fs);

% Visualize
figure;
% Visualize
figure;
plot(t, I_stim);
opt.XLabel = 'Time (ms)'; % xlabel
opt.YLabel = 'Current (A)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(I_stim) + min(I_stim)*0.1, max(I_stim) + max(I_stim)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

figure;
plot(t, Vm);
opt.XLabel = 'Time, t (ms)'; % xlabel
opt.YLabel = 'membrane Voltage, V (V)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(Vm) + min(Vm)*0.1, max(Vm) + max(Vm)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

% suptitle({['Type ', neuron_type, ' Model'], '(Phasic Neuron)'});


%% Figure 2E: response to direct 10 Hz stimulation

% Stimulation signals
stim_util = stim_util();
base_freq = 10; % Hz
Tonset    = .05; % onset delay

% define the currents (amplitude in Ampere)
I = 5e-9 * stim_util.sin(t(1), base_freq, 0, t);
I(1:Tonset*fs) = 0; % delay signal onset
I_stim = I;

% Specify VCN neuron type and run the simulation
neuron_type = 'II';
Vm = VCN(-I_stim, neuron_type, fs);

% Visualize
figure;
plot(t, I_stim);
opt.XLabel = 'Time (ms)'; % xlabel
opt.YLabel = 'Current (A)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(I_stim) + min(I_stim)*0.1, max(I_stim) + max(I_stim)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

figure;
plot(t, Vm);
opt.XLabel = 'Time, t (ms)'; % xlabel
opt.YLabel = 'membrane Voltage, V (V)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(Vm) + min(Vm)*0.1, max(Vm) + max(Vm)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

% suptitle({['Type ', neuron_type, ' Model'], '(Phasic Neuron)'});


%% Figure 2E: response to AM 10 Hz stimulation

% Stimulation signals
stim_util = stim_util();
base_freq = 3000; % Hz
Tonset    = .05; % onset delay

% define the currents (amplitude in Ampere)
I1      = 5e-9 * stim_util.sin(t(1), base_freq, 0, t);
I2      = 5e-9 * stim_util.sin(t(1), base_freq + 10, 0, t);
I       = I1 + I2;

I(1:Tonset*fs) = 0; % delay signal onset
I_stim = I;

% Specify VCN neuron type and run the simulation
neuron_type = 'II';
Vm = VCN(-I_stim, neuron_type, fs);

% Visualize
figure;
plot(t, I_stim);
opt.XLabel = 'Time (ms)'; % xlabel
opt.YLabel = 'Current (A)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(I_stim) + min(I_stim)*0.1, max(I_stim) + max(I_stim)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

figure;
plot(t, Vm);
opt.XLabel = 'Time, t (ms)'; % xlabel
opt.YLabel = 'membrane Voltage, V (V)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(Vm) + min(Vm)*0.1, max(Vm) + max(Vm)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

% suptitle({['Type ', neuron_type, ' Model'], '(Phasic Neuron)'});


%% Figure 3E: respons to ZAP input

% Stimulation signals
stim_util = stim_util();
base_freq = 3000; % Hz
Tonset    = .01; % onset delay

I         = .0015e-9 .* stim_util.chirp(t, .01, t(end), 1000, 'quadratic'); % chirp (ZAP)
I         = I .* stim_util.slope(Tonset, 0.04, t); % apply a slope
I(1:Tonset*fs) = 0; % delay signal onset
I_stim         = I;

% Specify VCN neuron type and run the simulation
neuron_type = 'II';
Vm = VCN(-I_stim, neuron_type, fs);

% Visualize
figure;
plot(t, I_stim);
opt.XLabel = 'Time (ms)'; % xlabel
opt.YLabel = 'Current (A)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(I_stim) + min(I_stim)*0.1, max(I_stim) + max(I_stim)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

figure;
plot(t, Vm);
opt.XLabel = 'Time, t (ms)'; % xlabel
opt.YLabel = 'membrane Voltage, V (V)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(Vm) + min(Vm)*0.1, max(Vm) + max(Vm)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

% suptitle({['Type ', neuron_type, ' Model'], '(Phasic Neuron)'});


%% Figure 3F: response to AMZAP input

% Stimulation signals
stim_util = stim_util();
base_freq = 3000; % Hz
Tonset    = .01; % onset delay

I1         = .0015e-9 .* stim_util.chirp(t, base_freq+1, t(end), base_freq+1000, 'quadratic'); % chirp (ZAP
I1         = I1 .* stim_util.slope(Tonset, 0.04, t); % apply a slope
I2         = .0015e-9 * stim_util.sin(t(1), base_freq, 0, t);
I = I1 + I2;

I(1:Tonset*fs) = 0; % delay signal onset
I_stim         = I;

% Specify VCN neuron type and run the simulation
neuron_type = 'II';
Vm = VCN(-I_stim, neuron_type, fs);

% Visualize
% Visualize
figure;
plot(t, I_stim);
opt.XLabel = 'Time (ms)'; % xlabel
opt.YLabel = 'Current (A)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(I_stim) + min(I_stim)*0.1, max(I_stim) + max(I_stim)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

figure;
plot(t, Vm);
opt.XLabel = 'Time, t (ms)'; % xlabel
opt.YLabel = 'membrane Voltage, V (V)'; %ylabel
opt.XLim = [0, tend]; % set x axis limit
opt.YLim = [min(Vm) + min(Vm)*0.1, max(Vm) + max(Vm)*0.1]; % set y axis limit
% opt.FileName = 'plotAxisLimit.jpg'; % uncomment to save
setPlotProp(opt);

% suptitle({['Type ', neuron_type, ' Model'], '(Phasic Neuron)'});

