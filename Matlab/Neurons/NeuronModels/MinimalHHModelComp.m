%% Minimal HH model

close all

% initializing simulation param
tend = 300;
fs   = 100;
dt   = 1/fs;
t    = 0:dt:tend-dt;
N    = numel(t); 

% initialize stimulaiton current
% I_stim1 = 70;   % nA 
% freq1   = 1;    % 0.01 => 10 Hz
% I1      = I_stim1 * sin(2*pi*freq1*t);
% 
% I_stim2 = 70;   % nA 
% freq2   = 1.01;    % 0.01 => 10 Hz
% I2      = I_stim2 * sin(2*pi*freq2*t);
% 
% I = I1 + I2;
I = ones(1,N)*2000;

% initializing cell params
% variable = value xxx Unit
L      = 61.4;    % um
gL     = 2.05e-5; % S/cm^2
EL     = -70.3;   % mV
gNA    = 0.056;   % S/cm^2
ENA    = 50;      % mV
VT     = -56.2;   % mV
gKd    = 0.006;   % S/cm^2
EK     = -90;     % mV
gM     = 7.5e-5;  % S/cm^2
taumax = 608;     % ms
C      = 1;       % uF/cm^2
u      = 0;       % mV -> initial membrane potential (0)

% Other initialization
% Na channel
m = ones(N,1);
h = ones(N,1);
aM = (-0.32*(u - VT - 13))/(exp(-(u - VT - 13)/4)-1);
bM = (0.28*(u - VT - 40))/(exp((u - VT - 40)/5)-1);
aH = 0.128 * exp(-(u - VT - 17)/18);
bH = 4/(1+exp(-(u - VT - 40)/5));

% delayed-rectifier K current
n  = ones(N,1);
aN = (-0.032*(u - VT - 15))/(exp(-(u - VT - 15)/5)-1);
bN = 0.5 * exp(-(u - VT - 10)/40);

% slow non-inactivating K current
p    = ones(N,1);
ps   = 1/(1+exp(-(u+35)/10)); % P steady-state
taup = taumax/(3.3 * exp((u + 35)/20) + exp(-(u + 35)/20));

% Ca current to generate bursting
q  = ones(N,1);
r  = ones(N,1);
aQ = (0.055*(-27 - u))/(exp((-27 - u)/3.8)-1);
bQ = 0.94 * exp((-75 - u)/17);
aR = 0.000457 * exp((-13 - u)/50);
bR = 0.0065/(exp((-15 - u)/28)+1);

% low-threshold Ca burst -> modeling rebound burst
uT   = ones(N,1);
Vx   = 2; % mV
ss   = 1/(1 + exp(-(u + Vx + 57)/6.2)); % s steady-state
us   = 1/(1+exp((u + Vx + 81)/4)); % u steady-state
tauu = (30.8 + (211.4 + exp((u + Vx + 113.2)/5)))/(3.7*(1+exp((u + Vx + 84)/3.2))); 

m(1) = aM/(aM+bM);
h(1) = aH/(aH+bH);
n(1) = aN/(aN+bN);

u    = ones(N,1);
Ina  = ones(N,1);
Ikd  = ones(N,1);
Im   = ones(N,1);

for i=1:N-1
    
    % Na
    aM = (-0.32*(u(i) - VT - 13))/(exp(-(u(i) - VT - 13)/4)-1);
    bM = (0.28*(u(i) - VT - 40))/(exp((u(i) - VT - 40)/5)-1);
    aH = 0.128 * exp(-(u(i) - VT - 17)/18);
    bH = 4/(1+exp(-(u(i) - VT - 40)/5));

    % Kd
    aN = (-0.032*(u(i) - VT - 15))/(exp(-(u(i) - VT - 15)/5)-1);
    bN = 0.5 * exp(-(u(i) - VT - 10)/40);
    
    % M
    ps   = 1/(1+exp(-(u(i)+35)/10)); % P steady-state
    taup = taumax/(3.3 * exp((u(i) + 35)/20) + exp(-(u(i) + 35)/20));
    
    % Na
    m(i+1) = (aM*(1-m(i))-bM*m(i)) * dt + m(i);
    h(i+1) = (aH*(1-h(i))-bH*h(i)) * dt + h(i); 
    
    % Kd
    n(i+1) = (aN*(1-n(i))-bN*n(i)) * dt + n(i);   
    
    % M
    p(i+1) = ((ps - p(i))/taup) * dt + p(i);
    
    %lets compute the condictances
    Ina(i) = gNA*(m(i)^3)*h(i)*(u(i)-ENA);
    Ikd(i) = gKd*(n(i)^4)*(u(i)-EK);
    Im(i)  = gM*p(i)*(u(i)-EK);
    
    dudt = (-gL*(u(i)-EL)-Ina(i)-Ikd(i)-Im(i))/C;
    u(i+1) = u(i)+ dt*dudt;
end

u   = u - 69;

figure(1);
subplot(5,1,[1, 2]); plot(t, I); ylim([min(I)-10,max(I)+10]); grid;
legend('Current Density', 'Location','northeast');
ylabel({'$I(\mu A/cm^2)$'},'Interpreter','latex');

subplot(5,1,[3, 4, 5]); plot(t,u); ylim([-100, 60]); grid;
legend('Action Potential', 'Location','northeast')
xlabel({'$Time (ms)$'},'Interpreter','latex');
ylabel({'$V_m (mV)$'},'Interpreter','latex');

suptitle({'Hodgkin Huxley Model', '(Giant Squid Axon)'});