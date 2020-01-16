

for subj in `cat /data/p_02030/participants_16.01.2020.txt`
do

if [ -d /data/pt_02030/Data/wd_preprocessing/hcp_prep_workflow/_subject_${subj}/bids/BIDS/ ];
then
mv /data/pt_02030/Data/wd_preprocessing/hcp_prep_workflow/_subject_${subj}/bids/BIDS/* /data/p_02030/BIDS/

else

echo "does not exist in BIDS"

fi

done
