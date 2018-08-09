function [ Vm ] = VCN( I_stim, type, f_s )

if strcmp(type, 'I-c')
    
    g_Na = 1000e-9;          %// 1000S
    g_HT = 150e-9;           %// S
    g_LT = 0e-9;             %// S
    g_A  = 0e-9;             %// S
    g_h  = 0.5e-9;           %// S
    g_lk = 2e-9;             %// S
    V_0  = -63.9e-3;         %// -63.9mV   resting potential for START
    
elseif strcmp(type, 'I-t')
        
    g_Na = 1000e-9;          %// 1000S
    g_HT = 80e-9;            %// S
    g_LT = 0e-9;             %// S
    g_A  = 65e-9;            %// S
    g_h  = 0.5e-9;           %// S
    g_lk = 2e-9;             %// S
    V_0  = -64.2e-3;         %// -64.2mV   resting potential for START

elseif strcmp(type, 'I-II')
    disp('we came here!')
    g_Na = 1000e-9;          %// 1000S
    g_HT = 150e-9;           %// S
    g_LT = 20e-9;            %// S
    g_A  = 0e-9;             %// S
    g_h  = 2e-9;             %// S
    g_lk = 2e-9;             %// S
    V_0  = -64.1e-3;         %// -64.1mV   resting potential for START
    
elseif strcmp(type, 'II')
    
    g_Na = 1000e-9;          %// 1000S
    g_HT = 150e-9;           %// S
    g_LT = 200e-9;           %// S 
    g_A  = 0e-9;             %// S
    g_h  = 20e-9;            %// S
    g_lk = 2e-9;             %// S
    V_0  = -63.6e-3;         %// -63.6V   resting potential for START
    
elseif strcmp(type, 'II-I')
    
    g_Na = 1000e-9;          %// 1000S
    g_HT = 150e-9;           %// S
    g_LT = 35e-9;            %// S
    g_A  = 0e-9;             %// S
    g_h  = 35e-9;            %// S
    g_lk = 2e-9;             %// S
    V_0  = -63.8e-3;         %// -63.8V   resting potential for START

    
else
    disp('The type is not available!');
    
end
    
Vm = VCN_I(I_stim,  g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);

end

