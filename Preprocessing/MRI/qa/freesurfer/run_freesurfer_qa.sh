#run freesurfer quality checks according to 
#Klapwijk: Qoala-T: A supervised-learning tool for quality control of FreeSurfer segmented MRI data
SUBJECTS_DIR="/data/pt_02030/Data/preprocessed/freesurfer"
#SUBJECTS_DIR="/data/pt_nro186_lifeupdate/preprocessing/FREESURFER/VERIO/"
for subj in 34561.a3



do
view="tkmedit ${subj} brainmask.mgz -surfs -aux wm.mgz"
eval $view

done


