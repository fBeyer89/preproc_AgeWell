#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu May 16 09:52:10 2019

@author: fbeyer
"""

import re

dwi="/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_34114.8a/dicom_convert/cmrr_mbep2d_DTI_32Ch_s19.nii.gz"
bvals=[u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_34138.54/dicom_convert/cmrr_mbep2d_DTI_32Ch_s21.bval', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_34138.54/dicom_convert/cmrr_mbep2d_DTI_32Ch_s19.bval']
m = re.search('s.(+?).nii.gz', dwi)

a=re.compile(".*cmrr_mbep2d_DTI_32Ch_s(.*).nii.gz*").match("/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_34114.8a/dicom_convert/cmrr_mbep2d_DTI_32Ch_s21.nii.gz").groups()

b=re.compile(".*cmrr_mbep2d_DTI_32Ch_s(.*).bval*").match(bvals[1]).groups()

a==b