# -*- coding: utf-8 -*-
"""
Created on Fri Mar 15 10:52:16 2019

@author: fbeyer
"""

import re
#nii_files = self.inputs.nii_files

nii_files=[u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/cmrr_mbep2d_DTI_32Ch_s21.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/cmrr_mbep2d_DTI_32Ch_s22.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/t1_mp2rage_p3_32Ch_s9.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/t1_mp2rage_p3_32Ch_s10.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/cmrr_mbep2d_DTI_32Ch_s20.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/cmrr_mbep2d_bold_2.3iso_s16.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/t1_mp2rage_p3_32Ch_s12.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/cmrr_mbep2d_DTI_32Ch_invpol_s18.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/AAHead_Scout_s1.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/t1_mp2rage_p3_32Ch_s8.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/cmrr_mbep2d_DTI_32Ch_s23.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/t1_mp2rage_p3_32Ch_s11.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/cmrr_mbep2d_DTI_32Ch_s19.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/t1_mp2rage_p3_32Ch_s6.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/t1_mp2rage_p3_32Ch_s5.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/t1_mp2rage_p3_32Ch_s7.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/cmrr_mbep2d_DTI_32Ch_norm_s17.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/t2_space_sag_p2_0.9iso_s25.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/cbsasl_E11r2_pCASL_std_s24.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/AAHead_Scout_s3_i00002.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/AAHead_Scout_s4_i00002.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/cbsasl_E11r2_pCASL_scout_s13.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/AAHead_Scout_s2_i00001.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/cmrr_mbep2d_se_2.3iso_norm_s14.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/cmrr_mbep2d_se_2.3iso_invpol_s15.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/AAHead_Scout_s4_i00001.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/AAHead_Scout_s3_i00001.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/AAHead_Scout_s2_i00002.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/AAHead_Scout_s3.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/AAHead_Scout_s4.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/AAHead_Scout_s2_i00004.nii.gz', u'/data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_33839.5e/nii_wrangler/AAHead_Scout_s2.nii.gz']

#block_averaging = self.inputs.block_struct_averaging
s_num_reg = re.compile(".*s(\d+)")# sux to use filename. make more robust if needed.

nii_by_series = {}
fails = []
extras = []
   
for fn in nii_files:
    #print fn
    try:
        # we only want the first nii for each series
        # TODO: find out what those others (A/B) are all about. fix this as needed.
        print s_num_reg.match(fn)
        sn = int(s_num_reg.match(fn).groups()[0])
        print sn
        print fn
        
        if sn in nii_by_series:
            extras.append(fn)
            continue
        nii_by_series[sn] = fn
    except Exception, e:
        fails.append(fn)
if fails:
    print "error"    
    #raise ValueError("Could not derive series number from file names: %s." % str(fails))