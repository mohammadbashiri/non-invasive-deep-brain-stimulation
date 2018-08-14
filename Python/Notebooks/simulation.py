import numpy as np

class Simulation(object):
    def __init__(self, Sim_period, Sim_fs):
        
        self.period = 5000 # milliseconds
        self.fs = 200  # samples per second

        self.dt = 1/Sim_fs
        self.t = np.arange(0, self.period, self.dt)