

##create BIDS dataset
niidir="/data/pt_02030/"
dcmdir="/data/p_02030/"
for subj in 33219.97; do
	echo "Processing subject $subj"

###Create structure
mkdir -p ${niidir}/sub-${subj}/ses-1/anat

###Convert dcm to nii
#Only convert the Dicom folder anat

cd ${niidir}/sub-${subj}/ses-1/anat

dcm2niix -o ${niidir}/sub-${subj} -f ${subj}_%f_%p ${dcmdir}/${subj}/${subj}_2018*/DICOM


mv ${niidir}/sub-${subj}/*_t1_mp2rage_p3_32Chc.nii /data/pt_02030/BIDS/test/sub-01/ses-01/anat/sub-01_ses-01_T1w.nii
#/data/pt_02030/BIDS/sub-33219.97/33219.97_DICOM_t1_mp2rage_p3_32Chc.json
done

