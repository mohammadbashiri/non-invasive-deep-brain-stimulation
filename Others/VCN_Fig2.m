% ALL units SI!!! DT,V,tau!!!    Current Injection Experiment
%/*---------------------------------------------------------------------------*/
%/* MAIN VCN Cell.m  From Rothman & Manis                                     */
%//-----------------------------------------------------------------------------
%//------- modified ©2001 Werner Hemmert, Infineon Corporate Research ----------
%//-----------------------------------------------------------------------------
%// 30.10.2003 CN NEURON with ion channels according to Rothman & Manis 2003
%// Uses imputs from multiple ANFs (but from one section only) which are summed 
%// in input_ap (values with 2 APs are possible and linearly integrated)
%//-----------------------------------------------------------------------------
%//--------------------------------------------- basic definitions -------------
%//-----------------------------------------------------------------------------*/
%%                          % ALWAYS start with clean workspace
close all;
clear all;

%%  Define figure size such that you can read the labels in a report/paper
figure;
set(gcf, 'Units', 'Centimeters', 'PaperPositionMode', 'auto')
fontSize = 8;
%
%/*---------------------------------------------------------------------------*/
%/*------------------------------------------- basic definitions -------------*/
%/*---------------------------------------------------------------------------*/

f_s    = 30e3;
T      = 200e-3;     % s observation time
Ton    = 100e-3;     % s injection time
Tonset = 10e-3;      % s delay onset

I_E(1:T*f_s) = 0;
I_E(Tonset*f_s:(Ton+Tonset)*f_s) = 1;
t = (1:size(I_E,2))/f_s;

%//------------- Type I-c cell -----------------------------------------------*/
g_Na = 1000e-9;          %// 1000nS
g_HT = 150e-9;           %// nS
g_LT = 0e-9;             %// nS
g_A  = 0e-9;             %// nS
g_h  = 0.5e-9;           %// nS
g_lk = 2e-9;             %// nS
V_0  = -63.9e-3;         %// -63.9mV   resting potential for START


V1 = VCN_I(-50e-12*I_E, g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);
V2 = VCN_I(+50e-12*I_E, g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);

subplot(2,2,1);
plot(t*1000,V1*1000,...
     t*1000,V2*1000, [0 100],[46.9 46.9]);
title('Type I-c Model')
xlabel('time (ms)')
ylabel('membrane voltage (mV)')


%//------------- Type I-t cell -----------------------------------------------*/
g_Na = 1000e-9;          %// 1000nS
g_HT = 80e-9;            %// nS
g_LT = 0e-9;             %// nS
g_A  = 65e-9;            %// nS
g_h  = 0.5e-9;           %// nS
g_lk = 2e-9;             %// nS
V_0  = -64.2e-3;         %// -64.2mV   resting potential for START


V1 = VCN_I(-50e-12*I_E, g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);
V2 = VCN_I(+50e-12*I_E, g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);

subplot(2,2,2);
plot(t*1000,V1*1000,...
     t*1000,V2*1000, [0 100], [46.9 46.9]);
title('Type I-t Model')
xlabel('time (ms)')
ylabel('membrane voltage (mV)')


%//------------- Type II cell -----------------------------------------------*/
g_Na = 1000e-9;          %// 1000nS
g_HT = 150e-9;           %// nS
g_LT = 200e-9;           %// nS
g_A  = 0e-9;             %// nS
g_h  = 20e-9;            %// nS
g_lk = 2e-9;             %// nS
V_0  = -63.6e-3;         %// -63.6mV   resting potential for START


V1 = VCN_I(-300e-12*I_E, g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);
V2 = VCN_I(+300e-12*I_E, g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);
V3 = VCN_I(-600e-12*I_E, g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);

I_E2 = I_E;
I_E2((Ton/2+Tonset)*f_s:(Ton+Tonset)*f_s) = 3;
V4 = VCN_I(-300e-12*I_E2, g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);

subplot(2,2,3)
plot(t*1000, V1*1000,...  
     t*1000, V2*1000,...
     t*1000, V3*1000,...
     t*1000, V4*1000, [0 100],[46.9 46.9])
title('Type II Model')
xlabel('time (ms)')
ylabel('membrane voltage (mV)')


%//------------- Type I-II cell -----------------------------------------------*/
g_Na = 1000e-9;          %// 1000nS
g_HT = 150e-9;           %// nS
g_LT = 20e-9;            %// nS
g_A  = 0e-9;             %// nS
g_h  = 2e-9;             %// nS
g_lk = 2e-9;             %// nS
V_0  = -64.1e-3;         %// -64.1mV   resting potential for START

V1 = VCN_I(-100e-12*I_E,  g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);
V2 = VCN_I(+100e-12*I_E,  g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);
V3 = VCN_I(-150e-12*I_E,  g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);
V4 = VCN_I(+150e-12*I_E,  g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s);
% figure; plot(I_E);
subplot(2,2,4)
plot(t*1000, V1*1000,...  
     t*1000, V2*1000,...
     t*1000, V3*1000,...
     t*1000, V4*1000, [0 100],[46.9 46.9])
title('Type I-II Model')
xlabel('time (ms)')
ylabel('membrane voltage (mV)')

print('TypeII', '-depsc')               % create scaleable figure
% print('TypeII', '-dtiff', '-r300')    % creates pixel figure
% print('TypeII', '-dmeta')             % windows only: emf

%/*---------------------------------------------------------------------------*/
