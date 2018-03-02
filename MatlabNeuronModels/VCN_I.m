function V_ = VCN_I(I_input_,  g_Na,g_HT,g_LT,g_A,g_h,g_lk,V_0, f_s)
% NEW: There is also VCN_I_c.c, hopefully COMPATIBLE!!!

% SBR call from Type_Ic_Fig2.m  !!! calculate time response of VCN cell for current injection
% ALL units SI!!! DT,V,tau!!!
%  m_inf=1./(1+exp(-(V+38e-3)/7e-3));  % fast Na+  NO BUG in PAPER!!
%  b_inf=(1+exp(-(V+66e-3)/7e-3))^-0.5;  % BUG bis 5.11.2003
%  h_inf=1./(1+exp(-(V+65e-3)/6e-3));    % BUG bis 5.11.2003
%->  b_inf=(1+exp( (V+66e-3)/7e-3))^-0.5;  % BUG bis 5.11.2003
%->  h_inf=1./(1+exp( (V+65e-3)/6e-3));    % BUG bis 5.11.2003
%/*---------------------------------------------------------------------------*/
%/* MAIN VCN_I.m  Model according to Rothman & Manis "The roles Potassium..." 2003 */
%/* Current Injection Experiment
%//-----------------------------------------------------------------------------
%//------- modified ©2001 Werner Hemmert, Infineon Corporate Research ----------
%//-----------------------------------------------------------------------------
%// 30.10.2003 CN NEURON with ion channels according to Rothman & Manis 2003
%//-----------------------------------------------------------------------------
%//--------------------------------------------- basic definitions -------------
%//-----------------------------------------------------------------------------*/
%
%/*---------------------------------------------------------------------------*/
%/*------------------------------------------- basic definitions -------------*/
%/*---------------------------------------------------------------------------*/



%%// SI-VALUES in s and V !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
C_M  = 12e-12;           %// 12pF Membrane capacitance

V_K  = -70e-3;           %// -70mV K reversal potential
V_Na = +55e-3;           %// 55mV Na reversal potential
V_h  = -43e-3;           %// -43mV Na reversal potential
V_lk = -65e-3;           %// -65mV Na reversal potential

%/*----------------------------neuron_init-------------------------------*/
DT = 1/f_s;     %// in s !!!!!!!!!!!!!!!!!!!!!!

V=V_0;

  a_inf=(1+exp(-(V+31e-3)/6e-3))^-0.25;
  b_inf=(1+exp( (V+66e-3)/7e-3))^-0.5;  % BUG bis 5.11.2003

  w_inf=(1+exp(-(V+48e-3)/6e-3))^-0.25;
  z_inf=0.5 / (1+exp((V+71e-3)/10e-3)) + 0.5;
  
  n_inf=(1+exp(-(V+15e-3)/5e-3))^-0.5;
  p_inf=1./(1+exp(-(V+23e-3)/6e-3));

  m_inf=1./(1+exp(-(V+38e-3)/7e-3));  % fast Na+  NO BUG in PAPER!!
  h_inf=1./(1+exp( (V+65e-3)/6e-3));    % BUG bis 5.11.2003

  r_inf=1./(1+exp((V+76e-3)/7e-3));
  
%/*------------------------------------------------ define constants ---------*/
        V=V_0;
        a = a_inf;
		b = b_inf;
		c = b_inf;

		w = w_inf;
		z = z_inf;

		n = n_inf;
		p = p_inf;
		
		m = m_inf;
		h = h_inf;
		
		r = r_inf;
%// - - - - - - - - - - - - - - - - - - - - - - - - - process ion currents
for t_cnt = (1:size(I_input_,2))
    a_inf=(1+exp(-(V+31e-3)/6e-3))^-0.25;
    b_inf=(1+exp( (V+66e-3)/7e-3))^-0.5;  % BUG bis 5.11.2003
    c_inf=b_inf;
    tau_a= (100/(7*exp((V+60e-3)/14e-3)+29*exp(-(V+60e-3)/24e-3)) +0.1)/1000; % s
    tau_b=(1000/(14*exp((V+60e-3)/27e-3)+29*exp(-(V+60e-3)/24e-3)) +1)/1000; % s
    tau_c=(  90/(1+exp(-(V+66e-3)/17e-3)) +10)/1000; % s
    a=a+(a_inf-a)*DT/tau_a;
    b=b+(b_inf-b)*DT/tau_b;
    c=c+(c_inf-c)*DT/tau_c;
    I_A=g_A*a*a*a*a*b*c*(V-V_K);
