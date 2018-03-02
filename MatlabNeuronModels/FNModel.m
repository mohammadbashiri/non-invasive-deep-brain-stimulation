clear all
close all

tend = 600;
dt   = 0.01;
t    = 0:dt:tend;
N    = numel(t);

e  = 0.1;
b0 = 2;
b1 = 1.5;

u_init = 0;
w_init = 0;
I_stim = 1.235;
I = ones(1,N)*I_stim;
I(1:ceil(N/6)) = 0; 

m = zeros(N,1);

for i = 1:N    
    
    du = u_init - (1/3)*u_init.^3 - w_init + I(i);      %first differential equation
    dw = e*(b0 + b1*u_init - w_init);                   %second differential equation
   
    u_init = u_init+dt*du;
    w_init = w_init+dt*dw;

    m(i) = u_init;                                                      
end

figure, hold on
plot(t, m);
plot(t, I);
