function [ util ] = stim_util()
% a collection of function used for manipulating the stimulation signal
%
% Author: Mohammad Bashiri
%

util.chirp = @chirp;  % using Matlab built in chirp function
util.sin = @mysin;
util.pulse = @pulse;
util.slope = @slope;

end

function [ sin_signal ] = mysin(init_time, freq, phase, time_points)
    Sim_fs = 1/(time_points(2) - time_points(1));
    sin_signal = zeros(size(time_points));
    
    sin_signal_init = zeros(1, init_time*Sim_fs);
    
    time_remaining = time_points(init_time*Sim_fs: end) - init_time;
    sin_signal_end = sin(2 * pi * freq * (time_remaining + phase));
    
    sin_signal(1:init_time*Sim_fs) = sin_signal_init;
    sin_signal(init_time*Sim_fs:end) = sin_signal_end;
end

function [ pulse_signal ] = pulse( init_time, on_width, off_width, time_points )
    Sim_fs = 1/(time_points(2) - time_points(1));
    pulse_signal = zeros(size(time_points));
    
    on_signal = ones(1, on_width*Sim_fs);
    off_signal = zeros(1, off_width*Sim_fs);
    on_off_signal = [on_signal, off_signal];
    
    one_pulse_time = on_width + off_width;
    repeat = floor((time_points(end) - init_time) / one_pulse_time);
    
    end_time = init_time + repeat * one_pulse_time;
    
    on_off_signal = repmat(on_off_signal, 1, repeat);
    
    pulse_signal(init_time*Sim_fs:end_time*Sim_fs-1) = on_off_signal;

end

function [ slope_sig ] = slope( init_time, end_time, time_points )
    Sim_fs = 1/(time_points(2) - time_points(1));
    slope_sig = zeros(size(time_points));
    remaining_time = time_points(init_time*Sim_fs:end) - init_time;

    slope_period = end_time - init_time;
    init_sig = ones(1, init_time*Sim_fs);
    slope_values = remaining_time / slope_period;
    remaining_sig = ones(size(remaining_time));
    remaining_sig(slope_values < 1) = slope_values(slope_values < 1);

    slope_sig(1:init_time*Sim_fs) = init_sig;
    slope_sig(init_time*Sim_fs:end) = remaining_sig;

end