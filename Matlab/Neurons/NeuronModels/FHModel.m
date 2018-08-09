%% Frankenhaeuser and Huzley Model

clear all; close all;

% global variables
global celcius; % temperature
global F; %Faraday constant
global R; % gas constant

% initializing simulation param
tstop = 300;
dt    = 0.01; % ms
t     = 0:dt:tstop-dt;
N     = numel(t); 

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
I = ones(1,N)*0;

% Parameters
% var   = value       % Unit
F       = 96485.3329; % Faraday's constant - coulombs
R       = 8.3144598;  % gas constant - J K^-1 mol^-1
celcius = 20;         % body temperature - Celcius
gl      = 30.3;    % m.mho/cm^2
el      = 0.026;      % mV
Cm      = 2;          % uF/cm^2
pnabar  = 8e-3;
ppbar   = 0.54e-3;
pkbar   = 1.2e-3;
nao     = 114.5;
nai     = 13.74;
ko      = 2.5;
ki      = 120;

% Gating variables - STATE
m    = zeros(N,1);
h    = zeros(N,1);
p    = zeros(N,1);
n    = zeros(N,1);

% Membrane voltage
er   = -70; % resting potential
v    = ones(N,1)*er;

h(1)    = 0.8249;
m(1)    = 0.0005;
n(1)    = 0.0268;
p(1)    = 0.0049;

for i=1:N-1
    
    aM = alp(v(i), 1);
    bM = bet(v(i), 1);
    aH = alp(v(i), 2);
    bH = bet(v(i), 2);
    aN = alp(v(i), 3);
    bN = bet(v(i), 3);
    aP = alp(v(i), 4);
    bP = bet(v(i), 4);
    
    tau(1) = 1/(aM + bM); inf(1) = aM/(aM + bM);
    tau(2) = 1/(aH + bH); inf(2) = aH/(aH + bH);
    tau(3) = 1/(aN + bN); inf(3) = aN/(aN + bN);
    tau(4) = 1/(aP + bP); inf(4) = aP/(aP + bP);
        
    % STATE update - DONE
    m(i+1) = ((inf(1) - m(i))/tau(1)) * dt + m(i);
    h(i+1) = ((inf(2) - h(i))/tau(2)) * dt + h(i);    
    n(i+1) = ((inf(3) - n(i))/tau(3)) * dt + n(i);
    p(i+1) = ((inf(4) - p(i))/tau(4)) * dt + p(i);
       
    % BREAKPOINT
    ghkna = ghk(v(i), nai, nao); 
    ina  = pnabar * m(i) * m(i) * h(i) * ghkna;
    ip   = ppbar * p(i) * p(i) * ghkna;
    ik   = pkbar * n(i) * n(i) * ghk(v(i), ki, ko);
    il   = gl * (v(i) - el);
    
    dvdt = (I(i) - (ina + ik + ip + il))/Cm;
    v(i+1) = v(i)+ dt*dvdt;
end

plot(v);

%% Functions

function alpout = alp(v, i)
% order: m, h, n, p
    global celcius; 
    v = v + 70;
    q10 = 3 ^ ((celcius -20)/10);

    if(i==1) % m
        a = .36; b = 22; c = 3;
        alpout = q10 * a * expM1(b - v, c);
    elseif(i==2) % h
        a = .1; b = -10; c = 6;
        alpout = q10 * a * expM1(v - b, c);
    elseif(i==3) % n
        a = .02; b = 35; c = 10;
        alpout = q10 * a * expM1(b - v, c);
    else % p
        a = .006; b = 40; c = 10;
        alpout = q10 * a * expM1(b - v, c);
    end

end


function betout = bet(v, i)

    global celcius;
    v = v + 70;
    q10 = 3 ^ ((celcius -20)/10);

    if(i==1) % m
        a = .4; b = 13; c = 20;
        betout = q10 * a * expM1(v - b, c);
    elseif(i==2) % h
        a = 4.5; b = 45; c = 10;
        betout = q10 * a / (exp((b - v)/c) + 1);
    elseif(i==3) % n
        a = .05; b = 10; c = 10;
        betout = q10 * a * expM1(v - b, c);
    else % p
        a = .09; b = -25; c = 20;
        betout = q10 * a * expM1(v - b, c);
    end
    
end

function expout = expM1(x, y)
   
    if (abs(x/y) < 1e-6)
       expout = y * (1 - x/y/2); 
    else
        expout = x/(exp(x/y) - 1);
    end
    
end


function ghkout = ghk(v, ci, co) % there seems to be something wrong here!

    global F; global R; global celcius;
    v = v + 70;
    z = (1e-3)*F*v/(R*(celcius+273.15));
    eco = co * efun(z);
    eci = ci * efun(-z);
    ghkout = (.001) * F * (eci - eco);

end

function efunout = efun(z)

    if (abs(z) < 1e-4)
        efunout = 1 - z/2;
    else
        efunout = z/(exp(z) - 1);
    end
    
end