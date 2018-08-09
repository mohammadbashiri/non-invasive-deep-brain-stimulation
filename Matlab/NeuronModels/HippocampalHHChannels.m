%% Hippocampal (and Pyramidal) HH model

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
I = ones(1,N)*10;

% initializing cell params
% variable = value xxx Unit
gNA = 0.003;  % mho/cm^2
gK  = 0.005;  % mho/cm^2
ENA = 50;   % mV
EK  = -12;  % mV
T   = 12;   % temperature
VT = -63;   % vtraub

tadj = 3.0 ^ ((T-36)/ 10 );

gL  = 0.3;  % m.mho/cm^2
EL  = 10.6; % mV
C   = 1;    % uF/cm^2

% Other initialization
% Na channel
m = zeros(N,1);
h = zeros(N,1);

% delayed-rectifier K current
n  = zeros(N,1);

% slow non-inactivating K current
p    = zeros(N,1);

u    = zeros(N,1) - 90;
Ina  = zeros(N,1);
Ikd  = zeros(N,1);
Im   = zeros(N,1);

for i = 1:N-1
    
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
    
    dudt   = (I(i) - (Ina(i) + Ikd(i) + Im(i) + gL*(u(i)-EL)))/C;
    u(i+1) = u(i) + dt * dudt;
end

u   = u - 69;

figure(1);
subplot(5,1,[1, 2]); plot(t, I); ylim([min(I)-10,max(I)+10]); grid;
legend('Current Density', 'Location','northeast');
ylabel({'$I(\mu A/cm^2)$'},'Interpreter','latex');

subplot(5,1,[3, 4, 5]); plot(t, u); ylim([-100, 60]); grid;
legend('Action Potential', 'Location','northeast')
xlabel({'$Time (ms)$'},'Interpreter','latex');
ylabel({'$V_m (mV)$'},'Interpreter','latex');

suptitle({'Hodgkin Huxley Model', '(Giant Squid Axon)'});