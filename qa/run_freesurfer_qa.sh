#run freesurfer quality checks in depth
FREESURFER --version 6.0
export SUBJECTS_DIR="/data/pt_02030/freesurfer"
export QA_TOOLS="/home/raid1/fbeyer/Documents/Scripts/AgeWell/QAtools_v1.2"


$QA_TOOLS/recon_checker -s 33698.f1 33555.22 33503.0e 33486.7e 33307.92 33434.7f 33219.97
