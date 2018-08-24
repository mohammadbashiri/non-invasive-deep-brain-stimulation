from abc import abstractmethod
import numpy as np

class BaseNeuron(object):
    def __init__(self, const_params, tracked_params, time_points):
        for key, val in const_params.items():
            setattr(self, key, val)

        for tracked_param in tracked_params:
        	setattr(self, tracked_param, np.zeros(time_points.shape))
    
    @property
    def params(self):
        """Gather all the attributes in a dictionary and returns it"""
        attrs = {el: self.__getattribute__(el) for el in dir(self) if (el[:2] != '__') and (el != 'params')}
        return attrs

    @abstractmethod
    def update(self, i, Sim_dt):
        pass
    
class AdExpIF(BaseNeuron):
	"""Adaptive Exponential Integrate and Fire neuron model"""
	def __init__(self, const_params, tracked_params, time_points):
		super(self.__class__, self).__init__(const_params, tracked_params, time_points)
		self.v[0] = self.EL

	def update(self, I, i, Sim_dt):
		f = -self.gL * (self.v[i] - self.EL) + self.gL * self.dT * np.exp((self.v[i] - self.VT)/self.dT)
		dvdt = (f - self.w[i] + I) / self.C
		self.v[i+1] = self.v[i] + dvdt  * Sim_dt
		
		dwdt = (self.a * (self.v[i] - self.EL) - self.w[i]) / self.tauw
		self.w[i+1] = self.w[i] + dwdt * Sim_dt

		if self.v[i+1] > self.vpeak:    
			self.v[i] = self.vpeak
			self.v[i+1] = self.EL
			self.w[i+1] = self.w[i+1] + self.b


class HH(object):
	"""Hodgkin and Huxley neuron model"""
	def __init__(self):
		raise NotImplementedError


class MHH(BaseNeuron):
	"""Mammalian Hodgkin and Huxley neuron model"""
    
	def __init__(self, const_params, tracked_params, time_points):
		super(self.__class__, self).__init__(const_params, tracked_params, time_points)
		self.u[0] = self.Er
        
	def update(self, I, i, Sim_dt):
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

	    # In case you want to block some currents
        #     self.I[i] = 0
        #     self.INA[i] = 0  # contributing to the integration
        #     self.IK[i] = 0  # not sure what is contributing to!
        #     self.IA[i] = 0  # contributes to stability and bringing down the membrane potential (so integration as well)
        
	    dudt = (self.INA[i] + self.IK[i] + self.IA[i] + self.IL + I) / self.C
	    self.u[i+1] = self.u[i] + Sim_dt * dudt

        
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