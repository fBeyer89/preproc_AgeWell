#!/bin/bash

#copy Agewell.de-MRI data

#input: IDs of subjects to be copied (maximal number N=5)
#copies raw DICOMs and preprocessed ASL data to /data/p_02030


for subj in $1 $2 $3 $4 $5
do
echo "copying $subj"

if [ ! -d /data/p_02030/$subj/*.SKYRA ];
then
rsync -ruv /scr/mrincoming/$subj*201* /data/p_02030/$subj
else 
echo "for $subj raw DICOM has been copied"
fi

if [ ! -d /data/p_02030/$subj/ASL ];
then
rsync -ruv /scr/mrincoming/ASL_2018/$subj*201* /data/p_02030/$subj/ASL
else 
echo "$subj ASL has been copied"
fi

done

