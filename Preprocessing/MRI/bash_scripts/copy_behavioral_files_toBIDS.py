#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Fri Mar  6 15:22:19 2020

@author: fbeyer
"""
import os
import glob

def copy_beh_bids(bids_output,subject,ses):

    import shutil
    import re


    subj=re.sub('[.]','',subject)
    if not (os.path.isdir('%s/sub-%s/ses-%s/beh/' %(bids_output,subj,ses))):
            os.makedirs('%s/sub-%s/ses-%s/beh/' %(bids_output,subj,ses))
    if (os.path.isfile('/data/p_02030/%s/%s-MST_1.log'%(subject,subject))):
        shutil.copyfile('/data/p_02030/%s/%s-MST_1.log'%(subject,subject), '%s/sub-%s/ses-%s/beh/%s-MST_1.log' %(bids_output,subj,ses,subj))


  
os.chdir('/data/p_02030')
print glob.glob('3*')    
for subj in glob.glob('3*'): 
    
    copy_beh_bids("/data/p_02030/BIDS/",subj, "bl")
