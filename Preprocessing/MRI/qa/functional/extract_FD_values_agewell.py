#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Mon May 20 13:53:44 2019

@author: fbeyer
"""

from compute_fd import compute_fd
import numpy as np


subj_list=[]
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

