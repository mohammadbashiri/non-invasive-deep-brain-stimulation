from neuron_models import AdExpIF

# define a simulation environment
"""
Sim_period = 5000
Sim_fs   = 100
"""
mySim = Simulation(Sim_period=5000, Sim_fs=100)

# define the neuron
"""
C     = 130     # pF - membrane capacitance
gL    = 1      # nS - leak conductance
EL    = -70.6   # mV - 
VT    = -50.6   # mV - 
dT    = 2       # mV - 
tauw  = 300     # ms - adaptation time-constant
a     = 30       # nS - subthreshold oscillation parameter
b     = 80.5    # pA - spike-triggered adaptation constants
vpeak = 20      # mV
"""
neuronParams = {'C': 130, 'gL': 1, 'EL': -70.6, 'VT': , 'dT': , 'tauw': , 'a': , 'b': , 'vpeak':}
myNeuron = AdExpIF(*params)


# Define stimulation method (current or voltage, intra or extracellular)


# Define measurements (what to measure?)


# Add the neuron (and other components) to the simulation and run
mySim.add(myNeuron, Ext_Stim, device)

# Run the simulation
mySim.run()  # this can also accept the period for the simulation

# Read/visualize data
plot(mySim.time, device.voltage)