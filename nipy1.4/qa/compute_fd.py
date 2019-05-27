#!/usr/bin/env python
"""
implement the frame displacement measure described by Power et al. (2011)
"""


import numpy as N
import os,sys
import matplotlib.pyplot as plt

#FUNCTION DEFINITION
def compute_fd(motpars):

    motpars=N.loadtxt(motpars)
    # compute absolute displacement
    dmotpars=N.zeros(motpars.shape)
    
    dmotpars[1:,:]=N.abs(motpars[1:,:] - motpars[:-1,:])
    
    # convert rotation to displacement on a 50 mm sphere
    # mcflirt returns rotation in radians
    # from Jonathan Power:
    #The conversion is simple - you just want the length of an arc that a rotational
    # displacement causes at some radius. Circumference is pi*diameter, and we used a 5
    # 0 mm radius. Multiply that circumference by (degrees/360) or (radians/2*pi) to get the 
    # length of the arc produced by a rotation.
    
    #SUITABLE for mcflirt-output
    #[0:3]-> rotational parameters
    #[3:6]-> translational paramters
    #SWAP ORDER FOR AFNI
    headradius=50
    disp=dmotpars.copy()
    print disp[:,4:6]*1000
    print N.shape(disp)
    disp[:,0:3]=N.pi*headradius*2*(disp[:,0:3]/(2*N.pi))
    
    FD=N.sum(disp,1)
    
    return FD
