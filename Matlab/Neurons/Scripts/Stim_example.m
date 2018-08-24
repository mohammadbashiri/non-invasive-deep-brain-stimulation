stim_util = stim_util();
t = 0.001:0.001:10;

stim_chirp = stim_util.chirp(t, .01, t(end), 10, 'linear');
stim_pulse = stim_util.pulse(.5, 1, 2, t);
stim_slope = stim_util.slope(t(1), 5, t);
stim_sin = stim_util.sin(t(1), 1, 0, t);

% each one
figure; plot(t, stim_chirp, 'k', 'LineWidth', 3); xlabel('Time'); ylabel('Amplitude');
figure; plot(t, stim_pulse, 'k', 'LineWidth', 3); xlabel('Time'); ylabel('Amplitude');
figure; plot(t, stim_slope, 'k', 'LineWidth', 3); xlabel('Time'); ylabel('Amplitude');
figure; plot(t, stim_sin, 'k', 'LineWidth', 3); xlabel('Time'); ylabel('Amplitude');

% combined
figure; plot(t, 2 * stim_sin + stim_chirp , 'k', 'LineWidth', 3); xlabel('Time'); ylabel('Amplitude');
figure; plot(t,  2 * stim_slope .* (stim_sin + stim_chirp) , 'k', 'LineWidth', 3); xlabel('Time'); ylabel('Amplitude');