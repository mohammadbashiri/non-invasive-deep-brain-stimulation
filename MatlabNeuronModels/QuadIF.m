close all

% initializing simulation param
tend = 300;
fs   = 100;
dt   = 1/fs;
t    = 0:dt:tend-dt;
N    = numel(t);

b = 0.01;
v = zeros(1,N);
vpeak = 89;
vreset = 0;

for i=2:N
    dvdt = (b + v(i-1)^2) * dt;
    v(i) = v(i-1) + dvdt;
    ch = v(i);
    
    if v(i) > vpeak
        v(i) = vreset;
    end
end

v = v - 69; % bringing  down the potential to resting (-69)

plot(t, v);
xlabel({'$Time (ms)$'},'Interpreter','latex');
ylabel({'$V_m (mV)$'},'Interpreter','latex');