## Matlab codes for the project

This directory contains the Matlab scripts for the simulation, as well as the neuron models written in Matlab. <br>
The aim is to have all the functions both in Matlab and Python at the end. But I am currently a bit far from achieving this goal.

### Pre-requisites

make sure you have the done the following before your proceed:
* Clone the github repo at github.com/mohammadbashiri/non-invasive-deep-brain-stimulation
* Open Matlab and go to the project directory

### E-field distribution


### Available stimulation signals

Here is a demonstration of what stimulation signals can be generated using the provided functions.
There are four general types that can be generated:
* **pulse**: Generates pulses (ON and OFF).
* **sin**: This does not add much to the built-in, except that it lets the user to define a phase 
shift (in unit of time), which also covers for a cosine function.
* **chirp**: Generates a chirp signal. Its difference to the built-in chirp function of Matlab is 
that it also return the instantaneous frequency values, so it enables the user to plot the signal 
versus instantaneous frequency.
* **slope**: Generates a ramped signal. It is handy when applied on other signals.

One can generate most of the common signal patterns using these four functions. 
all the stimulation functions are stored in a structure which is return as a result of a function call 
(`stim_util()`). Hence, to use the 
functions, one needs to call the function which returns this structure. As an example, running 
the following code:

```matlab
stim_util = stim_util()
t = 0.001:0.001:10;

stim_chirp = stim_util.chirp(t, .01, t(end), 10, 'linear');
stim_pulse = stim_util.pulse(.5, 1, 2, t);
stim_slope = stim_util.slope(t(1), 5, t);
stim_sin = stim_util.sin(t(1), 1, 0, t);
```

Would let you create the following patterns.

![pulse](https://github.com/mohammadbashiri/non-invasive-deep-brain-stimulation/blob/master/Figures/pulse.png)

![sin](https://github.com/mohammadbashiri/non-invasive-deep-brain-stimulation/blob/master/Figures/sin.png)

![chirp](https://github.com/mohammadbashiri/non-invasive-deep-brain-stimulation/blob/master/Figures/chirp.png)

![slope](https://github.com/mohammadbashiri/non-invasive-deep-brain-stimulation/blob/master/Figures/slope.png)

Here are two examples of what could be done by combining some of the above patterns.
To get the following patterns, simply run:

```
figure; plot(t, 2 * stim_sin + stim_chirp , 'k', 'LineWidth', 3); 
xlabel('Time'); ylabel('Amplitude');

figure; plot(t,  2 * stim_slope .* (stim_sin + stim_chirp) , 'k', 'LineWidth', 3); 
xlabel('Time'); ylabel('Amplitude');
```

![sin-chirp](https://github.com/mohammadbashiri/non-invasive-deep-brain-stimulation/blob/master/Figures/sin-chirp.png)

![slope-sin-chirp](https://github.com/mohammadbashiri/non-invasive-deep-brain-stimulation/blob/master/Figures/slope-sin-chirp.png)


### Neuron model response

In this part, I will walk you through the procedure of  visualizing neuron response. I am assuming 
you are already in the project directory, in Matlab. From here, go to Matlab > Neurons, and select 
all the folders, right click > Add to Path > Selected Folders. Now we are all set!

