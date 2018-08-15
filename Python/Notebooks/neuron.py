from abc import abstractmethod
import numpy as np

class BaseNeuron(object):
    def __init__(self, params):
        for key, val in params.items():
            setattr(self, key, val)
    
    @property
    def params(self):
        """Gather all the attributes in a dictionary and returns it"""
        attrs = {el: self.__getattribute__(el) for el in dir(self) if (el[:2] != '__') and (el != 'params')}
        return attrs

    @abstractmethod
    def update(self, i, Sim_dt):
        pass
    
class AdExpIF(object):
	"""Adaptive Exponential Integrate and Fire neuron model"""
	def __init__(self):
		raise NotImplementedError


class HH(object):
	"""Hodgkin and Huxley neuron model"""
	def __init__(self):
		raise NotImplementedError


class MHH(BaseNeuron):
	"""Mammalian Hodgkin and Huxley neuron model"""
    
	def __init__(self, params):
		super(self.__class__, self).__init__(params)
        
	def update(self, i, Sim_dt):
	    """Set of differential equations needed to run the simulation"""
	    aM = 11.3/expe((-53-self.u[i])/6)
	    bM = 37.4/expe((57+self.u[i])/9)
	    aH = 5/expe((self.u[i]+106)/9)
	    bH = 22.6/(np.exp((-22-self.u[i])/12.5)+1)

	    n_inf  = 1/(1 + np.exp((1.7-self.u[i])/11.4))
	    tau_n  = 0.24 + 0.7/(1 + np.exp((self.u[i] + 12)/16.4))

	    a_inf  = 1/(1+np.exp((-55-self.u[i])/13.8))
	    b_inf  = 1/(1+np.exp((77+self.u[i])/7.8))
	    tau_a  = 0.12 + 0.6/(1+np.exp((self.u[i]+24)/16.5))
	    tau_b  = 2.1 + 1.8/(1+np.exp((self.u[i]-18)/5.7))

	    tau_m  = 1/(aM + bM)
	    m_inf  = aM * tau_m

	    tau_h  = 1/(aH + bH)
	    h_inf  = aH * tau_h

	    # Update the gating variables
	    self.n[i+1] = ((n_inf - self.n[i])/tau_n) * Sim_dt + self.n[i]
	    self.a[i+1] = ((a_inf - self.a[i])/tau_a) * Sim_dt + self.a[i]
	    self.b[i+1] = ((b_inf - self.b[i])/tau_b) * Sim_dt + self.b[i]
	    self.m[i+1] = ((m_inf - self.m[i])/tau_m) * Sim_dt + self.m[i]
	    self.h[i+1] = ((h_inf - self.h[i])/tau_h) * Sim_dt + self.h[i]

	    # Compute the currents
	    self.INA[i] = self.gNA * (self.m[i]**3) * self.h[i] * (self.ENA-self.u[i])
	    self.IK[i] = self.gK * (self.n[i]**3) * (self.EK-self.u[i])
	    self.IA[i] = self.gA * (self.a[i]**4) * self.b[i] * (self.EK-self.u[i])
	    self.IL = self.gL * (self.EL-self.u[i])

        
class VCN(object):
	"""Ventral Cochlear Nucleus neuron model
	
	The credits for this model are as follows:
	Implementation (in Matlab) = Werner Hemmert
	Adapting to python = Mohammad Bashiri
	"""
	def __init__(self):
		raise NotImplementedError

class SimpleModel(object):
	"""Simple Model from Izhikevich"""
	def __init__(self):
		raise NotImplementedError
        

def expe(x):
    if (x == 0):
        expVal = 1
    else:
        expVal = (np.exp(x) - 1) / x
    
    return expVal