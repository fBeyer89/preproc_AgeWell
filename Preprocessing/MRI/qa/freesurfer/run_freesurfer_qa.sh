#run freesurfer quality checks in depth
FREESURFER --version 6.0
export SUBJECTS_DIR="/data/pt_02030/freesurfer"
export QA_TOOLS="/home/raid1/fbeyer/Documents/Scripts/AgeWell/QAtools_v1.2"
subjectlist="/data/pt_02030/Analysis/participants.txt"

$QA_TOOLS/recon_checker -s `cat ${subjectlist}`
