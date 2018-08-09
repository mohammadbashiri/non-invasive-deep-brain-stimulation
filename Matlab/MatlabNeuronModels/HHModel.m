close all

% initializing simulation param
tend = 300;
fs   = 100;
dt   = 1/fs;
t    = 0:dt:tend-dt;
N    = numel(t); 

% initialize stimulaiton current
I_stim1 = 50;   % nA 
freq1   = 1;    % 0.01 => 10 Hz
I1      = I_stim1 * sin(2*pi*freq1*t);

I_stim2 = 50;   % nA 
freq2   = 1.01;    % 0.01 => 10 Hz
I2      = I_stim2 * sin(2*pi*freq2*t);

I = I1 + I2;
% I = ones(1,N)*10;

% initializing cell params
% variable = value xxx Unit
gNA = 120;  % m.mho/cm^2
gK  = 36;   % m.mho/cm^2
gL  = 0.3;  % m.mho/cm^2
ENA = 115;  % mV
EK  = -12;  % mV
EL  = 10.6; % mV
C   = 1;    % uF/cm^2

% Other initialization
m = zeros(N,1);
n = zeros(N,1);
h = zeros(N,1);
% u = 0;
% aN = (0.01*(10-u))/(exp((10-u)/10)-1);
% bN = 0.125*exp(-u/80);
% aM = (0.1*(25-u))/(exp((25-u)/10)-1);
% bM = 4.0*exp(u/18);
% aH = 0.07*exp(u/20);
% bH = 1/(exp((30-u)/10)+1);
% 
% n(1) = aN/(aN+bN);
% m(1) = aM/(aM+bM);
% h(1) = aH/(aH+bH);

u    = zeros(N,1);
cNA  = zeros(N,1);
cK   = zeros(N,1);

for i=1:N-1
    aN = (0.01*(10-u(i)))/(exp((10-u(i))/10)-1);
    bN = 0.125*exp(-u(i)/80);
    aM = (0.1*(25-u(i)))/(exp((25-u(i))/10)-1);
    bM = 4.0*exp(-u(i)/18);
    aH = 0.07*exp(-u(i)/20);
    bH = 1/(exp((30-u(i))/10)+1);
    
    m(i+1) = (aM*(1-m(i))-bM*m(i)) * dt + m(i);
    n(i+1) = (aN*(1-n(i))-bN*n(i)) * dt + n(i);
    h(i+1) = (aH*(1-h(i))-bH*h(i)) * dt + h(i);    
    
    %lets compute the condictances
    cNA(i) = gNA*(m(i)^3)*h(i);
    cK(i) = gK*(n(i)^4);
    
    dudt = (I(i) -(cNA(i)*(u(i)-ENA)+cK(i)*(u(i)-EK)+gL*(u(i)-EL)))/C;
    u(i+1) = u(i)+ dt*dudt;
end

cNA = gNA*(m.^3).*h;
cK  = gK*(n.^4);
iNA = cNA.*(u-ENA);
iK  = cK.*(u-EK);
iL  = gL.*(u-EL);

u   = u - 69;
cNA = cNA - 69;
cK  = cK - 69;

figure(1);
subplot(5,1,[1, 2]); plot(t, I); ylim([min(I)-10,max(I)+10]); grid;
legend('Current Density', 'Location','northeast');
ylabel({'$I(\mu A/cm^2)$'},'Interpreter','latex');

subplot(5,1,[3, 4, 5]); plot(t,u, t, cNA, t, cK); ylim([-100, 60]); grid;
legend('Action Potential','Na Conductivity','K Conductivity','Location','northeast')
xlabel({'$Time (ms)$'},'Interpreter','latex');
ylabel({'$V_m (mV)$'},'Interpreter','latex');

suptitle({'Hodgkin Huxley Model', '(Giant Squid Axon)'});

% figure(2); hold on;
% plot(t, m, t, h, t, n);
% xlim([0,70])

% figure(3); hold on;
% plot(t, iNA, t, iK, t, iL, t, 10*(iK+iNA));
% xlim([40,70]);