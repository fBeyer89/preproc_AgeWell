#!/bin/bash

###PROCESS many logfiles for Agewell_MRI
FSLDIR="/afs/cbs.mpg.de/software/fsl/5.0.9/ubuntu-xenial-amd64/share"
resdir="/data/pt_02030/Data/preprocessed/mst"
cd $resdir
for g in /data/p_02030/*/*-MST_1.log ; do
    #echo $g
    subj=`echo $g | cut -c 15-22`
    fn=${g%.*} 
    echo $fn
    echo $subj
    perl /data/pt_02030/Analysis/Preprocessing/Behavioral/MST/analysis/MST_ausw_1_neu.pl $fn
    mv /data/p_02030/${subj}/*-MST_1.txt $resdir
done


#now count number of correct similar/correct new/old

