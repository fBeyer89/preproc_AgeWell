#!/bin/bash
SUBJECTS_DIR="/data/pt_02030/freesurfer/"
FREESURFER_HOME="/data/pt_02030/scripts/freesurfer_6_dev/"
source $FREESURFER_HOME/SetUpFreeSurfer.sh

##Hippocampus subfield processing.

for subj in 33593.15
do

##first coregister FLAIR image to FS preprocessed

bbregister --s ${subj} --mov /data/p_02030/nifti/${subj}/t2spacesagp209iso*.nii --reg /data/pt_02030/freesurfer/${subj}/mri/transforms/flair2t1.dat --t2 --o /data/pt_02030/freesurfer/${subj}/mri/flair_coreg.mgz


##run HC subfield segmentation:

#first only with T1-weighted
#segmentHA_T1.sh ${subj}

#then including FLAIR information.
segmentHA_T2.sh ${subj} /data/pt_02030/freesurfer/${subj}/mri/flair_coreg.mgz  flair 1

done
