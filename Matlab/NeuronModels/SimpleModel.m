close all

% Store all the parameters here
% ========  C    vr    vt     k      a      b     c     d   vpeak     I =================================
params = [100,  -60,  -40,  0.7,  0.03,    -2,  -50,  100,     35,   70;...  % 1) Regular Spiking Neurons
           30,  -55,  -42,    3,  0.01, -0.25,  -40,   90,     10,  150;...  % 2) Simulation (p. 287)
          150,  -75,  -45,  1.2,  0.01,     5,  -56,  130,     50,  550;...  % 3) Intrinsically Bursting Neurons
           50,  -60,  -40,  1.5,  0.03,     1,  -40,  150,     25,  300];    % 4) Chattering Neurons

% ============= Model Names ===============
model_name = {'Regular Spiking Neurons',...
              'Simulation (p. 287)',...
              'Intrinsically Bursting Neurons',...
              'Chattering Neurons',...
              };

% Choose the neuron canonical type
type_no = 1; % RS

% parameters used for RS
C     = params(type_no, 1); % pF
vr    = params(type_no, 2); % mV
vt    = params(type_no, 3); % mV
k     = params(type_no, 4);

% neocortical pyramidal neurons
a     = params(type_no, 5); % ms
b     = params(type_no, 6);
c     = params(type_no, 7); 
d     = params(type_no, 8);

% spike cutoff
vpeak = params(type_no, 9); % mV 

tend  = 1000;  % ms
fs    = 100;
dt    = 1/fs;
t     = 0:dt:tend-dt;
N     = numel(t);

% initial values
v     = vr * ones(1,N); 
u     = 0 * v; 

% pulse of input DC current
I_stim = params(type_no, 10); 
I = I_stim * ones(1,N);
% I      = [zeros(1,0.1*N), I_stim * ones(1,0.9*N)]; % pA

% % initialize stimulaiton current
% I_stim1 = 450;     % pA 
% freq1   = 1;       % 0.01 => 10 Hz
% I1      = I_stim1 * sin(2*pi*freq1*t);
% 
% I_stim2 = 450;     % nA 
% freq2   = 1.01;    % 0.01 => 10 Hz
% I2      = I_stim2 * sin(2*pi*freq2*t);
% 
% I = I1 + I2;
% % I = I1;

% other variable
spike_count = 0; % to count the number of spikes

for i = 1:N-1 
       
    % forward Euler method
    dvdt   = dt * (k*(v(i)-vr)*(v(i)-vt)-u(i)+I(i))/C;
    v(i+1) = v(i)+ dvdt;
    
    dudt   = dt * a*(b*(v(i)-vr)-u(i));
    u(i+1) = u(i) + dudt;

    if v(i+1) >= vpeak     % a spike is fired!
        
        v(i)   = vpeak;    % padding the spike amplitude
        v(i+1) = c;        % membrane voltage reset
        u(i+1) = u(i+1) + d; % recovery variable update
        spike_count = spike_count + 1;
    
    end
end

% plot the result
subplot(5, 1, [1, 2]); plot(t, I); ylim([min(I)-10,max(I)+10]); grid;
legend('Current Density', 'Location','southeast');
ylabel({'$I(pA)$'},'Interpreter','latex');
% ylabel({'$I(\mu A/cm^2)$'},'Interpreter','latex');

subplot(5, 1, [3, 4, 5]); plot(t, v); grid;
legend('Membrane Potential', 'Location','northeast');
xlabel({'$Time (ms)$'},'Interpreter','latex');
ylabel({'$V_m (mV)$'},'Interpreter','latex');

suptitle({'Simple Model', char(model_name(type_no))});