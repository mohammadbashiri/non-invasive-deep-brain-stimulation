%% Addaptive Exponential I&F Model

% Author: Mohammad Bashiri
%
% 
%
%
%

close all

% choose the type
type = 6;

% Store all the parameters here
% ========  R    VT   dT   tauw    taum     a      b   Vrest    Vr  vpeak =================================
params = [ .5,  -50,   2,    30,     20,    0,    60,    -70,  -55,     0;...  % 1) Tonic
           .5,  -50,   2,   100,    200,    0,     5,    -70,  -55,     0;...  % 2) Adapting
           .5,  -50,   2,   100,      5,   .5,     7,    -70,  -51,     0;...  % 2) Init. burst
           .5,  -50,   2,   100,      5,  -.5,     7,    -70,  -46,     0;...  % 3) bursting
           .5,  -50,   2,   100,    9.9,  -.5,     7,    -70,  -46,     0;...  % 3) Irregular
           .5,  -50,   2,   100,     10,    1,    10,    -70,  -60,     0;...  % 3) Transient
           .5,  -50,   2,   100,      5,   -1,    10,    -70,  -60,     0];    % 4) Delayed
      
      
% ============= Model Names ===============
model_name = {'Tonic',...
              'Adapting',...
              'Init. burst',...
              'bursting',...
              'Irregular',...
              'Transient',...
              'Delayed',...
              };

% initializing simulation param
tend = 1000;
fs   = 1000;
dt   = 1/fs;
t    = 0:dt:tend-dt;
N    = numel(t);

% Stimulations current
I_stim = 55; % * 1e-12; %pA - Injected Current
I = [ones(1, 20*fs)*0,...
     ones(1, (tend-20)*fs)*I_stim];

f_start = .001; % kHz
f_end   = .1;  % kHz
I       = .1 * I_stim * genChirp(t, f_start, tend, f_end); % nA sub: -.15 

% initializations
R     = params(type, 1); % * 1e-12;  % pF - membrane capacitance
VT    = params(type, 2); %* 1e-3;    % mV - 
dT    = params(type, 3); %* 1e-3;    % mV - 
tauw  = params(type, 4); %* 1e-3;    % ms - adaptation time-constant
taum  = params(type, 5);
a     = params(type, 6); %* 1e-9;    % nS - subthreshold oscillation parameter
b     = params(type, 7); %* 1e-12;   % pA - spike-triggered adaptation constants
Vrest = params(type, 8); %* 1e-3;    % mV
Vr    = params(type, 9); %* 1e-3;    % mV
vpeak = params(type, 10); %* 1e-3;   % mV

v = ones(1,N) * Vrest;
w = zeros(1,N);

for i=1:N-1
    
    f    = -(v(i) - Vrest) + dT * exp((v(i) - VT)/dT);
    dvdt = (f - R * w(i) + R * I(i))/taum;
    v(i+1) = v(i) + dvdt  * dt;
    
    dwdt = ((a * (v(i) - Vrest) - w(i)) / tauw);
    w(i+1) = w(i) + dwdt * dt;
    
    if v(i+1) > vpeak
        v(i) = vpeak;
        v(i+1) = Vr;
        w(i+1) = w(i+1) + b;
    end
end


figure(1);
subplot(5,1,[1, 2]); plot(t, I); xlim([0, max(t)]); grid;
legend('Current Density', 'Location','northeast');
ylabel({'$I(pA)$'},'Interpreter','latex');

subplot(5,1,[3, 4, 5]); plot(t, v); grid; % ylim([-100, 10]);  xlim([0, max(t)]);
legend('Action Potential','Location','northeast')
xlabel({'$Time (ms)$'},'Interpreter','latex');
ylabel({'$V_m (mV)$'},'Interpreter','latex');

suptitle({'Adaptive Exponential IF', strcat('(', model_name{type}, ')')});