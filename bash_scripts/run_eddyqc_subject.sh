#!/bin/bash


#run eddy qc for agewell.de-MRI

Usage: eddy_quad <eddyBase> -idx <eddyIndex> -par <eddyParams> -m <mask> -b <bvals> [options]
   
   
Compulsory arguments:
       eddyBase             Basename (including path) specified when running EDDY
       -idx, --eddyIdx      File containing indices for all volumes into acquisition parameters
       -par, --eddyParams   File containing acquisition parameters
       -m, --mask           Binary mask file
       -b, --bvals          b-values file
   
Optional arguments:
       -g, --bvecs          b-vectors file - only used when <eddyBase>.eddy_residuals file is present
       -o, --output-dir     Output directory - default = '<eddyBase>.qc' 
       -f, --field          TOPUP estimated field (in Hz)
       -s, --slspec         Text file specifying slice/group acquisition
       -v, --verbose        Display debug messages



eddy_quad /data/pt_02030/wd_preprocessing/hcp_prep_workflow/dwi_preproc/distor_correct/_subject_34115.67/eddy/eddy_corrected -idx /data/pt_02030/scripts/nipy1.4/diffusion/index.txt -par /data/pt_02030/scripts/nipy1.4/diffusion/acqparams_dwi.txt -m /data/pt_02030/wd_preprocessing/hcp_prep_workflow/dwi_preproc/distor_correct/_subject_34115.67/bet/dwi_appa_corrected_maths_brain_mask.nii.gz -b /data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_34115.67/dicom_convert/cmrr_mbep2d_DTI_32Ch_s19.bval --bvecs /data/pt_02030/wd_preprocessing/hcp_prep_workflow/_subject_34115.67/dicom_convert/cmrr_mbep2d_DTI_32Ch_s19.bvec -f /data/pt_02030/wd_preprocessing/hcp_prep_workflow/dwi_preproc/distor_correct/_subject_34115.67/topup/dwi_appa_field.nii.gz
