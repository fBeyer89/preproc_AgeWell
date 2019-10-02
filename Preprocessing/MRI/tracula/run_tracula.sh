#!/bin/bash
FREESURFER --version 6.0.0p1


##prepare the data structure from our preprocessing (-> use preprocessed file)
mkdir -p "data/pt_02030/preprocessed/dti/tracula/33724.98/dlabel/diff/"
cp /data/pt_02030/preprocessed/dti/diffusion/33724.98/eddy_corrected.nii.gz /data/pt_02030/preprocessed/dti/tracula/33724.98/dmri/dwi.nii.gz
cp /data/pt_02030/preprocessed/dti/diffusion/33724.98/eddy_corrected.nii.gz /data/pt_02030/preprocessed/dti/tracula/33724.98/dmri/data.nii.gz
cp /data/pt_02030/preprocessed/dti/diffusion/33724.98/eddy_corrected.eddy_rotated_bvecs /data/pt_02030/preprocessed/dti/tracula/33724.98/dmri/bvecs
cp /data/p_02030/nifti/33724.98/cmrrmbep2dDTI32Chs024a1001.bval /data/pt_02030/preprocessed/dti/tracula/33724.98/dmri/bvals
cp /data/p_02030/nifti/33724.98/cmrrmbep2dDTI32Chs022a001.nii /data/pt_02030/preprocessed/dti/tracula/33724.98/dmri/dwi_orig.nii.gz
cp /data/pt_02030/wd_preprocessing/hcp_prep_workflow/dwi_preproc/distor_correct/_subject_33219.97/bet/dwi_appa_corrected_maths_brain.nii.gz /data/pt_02030/preprocessed/dti/tracula/33724.98/dmri/lowb.nii.gz




trac-all -path -stat -c /home/raid1/fbeyer/Documents/Scripts/AgeWell/tracula/dmrirc

#-masks -tensor -prior -bedp -path -stat


#Preprocessing
#1.1 Image corrections -> is performed during the nipype preprocessing with advanced DENOISING, GIBBS RINGING correction & EDDY
#Convert the input DWI files to NIfTI, using mri_convert.
#Correct for B0 inhomogeneities (optional). This is done using epidewarp.fsl. This step can be turned on or off in the configuration file. To run this step, B0 field map files for each subject must be specified in the configuration file.
#Correct for eddy currents and simple head motion (optional). This is done using FSL's eddy_correct. This step can be turned on or off in the configuration file.
#Create a brain mask from the low-b diffusion images. This done using FSL's bet. The threshold can be specified in the configuration file. The configuration file can also be used to specify if this brain mask will actually be used in the following processing steps or if the anatomical brain mask from recon-all will be used instead. 

#1.2 Image quality assessment -> implemented separately.
#This step computes the four measures of head motion from Yendiki et al. 2013, based on the DWIs and the output of the eddy-current correction of step 1.1. 

#1.3 Intra-subject registration -> already performed during preprocessing, still need to copy paths
#This step performs an affine registration between the individual's low-b diffusion and T1 images. Depending on what has been specified in the configuration file, this can be done either with bbregister or with FSL's flirt. 

#1.4 Inter-subject registration
#Register the individual's T1 image to a template. Depending on what has been specified in the configuration file, this can be done either with affine registration to the MNI template (using FSL's flirt).
#Compose the diffusion-to-T1 transformation (from step 1.3) and the T1-to-template transformation to get the diffusion-to-template transformation. 

#Mask creation
#Create a white-matter (WM) mask. This is done by extracting the cerebral WM, cerebellar WM, ventral DC, and brainstem from the individual's FreeSurfer cortical parcellation and subcortical segmentation (mri/aparc+aseg.mgz).
#Create a mask of the cortex. This is done by mapping the cortical parcellation labels to the volume, growing them into the WM by 2mm and combining all the grown cortical labels into a mask.
#Create an anatomical brain mask. This is done by binarizing and dilating the entire cortical parcellation and subcortical segmentation.
#Transform all the above masks from individual T1 space to individual diffusion space and to the template space. This is done using the registrations that were computed in steps 1.3 and 1.4.
#Transform the diffusion brain mask created in step 1.1 from the individual diffusion space to individual T1 space and to the template space. 

#1.6 Tensor fit -> already performed during preprocessing, could copy paths.
#Perform least-squares tensor estimation using FSL's dtifit.
#Map all scalar output volumes of the tensor fit (FA, MD, etc.) from diffusion space to the template space. This is done using the registrations that were computed in steps 1.3 and 1.4. (One could use these transformed volumes to do voxel-based statistical analyses in the template space, if one is so inclined.) 

#1.7 Estimation of pathway priors
#Compute pathway priors. This is done in template space by combining the atlas data (training subjects' manually labeled pathways and anatomical segmentations) with the individual's own masks from step 1.5. The training data is used to estimate a priori probabilities that each pathway intersects/neighbors each of the labels in the cortical parcellation and subcortical segmentation, at each point along the pathway's trajectory. The training set is also used to obtain ROIs for the two endings of each pathway, as well as an initial guess of the location of the control points of each pathway, to be used in the tractography of step 3.
#Map the selected initial control points from the template space to individual diffusion space, using the registrations that were computed in steps 1.3 and 1.4. 
#Ball-and-stick model fitting
#This step runs FSL's bedpostx to fit the ball-and-stick model of diffusion to the DWIs. One isotropic and two anisotropic compartments are assumed by default to model the diffusion signal in each voxel. Parallel processing on a computer cluster is highly recommended for this step. 
#Pathway reconstruction
#Estimate the a posteriori probability distribution of the location of each pathway in the individual. This distribution consists of a likelihood term (the fit of the pathway orientation to the anisotropic compartments of the ball-and-stick model at each voxel) and a prior term (computed in step 1.7 from the atlas). The estimation is done by an MCMC algorithm and several parameters of that algorithm can be set in the configuration file.
# Use the estimated pathway distributions to extract statistics on standard diffusion measures (FA, MD, etc.) for each of the pathways 

Assemble pathway measures from all subjects

    This step can be run after each of the subjects has been processed with all of the previous steps. It will combine all subjects' diffusion measures (FA, MD, etc.) along the each pathway and output a table for each diffusion measure (FA, MD, etc.) and each pathway. In these tables, each row is a different position along the trajectory of the pathway and each column is a different subject. The user can then use these tables to perform "along-the-tract" group analyses. 
