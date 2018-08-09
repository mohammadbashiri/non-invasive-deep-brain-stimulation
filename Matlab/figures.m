%% MHH model simulation

% initializing simulation param
tend = 20000;
fs   = 100;
dt   = 1/fs; % 0.01
t = 0:dt:tend-dt;

slope = 1000e-5; % this is in the units of the current over time!
stim_freq = 1.0; % kHz

I_stim = 32;  %31.45;

% initialize stimulaiton current
I_stim1 = I_stim / 2;    % nA 
freq1   = stim_freq;     % 0.01 => 10 Hz

I_stim2 = I_stim / 2 * 0;    % nA 
freq2   = stim_freq + .0;    % 0.01 => 10 Hz

I_stim3 = 0;       % nA 
freq3   = stim_freq + .02;    % 0.01 => 10 Hz


% plot(t/1000, chirp(t, 0.0001, tend, .02))
MHH( I_stim1, freq1, I_stim2, freq2, I_stim3, freq3, tend, dt, slope );

% xticks(0:20:tend);
% xticklabels({round(linspace(f_start,f_end, length(0:20:tend)))});
% xlabel('Frequency [Hz]');

%% VCN simulation