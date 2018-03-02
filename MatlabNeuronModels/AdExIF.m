%% Addaptive Exponential I&F Model

% Author: Mohammad Bashiri
%
% 
%
%
%

close all

% choose the type
type = 1;

% Store all the parameters here
% ========  C    gL     EL      VT   dT   tauw     a      b   vpeak =================================
params = [281,   30, -70.6,  -50.4,   2,   144,    4,  80.5,     20;...  % 1) Phasic spiking
          281,   30, -70.6,  -50.4,   2,    20,    4,   500,     20;...  % 2) Tonic bursting
          281,   30, -70.6,  -50.4,   2,   144,    4,   100,     20;...  % 3) Phasic bursting
          281,   30,   -60,    -54,   2,   150,  200,   100,     20];    % 4) Post-inhibitory rebound

% ============= Model Names ===============
model_name = {'Phasic spiking',...
              'Tonic bursting',...
              'Phasic bursting',...
              'Post-inhibitory rebound',...
              };

% initializing simulation param
tend = 1000;
fs   = 1000;
dt   = 1/fs;
t    = 0:dt:tend-dt;
N    = numel(t);

% Stimulation current
I_stim = 900; % * 1e-12; %pA - Injected Current
I = [ones(1, 0.01*N)*0,...
    ones(1, 0.1*N)*I_stim/2,...
    ones(1, 0.19*N)*0,...
    ones(1, 0.5*N)*I_stim,...
    ones(1, 0.2*N)*0];

f_start = .001; % kHz
f_end   = .1;  % kHz
I       = .1 * I_stim * genChirp(t, f_start, tend, f_end); % nA sub: -.15

% initializations
C     = params(type, 1); % * 1e-12;  % pF - membrane capacitance
gL    = params(type, 2); %* 1e-9;    % nS - leak conductance
EL    = params(type, 3); %* 1e-3;    % mV - 
VT    = params(type, 4); %* 1e-3;    % mV - 
dT    = params(type, 5); %* 1e-3;    % mV - 
tauw  = params(type, 6); %* 1e-3;    % ms - adaptation time-constant
a     = params(type, 7); %* 1e-9;    % nS - subthreshold oscillation parameter
b     = params(type, 8); %* 1e-12;   % pA - spike-triggered adaptation constants
vpeak = params(type, 9); %* 1e-3;    % mV

v = ones(1,N) * EL;
w = zeros(1,N);

for i=1:N-1
    
    f    = -gL * (v(i) - EL) + gL * dT * exp((v(i) - VT)/dT);
    dvdt = ((f - w(i) + I(i))/C) * dt;
    v(i+1) = v(i) + dvdt;
    
    dwdt = ((a * (v(i) - EL) - w(i)) / tauw) * dt;
    w(i+1) = w(i) + dwdt;
    
    if v(i+1) > vpeak
        
        v(i) = vpeak;
        
        v(i+1) = EL;     % phasic spiking and post-inhibitory rebound
%         v(i+1) = VT + 5; % tonic bursting
%         v(i+1) = VT + 4; % phasic bursting
        
        w(i+1) = w(i+1) + b;
    end
end


figure(1);
subplot(5,1,[1, 2]); plot(t, I); grid;
legend('Current Density', 'Location','northeast');
ylabel({'$I(pA)$'},'Interpreter','latex');

subplot(5,1,[3, 4, 5]); plot(t, v); grid; % ylim([-100, 50]);
legend('Action Potential','Location','northeast')
xlabel({'$Time (ms)$'},'Interpreter','latex');
ylabel({'$V_m (mV)$'},'Interpreter','latex');

suptitle({'Adaptive Exponential IF', strcat('(', model_name{type}, ')')});