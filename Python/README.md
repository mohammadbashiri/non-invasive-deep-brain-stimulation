## Python codes for the project

This directory contains the python scripts for the simulation, as well as the neuron models written in python. <br>
The aim is to have all the functions both in Matlab and Python at the end. But I am currently a bit far from achieving this goal.

### Pre-requisites

make sure you have cloned the github repo at github.com/mohammadbashiri/non-invasive-deep-brain-stimulation

**NOTE: the time and frequency in Python code are in milliseconds and kHz, respectively**, as oppose to Matlab in which 
they are in seconds and Hz.

---

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
all the stimulation functions are stored in a module called `stim_util`. And all the neuron models 
are available in a module called `neuron`.

The first step is to import the necessary libraries (for plotting) and modules:

```python
import matplotlib.pyplot as plt

import sys
sys.path.insert(0, "../Scripts")

import stim_util as su
from simulation import Simulation
```

And we can generate the four stimulation signals as follow:

```python
# Create a simulation object (this is just to have the time points without having to import numpy)
mySim = Simulation(period=10000, fs=100)

stim_pulse = su.gen_pulse(init_time=500, on_width=1000, off_width=2000, time_points=mySim.t)
stim_sin = su.gen_sin(init_time=0, freq=.001, phase=0, time_points=mySim.t)
stim_chirp, freq = su.gen_chirp(init_freq=.00001, init_time=0, end_freq=.01, end_time=mySim.t[-1], time_points=mySim.t)
stim_slope = su.gen_slope(init_time=0, end_time=5000, time_points=mySim.t)
```

Would let you create the following patterns.

![pulse](https://github.com/mohammadbashiri/non-invasive-deep-brain-stimulation/blob/master/Figures/pulse.png)

![sin](https://github.com/mohammadbashiri/non-invasive-deep-brain-stimulation/blob/master/Figures/sin.png)

![chirp](https://github.com/mohammadbashiri/non-invasive-deep-brain-stimulation/blob/master/Figures/chirp.png)

![slope](https://github.com/mohammadbashiri/non-invasive-deep-brain-stimulation/blob/master/Figures/slope.png)

Here are two examples of what could be done by combining some of the above patterns.
To get the following patterns, simply run:

```matlab
plt.plot(mySim.t, 2 * stim_sin + stim_chirp, 'k', linewidth=3)
plt.show()

plt.plot(mySim.t,  2 * stim_slope * (stim_sin + stim_chirp), 'k', linewidth=3)
plt.show()
```

![sin-chirp](https://github.com/mohammadbashiri/non-invasive-deep-brain-stimulation/blob/master/Figures/sin-chirp.png)

![slope-sin-chirp](https://github.com/mohammadbashiri/non-invasive-deep-brain-stimulation/blob/master/Figures/slope-sin-chirp.png)

---

### Neuron model response

In this part, I will walk you through the procedure of  visualizing neuron response. I am assuming 
you are already in the project directory, in Matlab. From here, go to Matlab > Neurons, and select 
all the folders, right click > Add to Path > Selected Folders. Now we are all set!

In general, we need to do the following steps:
* Define simulation parameters (period, sampling frequency, etc.)
* Create a stimulation signal
* Define your neuron model
* Add the neuron model and the stimulation signal to your simulation object
* Run the simulation
* Visualize the result

Here is an example (I am assuming you already have a stimulation signal called `I_stim`):

```python
from neuron import MHH

# define the constant paramters of your neuron model
const_params = {
    # variable = value xxx Unit
    'gNA': 240, # m.mho/cm^2
    'gK': 36, # m.mho/cm^2
    'gA': 61, # m.mho/cm^2
    'gL': 0.068, # m.mho/cm^2
    'ENA': 64.7, # mV
    'EK': -95.2, # mV
    'EL': -51.3, # mV
    'C': 1, # uF/cm^2
    'Er': -71,
    'g_L': 10000,
    'L': 1
}

# define the tracked parameters (parameters that their values updates every iteration) of your neuron model.
tracked_params = ['m', 'h', 'n', 'p', 'a', 'b', 
                  'u', 'b', 'INA', 'IK', 'IA', 'I_L']
                  
myNeuron = MHH(const_params=const_params,
               tracked_params=tracked_params,
               time_points=mySim.t)

# add the neuron model object and the stimulation signal to your simulation obejct
mySim.neuron  = myNeuron
mySim.stim = I_stim

# run the simulation
mySim.run() 

# visualize the result
plt.plot(mySim.t, myNeuron.u)
plt.xlabel('Time (ms)')
plt.ylabel('Membrane Potential (mV)')
plt.show()
```

And here is the stimulation signal, as well as the membrane potential of the neuron: