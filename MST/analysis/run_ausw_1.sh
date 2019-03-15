#!/bin/bash

###PROCESS many logfiles for Agewell_MRI
FSLDIR="/afs/cbs.mpg.de/software/fsl/5.0.9/ubuntu-xenial-amd64/share"
dir="/data/modify/path/here"
cd $dir
for g in A1_FU1_*.log ; do
    #echo $g
    fn=${g%.*} 
    echo $dir$fn
    perl MST_ausw_1_neu.pl $dir$fn
done


#now count number of correct similar/correct new/old

