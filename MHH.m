function [ ] = MHH( I_stim1, freq1, I_stim2, freq2, I_stim3, freq3, tend, dt, slope )
%MHH Summary of this function goes here
%   Detailed explanation goes here

% time is in millisecond
% frequency is in kHz

% initialization
fs   = 1/dt;
t    = 0:dt:tend-dt;
N    = numel(t);
T_on = 50;

% initialize stimulaiton current
I1      = I_stim1 * sin(2*pi*freq1*t);
I2      = I_stim2 * sin(2*pi*freq2*t);
I3      = I_stim3 * sin(2*pi*freq3*t);

I = I1 + I2 + I3;
% I = ones(1,N)*1.2;

I(1:T_on*fs) = 0; % No stimulation first 50 miliseconds to zero

% compute the ramp
ramp = ones(1,N);
ramp(1:T_on*fs) = 0;
ramp_val = 0:slope:1;
ramp(T_on*fs+1:T_on*fs+numel(ramp_val)) = ramp_val;
figure; plot(t, ramp);

% size(ramp)
I = I .* ramp; 

% initializing cell params
% variable = value xxx Unit
gNA = 240;  % m.mho/cm^2
gK  = 36;   % m.mho/cm^2
gA  = 61;   % m.mho/cm^2
gL  = 0.068;  % m.mho/cm^2
ENA = 64.7;  % mV  +64.7 + 71   
EK  = -95.2;  % mV  -95.2 + 71
EL  = -51.3; % mV  -51.3 + 71
C   = 1;    % uF/cm^2
Er  = -71;

% Other initialization
m = zeros(N,1);
n = zeros(N,1);
a = zeros(N,1);
b = zeros(N,1);
h = zeros(N,1);

u    = ones(N,1)*Er;
INA  = zeros(N,1);
IK   = zeros(N,1);
IA   = zeros(N,1);


for i=1:N-1

    aM = 11.3/expe((-53-u(i))/6);
    bM = 37.4/expe((57+u(i))/9);
    aH = 5/expe((u(i)+106)/9);
    bH = 22.6/(exp((-22-u(i))/12.5)+1);
    
    n_inf  = 1/(1 + exp((1.7-u(i))/11.4));
    tau_n  = 0.24 + 0.7/(1 + exp((u(i) + 12)/16.4));
    
    a_inf  = 1/(1+exp((-55-u(i))/13.8));
    b_inf  = 1/(1+exp((77+u(i))/7.8));
    tau_a  = 0.12 + 0.6/(1+exp((u(i)+24)/16.5));
    tau_b  = 2.1 + 1.8/(1+exp((u(i)-18)/5.7));
    
    tau_m  = 1/(aM + bM);
    m_inf  = aM * tau_m;
    
    tau_h  = 1/(aH + bH);
    h_inf  = aH * tau_h;
    
    % Update the gating variables
    n(i+1) = ((n_inf - n(i))/tau_n) * dt + n(i);
    a(i+1) = ((a_inf - a(i))/tau_a) * dt + a(i);
    b(i+1) = ((b_inf - b(i))/tau_b) * dt + b(i);
    m(i+1) = ((m_inf - m(i))/tau_m) * dt + m(i);
    h(i+1) = ((h_inf - h(i))/tau_h) * dt + h(i);
    
    %Compute the currents
    INA(i) = gNA*(m(i)^3)*h(i)*(ENA-u(i));
    IK(i)  = gK*(n(i)^3)*(EK-u(i));
    IA(i)  = gA*(a(i)^4)*b(i)*(EK-u(i));
    IL     = gL*(EL-u(i));
    
    dudt   = (INA(i) + IK(i) + IA(i) + IL + I(i))/C;
    u(i+1) = u(i)+ dt*dudt;
end

figure;
subplot(5,1,[1, 2]); plot(t, I); ylim([min(I)-10,max(I)+10]); grid; ylim([-100 100]);
legend('Current Density', 'Location', 'northwest');
ylabel({'$I(\mu A/cm^2)$'},'Interpreter','latex');

subplot(5,1,[3, 4, 5]); plot(t, u); ylim([-100, 60]); grid;
legend('Action Potential', 'Location', 'northwest')
xlabel({'$Time (ms)$'},'Interpreter','latex');
ylabel({'$V_m (mV)$'},'Interpreter','latex');

suptitle({'Hodgkin Huxley Model', '(Mammalian Neuron)'});

%% Function

end

function expout = expe(x)

    if ( x == 0)
        expout = 1;
    else
        expout = (exp(x) - 1)/x;
    end
    
end

