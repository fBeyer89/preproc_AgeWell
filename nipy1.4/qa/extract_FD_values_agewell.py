#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Mon May 20 13:53:44 2019

@author: fbeyer
"""

from compute_fd import compute_fd
import numpy as np


subj_list=['34113.a5', '34138.54','34114.8a','33920.4d','33954.4a',
             '33899.38','33953.9e','33839.5e','33911.d9','33725.1f',
             '33809.60','33808.e4','33593.15','33724.98','33698.f1',
             '33555.22','33503.0e','33486.7e','33307.92','33434.7f','33219.97']
summaryfd=np.zeros(shape=(3,len(subj_list)))
i=0
for subj in subj_list:
    print subj
    motpars='/data/pt_02030/preprocessed/resting/resting/moco/%s/rest_realigned.nii.gz.par' %subj
    fd=compute_fd(motpars)
    summaryfd[0,i]=np.mean(fd)
    summaryfd[1,i]=np.max(fd)
    summaryfd[2,i]=int(subj_list[i][0:5])
    i+=1
    
    
print summaryfd

