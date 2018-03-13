function [ ] = VCN( I_stim1, freq1, I_stim2, freq2, I_stim3, freq3,...
                    T, f_s, slope, type )
%VCN_SPIKE Summary of this function goes here
%   Detailed explanation goes here

if strcmp(type, 'I-c')
    
    g_Na = 1000e-9;          %// 1000nS
    g_HT = 150e-9;           %// nS
    g_LT = 0e-9;             %// nS
    g_A  = 0e-9;             %// nS
    g_h  = 0.5e-9;           %// nS
    g_lk = 2e-9;             %// nS
    V_0  = -63.9e-3;         %// -63.9mV   resting potential for START
    
elseif strcmp(type, 'I-t')
        
    g_Na = 1000e-9;          %// 1000nS
    g_HT = 80e-9;            %// nS
    g_LT = 0e-9;             %// nS
    g_A  = 65e-9;            %// nS
    g_h  = 0.5e-9;           %// nS
    g_lk = 2e-9;             %// nS
    V_0  = -64.2e-3;         %// -64.2mV   resting potential for START

elseif strcmp(type, 'I-II')
    disp('we came here!')
    g_Na = 1000e-9;          %// 1000nS
    g_HT = 150e-9;           %// nS
    g_LT = 20e-9;            %// nS
    g_A  = 0e-9;             %// nS
    g_h  = 2e-9;             %// nS
    g_lk = 2e-9;             %// nS
    V_0  = -64.1e-3;         %// -64.1mV   resting potential for START
    
elseif strcmp(type, 'II')
    
    g_Na = 1000e-9;          %// 1000nS
    g_HT = 150e-9;           %// nS
    g_LT = 200e-9;           %// nS Mohd: it was 200e-9!!!!!!!
    g_A  = 0e-9;             %// nS
    g_h  = 20e-9;            %// nS
    g_lk = 2e-9;             %// nS
    V_0  = -63.6e-3;         %// -63.6mV   resting potential for START
    
elseif strcmp(type, 'II-I')
    
    g_Na = 1000e-9;          %// 1000nS
    g_HT = 150e-9;           %// nS
    g_LT = 35e-9;            %// nS
    g_A  = 0e-9;             %// nS
    g_h  = 35e-9;            %// nS
    g_lk = 2e-9;             %// nS
    V_0  = -63.8e-3;         %// -63.8mV   resting potential for START

    
else
    disp('The type is not available!');
    
end
    

% initialization
Tonset = 0e-3;      % s delay onset
t      = (1:T*f_s)/f_s;

% initialize stimulaiton current
I1      = I_stim1; % * cos(2*pi*freq1*t);
I2      = I_stim2 * cos(2*pi*freq2*t);
I3      = I_stim3 * cos(2*pi*freq3*t);

I = I1 + I2 + I3;
I(1:Tonset*f_s) = 0; % No stimulation first 50 miliseconds to zero

% compute the ramp
ramp               = ones(1,numel(I));
ramp(1:Tonset*f_s) = 0;
ramp_val           = 0:slope:1;
ramp(Tonset*f_s+1:Tonset*f_s+numel(ramp_val)) = ramp_val;
figure; plot(t*1000, ramp);

% size(ramp)
I = I .* ramp;

V4 = VCN_I(1e-9*I,  g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);

figure;
subplot(5,1,[1, 2]); plot(t*1000, I); ylim([min(I)-.01,max(I)+.01]); grid; % ylim([-100 100]);
legend('Stimulation Current', 'Location', 'northwest');
ylabel({'$I (nA)$'},'Interpreter','latex');

subplot(5,1,[3, 4, 5]); plot(t*1000, V4*1000); grid; % ylim([-100, 60]);
legend('Action Potential', 'Location', 'southwest')
xlabel({'$Time (ms)$'},'Interpreter','latex');
ylabel({'$Membrane voltage (mV)$'},'Interpreter','latex');

suptitle({['Type ', type, ' Model'], '(Phasic Neuron)'});

end

