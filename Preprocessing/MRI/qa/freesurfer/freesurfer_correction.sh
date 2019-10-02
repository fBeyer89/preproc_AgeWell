#run freesurfer corrections
FREESURFER --version 6.0
export SUBJECTS_DIR="/data/pt_02030/freesurfer"

subj="33503.0e"

##first copy old freesurfer results to "uncorrected_versions"-folder
cp -R /data/pt_02030/freesurfer/${subj} /data/pt_02030/freesurfer/uncorrected_versions/${subj}

##correct the skullstrip (necessary if brainmask is very faulty and MNI space registration shows signs of skull and/or the surfaces are wrong)
recon-all -skullstrip -clean-bm -gcut -subjid ${subj}

##if the result is not satisfying, do manual correction

##rerun the surfaces (if pials were wrong) 
recon-all -autorecon-pial -subjid ${subj}

#otherwise rerun workflow to use new brainmask.mgz for MNI registration.
