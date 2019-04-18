#!/bin/bash


DATA="/data/pt_02030/preprocessed/dti/tracula/33724.98/"
freeview -v $DATA/dmri/dtifit_FA.nii.gz \
            $DATA/dpath/rh.ilf_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=heat:isosurface=0,0:color='Red':name=rh.ilf \
            $DATA/dpath/lh.ilf_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=heat:isosurface=0,0:color='Red':name=lh.ilf


freeview -tv $DATA/dpath/merged_avg33_mni_bbr.mgz \
         -v $DATA/dmri/dtifit_FA.nii.gz &
