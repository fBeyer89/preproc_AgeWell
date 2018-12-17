# preproc_AgeWell

Preprocessing pipelines for the AGEWELL study (based on HCP pipeline)

+ Structural preprocessing: with Freesurfer + registration to MNI152 1mm space

+ Functional (rsfMRI) preprocessing: removal of first 4 volumes, motion correction (MCFlirt), coregistration to anatomical (BBREGISTER)
, unwarping (TOPUP) applied in a single step, removal of linear trend.

+ Diffusion MRI preprocessing: artefacts correction includeing denoising (MRTrix: dwidenoise) and Gibb's ringing removal (MRTrix: mrdegibbs); field distortion correction (FSL: topup); motion correction and outliner replacement (FSL: eddy); tensor model fitting (FSL: dtifit)

+ Creating a report for quick overview of the data.

Based on the implementation of HCP pipelines for nipype (https://github.com/beOn/hcpre)

Using software packages and nipype:
CBSTOOLS --version 3.1 MRICRON AFNI --version '17.2.17' ANTSENV --version '2.2.0' FREESURFER --version 6.0.0p1, nipype version 0.13.0-geb8a930.dev or 1.1.2

To run it do:
python run_workflow_hcplike.py --run -n 8 --config conf_for_Agewell.conf 

working directory is defined in "run_workflow_hcplike.py", ll.76: working_dir="" (don't change, unless directory is full)