I_A_(t_cnt)=I_A;

    w_inf=(1+exp(-(V+48e-3)/6e-3))^-0.25;
    z_inf= 0.5 / (1+exp((V+71e-3)/10e-3)) + 0.5;
    tau_w= (100/(6*exp((V+60e-3)/6e-3)+16*exp(-(V+60e-3)/45e-3)) + 1.5)/1000; % s  % 1 was 100
    tau_z=(1000/(  exp((V+60e-3)/20e-3)+exp(-(V+60e-3)/8e-3)) +50)/1000; % s
    w=w+(w_inf-w)*DT/tau_w;
    z=z+(z_inf-z)*DT/tau_z;
    I_LT=g_LT*w*w*w*w*z*(V-V_K);
I_LT_(t_cnt)=I_LT;
    n_inf=(1+exp(-(V+15e-3)/5e-3))^-0.5;                   %// high-threshold K+
    p_inf=1./(1+exp(-(V+23e-3)/6e-3));
    tau_n= (100/(11*exp((V+60e-3)/24e-3)+21*exp(-(V+60e-3)/23e-3)) +0.7)/1000; % s
    tau_p= (100/(4* exp((V+60e-3)/32e-3)+ 5*exp(-(V+60e-3)/22e-3)) +5)/1000; % s
    n=n+(n_inf-n)*DT/tau_n;
    p=p+(p_inf-p)*DT/tau_p;
    I_HT=g_HT*(0.85*n*n +0.15*p)*(V-V_K);
I_HT_(t_cnt)=I_HT;

    m_inf=1./(1+exp(-(V+38e-3)/7e-3));  % fast Na+  NO BUG in PAPER!!
    h_inf=1./(1+exp( (V+65e-3)/6e-3));    % BUG bis 5.11.2003
    tau_m=( 10/(5*exp((V+60e-3)/18e-3)+36*exp(-(V+60e-3)/25e-3)) +0.04)/1000; % s
    tau_h=(100/(7*exp((V+60e-3)/11e-3)+10*exp(-(V+60e-3)/25e-3)) +0.6)/1000; % s
    m=m+(m_inf-m)*DT/tau_m;
    h=h+(h_inf-h)*DT/tau_h;
    I_Na=g_Na*m*m*m*h*(V-V_Na);
I_Na_(t_cnt)=I_Na;

    r_inf= 1./(1+exp((V+76e-3)/7e-3));                          %// hyperpol activated cation current
    tau_r=(1e5/(237*exp((V+60e-3)/12e-3)+17*exp(-(V+60e-3)/14e-3)) +25)/1000; % s
    r=r+(r_inf-r)*DT/tau_r;
    I_h=g_h*r*(V-V_h);
    
I_h_(t_cnt)=I_h;

    I_lk=g_lk*(V-V_lk);                             %// leakage current
I_lk_(t_cnt)=I_lk;

%// - - - - - - - - - - - - - - - - - - - - - - - - - process inputs
    I_E=I_input_(t_cnt);   %// current injection
%// - - - - - - - - - - - - - - - - - - - - - - - - - process membrane voltage
   V=V-(I_A+I_LT+I_HT+I_Na+I_h+I_lk +I_E)/C_M*DT;   %//  SI units
%V=V+(I_A+I_LT+I_HT+I_Na+I_h+I_lk +I_E)*0.5;   %xxxx  RELAX within 10 steps
V_(t_cnt)=V;
  ap__=V;
end

%//	if( V > Phi_AP  ) %/* action potential */
%//	{
%//	  ap__=1;				%/*============== FIRE =================*/
%//	}
%  } %/* end loop sections */
    %}
%/*---------------------------------------------------------------------------*/
%/*---------------------------------- E N D ----------------------------------*/
%/*---------------------------------------------------------------------------*/

%/*---------------------------------------------------------------------------*/
