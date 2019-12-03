## preproc_AgeWell

### Preprocessing pipelines for the AGEWELL study (based on HCP pipeline)

+ BIDS format: bring imaging data into BIDS data convention (bids_conversion.py). For first participants, this was done retrospectively (additional pipeline in folder bids_conversion_for_finished_subjects)

+ Structural preprocessing: CBSTOOLS for MP2RAGE- skullstripping, further processing of skull-stripped brain with Freesurfer + registration to MNI152 1mm space (ANTS)

+ Functional (rsfMRI) preprocessing: removal of first 4 volumes, motion correction (MCFlirt), coregistration to anatomical (BBREGISTER)
, unwarping (TOPUP) applied in a single step, removal of linear trend.

+ Diffusion MRI preprocessing: artefacts correction including denoising (MRTrix: dwidenoise) and Gibb's ringing removal (MRTrix: mrdegibbs); field distortion correction (FSL: topup); motion correction and outliner replacement (FSL: eddy); tensor model fitting (FSL: dtifit)

+ Creating a report for quick overview of the data.

Based on the implementation of HCP pipelines for nipype (https://github.com/beOn/hcpre)

Using software packages and nipype: (environment_FS6.sh)
`CBSTOOLS --version 3.1 MRICRON AFNI --version '17.2.17' ANTSENV --version '2.2.0' FSL --version 5.0.11 FREESURFER --version 6.0.0p1, nipype version 1.2.0`

load conda environment: `agewell_nip1.2` which is saved in `agewell_env.2.yml`

To run it do:
`python run_workflow_hcplike.py --run -n 8 --config conf_for_Agewell.conf`
conf_for_Agewell.conf: configuration file where only ID of participant (subjects = ['XXXXX.XX'] should be changed.

Working directory is defined in "run_workflow_hcplike.py", ll.76: working_dir="" (don't change, unless directory is full). The working directory contains all intermediate steps,
which could be helpful for debugging.

Information on MRI sequences can be found in **agewell.pdf**

### Outcomes

Main results of the [preprocessing pipeline](https://github.com/fBeyer89/preproc_AgeWell/nipy1.4) in /data/pt_02030/Data/preprocessed.
  * dti
      * diffusion
         * /X/fa2anat.mat (bbregister FA to anat reg matrix)
         * /X/fa2anat.dat (bbregister FA to anat reg matrix)
         * /X/fa2anat_bbreg.nii.gz (bbregister FA to anat reg result)
         * /X/dtifit__V3.nii.gz
         * /X/dtifit__MD.nii.gz (MD map in individual's anatomical space)
         * /X/dtifit__L3.nii.gz
         * /X/dtifit__L2.nii.gz
         * /X/dtifit__L1.nii.gz
         * /X/dtifit__V2.nii.gz
         * /X/dtifit__V1.nii.gz  
         * /X/dtifit__FA.nii.gz  (FA map in individual's anatomical space)
         * /X/eddy_corrected.eddy_residuals.nii.gz (eddy residuals)
         * /X/eddy_corrected.eddy_cnr_maps.nii.gz (CNR maps from eddy)
         * /X/eddy_corrected.eddy_movement_rms (movement params)
         * /X/eddy_corrected.nii.gz (eddy result)
         * /X/eddy_corrected.eddy_rotated_bvecs (rotated bvecs)
         * /X/eddy_corrected.eddy_outlier_report
         * /X/eddy_corrected.eddy_post_eddy_shell_alignment_parameters
         * /X/dwi_appa_field.nii.gz (distortion correction field)
         * /X/dwi_appa_base_fieldcoef.nii.gz (distortion correction field coefficients)
      * tracula
        * /X/ (output of tracula tractography software)
        * stats (summary of tracula statistics)
  * freesurfer
    * /X/: cross-sectional Freesurfer runs with FREESURFER version 6.0.0p1
    * QA:
      * /X/: results of QAtools for each participant
      * QA_list.ods: list describing FS Quality according to visual inspection.
  * resting
    * structural
      * /X/transform_Warped.nii.gz (brain.mgz warped to MNI space)
      * /X/transform1Warp.nii.gz (Warpfield for this transform)
      * /X/transform1InverseWarp.nii.gz (inverse Warpfield for this transform)
      * /X/transform0GenericAffine.mat (affine matrix for this transform)
      * /X/T1_brain_mask.nii.gz (brainmask.mgz as nifti)
      * /X/T1.nii.gz (T1.mgz (before skullstrip) as nifti)
      * /X/brain.nii.gz (brain.mgz as nifti, input of the transform)

    * resting
      * unwarp
        * /X/rest_mean2fmap_unwarped.nii.gz (EPI registered to fieldmap unwarped)
        * /X/rest_mean2fmap.nii.gz (EPI registered to fielmap)
        * /X/fullwarpfield.nii.gz (Warpfield to perform transform)
      * transform_ts
        * /X/rest2anat_detrend.nii (fMRI timeseries in downsampled individual's anatomical space, detrended)
        * /X/T1_resampled.nii.gz (T1 resampled to EPI resolution
        * /X/rest_mean2anat_lowres.nii.gz (mean EPI to lowres anatomical image)
        * /X/rest2anat.nii.gz (fMRI timeseries in downsampled individual's anatomical space)
      * moco
        * /X/tsnr.nii.gz (temporal SNR image)
        * /X/rest_realigned_mean.nii.gz (average of realigned EPI timeseries)
        * /X/rest_realigned.nii.gz_rel.rms (relative rms values)
        * /X/rest_realigned.nii.gz_abs.rms (absolute rms values)
        * /X/rest_realigned.nii.gz.par (rotational and translational motion parameters from MCFLIRT)
      * anat_coreg
        * /X/rest_mean2anat_highres.nii.gz (bbregister result mean EPI to anatomical image)
        * /X/rest2anat.mat (registration matrix from bbregister)
        * /X/rest2anat.dat

  * reports (qa reports from preprocessing)
    * X_report.pdf (general report generated during preprocessing showing main result for anatomical, DWI and functional preprocessing)
    * detailedQA
        * /X/: summary_fmriplot.png shows outliers (from AFNI3DOutliercount), FD and DVARS trace over all volumes. Below carpet plot of red: GM, green: WM, orange: CSF and blue: cerebellum voxels for the minimally preprocessed data.
        * metrics: text files of fd (fd.txt) and outlier and DVARS metrics (confounds.csv)

All intermediate
