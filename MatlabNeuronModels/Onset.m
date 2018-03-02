% Simplified Onset neuron model
clear all
close all


% initialization
fs   = 1e3;
dt   = 1/fs;
tend = 2 * fs;
t    = 0:dt:tend-dt;
N    = numel(t);
T_on = 50;

% stimulation current
I = ones(N,1) * 1000;


% initializing cell params
% variable = value xxx Unit
gNa   = 1000;  % nS
gLTK  = 200;   % nS
glk   = 2;     % nS
tauE  = .1;    % ms
VNa   = 55;    % mV
VLTK  = -70;   % mV
Vlk   = -65;   % mV
C     = 12;    % pF
Vth   = -62.2; % mV
Vr    = -63.6; % mV

% Other initialization
m = zeros(N,1);
h = zeros(N,1);
w = zeros(N,1);
z = zeros(N,1);

V    = ones(N,1) * Vr;
INa  = zeros(N,1);
ILTK = zeros(N,1);
Ilk  = zeros(N,1);

for i=1:N-1
    
    m_inf  = (1 + exp(-(V(i)+38)/7)) ^ -1;
    tau_m  = 10 / ( 5*exp((V(i)+60)/18) + 36*exp(-(V(i)+60)/25) ) + 0.04;
    
    tau_h  = (1 + exp((V(i)+65)/6)) ^ -1;
    h_inf  = 100 / ( 7*exp((V(i)+60)/11) + 10*exp(-(V(i)+60)/25) ) + 0.6 ;
    
    w_inf  = (1 + exp(-(V(i)+48)/6)) ^ -0.25;
    tau_w  = 100 / ( 6*exp((V(i)+60)/6) + 16*exp(-(V(i)+60)/45) ) + 1.5;
    
    z_inf  = .5 / (1 + exp((V(i)+71)/10)) + 0.5;
    tau_z  = 1000 / ( exp((V(i)+60)/20) + exp(-(V(i)+60)/8) ) + 50;
    
    % Update the gating variables
    m(i+1) = ((m_inf - m(i))/tau_m) * dt + m(i);
    h(i+1) = ((h_inf - h(i))/tau_h) * dt + h(i);
    w(i+1) = ((w_inf - w(i))/tau_w) * dt + w(i);
    z(i+1) = ((z_inf - z(i))/tau_z) * dt + z(i);
    
    %Compute the currents
    ILTK(i)  = gLTK * (w(i)^4) * z(i) * (V(i) - VLTK);
    INa(i)   = gNa * (m(i)^3) * h(i) * (V(i) - VNa);    
    Ilk(i)   = glk * (V(i) - Vlk);
    IE       = I(i);
    
    dVdt   = (ILTK(i) + INa(i) + Ilk(i) + IE)/C;
    V(i+1) = V(i)+ dt*dVdt;
end

figure;
subplot(5,1,[1, 2]); plot(t, I); ylim([min(I)-10,max(I)+10]); grid; ylim([-100 100]);
legend('Current Density', 'Location', 'northwest');
ylabel({'$I(\mu A/cm^2)$'},'Interpreter','latex');

subplot(5,1,[3, 4, 5]); plot(t, V); ylim([-100, 60]); grid;
legend('Action Potential', 'Location', 'northwest')
xlabel({'$Time (ms)$'},'Interpreter','latex');
ylabel({'$V_m (mV)$'},'Interpreter','latex');

suptitle({'Hodgkin Huxley Model', '(Mammalian Neuron)'});