# Non-Invasive Deep Brain Stimulation

This repository contains all the code used for simulation of non-invasive Deep Brain Stimulation (DBS) via Temporal Interference (TI).

## About the project

The project is inspired by a paper published on June 2017 [1], which proposed a new 
method for Non-invasive DBS via two (or more) temporally interfering signals. Using the 
codes available in this repo, one can visualize the distribution of electric fields in 
a spherical head model. Furthermore, using the computed electric field distribution, we 
can also see the response of neurons at any point in the conductive medium (head model).

Given that you have an E-field distribution from FE analysis of any arbitrary head model, 
which was also part of this project (but not covered here), a different script could be 
used to visualize the distribution.

A a summary, the main focus of this repository is two-fold:
- Visualization of E-field distribution either generated from FEA or an analytical solution
- Testing the response of different neuron models at different location within the E-field 
distribution


## Electric field (E-field) distribution

In this project, I used a spherical head model, to keep things simple. The computation and 
visualization of the E-field is done in Matlab (so look into the Matlab folder if you are 
interested).

## Neuron response



### You see a bug?

If you see anything wrong with the code, or you would like to suggest a change, I would be more 
than happy to communicate. There are two ways to communicate (and/or contribute):
- Easiest way (which might also take some time for the change to be implemented) is to 
email me at mohammadbashiri93@gmail.com, with the description of the problem you are facing.
- Through Git
    - Fork the repo, clone it from your own account, make a (descriptive) branch, implement 
    the change, push it to your own remote repo, make a pull request to my repo.

### Reference
[1] N. Grossman et al., “Noninvasive Deep Brain Stimulation via Temporally Interfering Electric Fields,” Cell, vol. 169, no. 6,
p. 1029–1041.e16, 2017.