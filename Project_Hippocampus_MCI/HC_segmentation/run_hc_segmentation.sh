#!/bin/bash

#Use Stable FS version https://surfer.nmr.mgh.harvard.edu/fswiki/HippocampalSubfields
#FREESURFER --version 6.0.0p1
#(not development version where an advanced subfield segmentation is implemented: https://surfer.nmr.mgh.harvard.edu/fswiki/HippocampalSubfieldsAndNucleiOfAmygdala)


SUBJECTS_DIR="/data/pt_02030/Data/preprocessed/freesurfer"
cd $SUBJECTS_DIR
#for subj in 34626.f1 #`ls -d 3* ` #29481.6c  #
#do
#recon-all -s $subj -openmp 64 -hippocampal-subfields-T1

#done

#Gather results from HC subfields
quantifyHippocampalSubfields.sh T1 /data/pt_02030/Results/Project_Hippocampus_MCI/HC_subfields.txt

#Also gather whole brain segmentation for TIV
asegstats2table --subjects 29481.6c `ls -d 3* ` --table /data/pt_02030/Results/Project_Hippocampus_MCI/aseg_stats.txt --skip
