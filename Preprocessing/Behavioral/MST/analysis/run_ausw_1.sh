#!/bin/bash

###PROCESS many logfiles for Agewell_MRI
FSLDIR="/afs/cbs.mpg.de/software/fsl/5.0.9/ubuntu-xenial-amd64/share"
resdir="/data/pt_02030/preprocessed/mst"
cd $resdir
for g in /data/p_02030/*/*-MST_1.log ; do
    #echo $g
    fn=${g%.*} 
    echo $fn
    perl /data/pt_02030/scripts/MST/analysis/MST_ausw_1_neu.pl $fn
done


#now count number of correct similar/correct new/old

