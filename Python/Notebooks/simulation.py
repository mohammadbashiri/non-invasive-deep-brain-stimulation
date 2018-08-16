import numpy as np

class Simulation(object):
    def __init__(self, period, fs):
        
        self.period = period # milliseconds
        self.fs = fs  # samples per second

        self.dt = 1/self.fs
        self.t = np.arange(0, self.period, self.dt)

        self.neuron = None
        self.stim = None

    def run(self):
    	"""Runs the simulation given a neuron mdoel and stimulation signal"""
    	if self.neuron and self.stim.any():
	     	for i in range(self.stim.shape[0]-1):
    	 		self.neuron.update(self.stim[i], i, self.dt)

    	else:
    	 	raise AttributeError("Make sure you have included your neuron model and stimulation signal to the simulation objcet. \n Example: \n\tmySim.neuron = myNeuron \n\tmySim.stim = I")