#run freesurfer corrections
FREESURFER --version 6.0
export SUBJECTS_DIR="/data/pt_02030/freesurfer"

subj="33503.0e"

##first copy old freesurfer results to "uncorrected_versions"-folder
cp -R /data/pt_02030/freesurfer/${subj} /data/pt_02030/freesurfer/uncorrected_versions/${subj}



##Issue 1:
##correct the skullstrip (necessary if brainmask is very faulty and MNI space registration shows signs of skull and/or the surfaces are wrong)
recon-all -skullstrip -clean-bm -gcut -subjid ${subj}

#see results.
freeview -v ${SUBJECTS_DIR}/${subject}/mri/brain.mgz ${SUBJECTS_DIR}/${subject}/mri/T1.mgz ${SUBJECTS_DIR}/${subject}/mri/brainmask.gcuts.mgz:colormap=heat

##if the result is not satisfying, do manual correction

##rerun the surfaces (if pials were wrong) 
recon-all -autorecon-pial -subjid ${subj}

#otherwise rerun workflow to use new brainmask.mgz for MNI registration.



##Issue 2:

#open freeview to set controlpoints
freeview ${SUBJECTS_DIR}/${subj}/mri/brainmask.mgz -f ${SUBJECTS_DIR}/${subj}/surf/lh.pial:edgecolor=lightgreen ${SUBJECTS_DIR}/${subj}/surf/lh.white:edgecolor=white ${SUBJECTS_DIR}/${subje}/surf/rh.pial:edgecolor=lightgreen ${SUBJECTS_DIR}/${subj}/surf/rh.white:edgecolor=white

##rerun freesurfer steps 2/3
recon-all -autorecon2-cp -autorecon3 -subjid ${subj}

##check results
freeview ${SUBJECTS_DIR}/${subj}/mri/brain.mgz -f ${SUBJECTS_DIR}/${subj}/surf/lh.pial:edgecolor=lightgreen ${SUBJECTS_DIR}/${subj}/surf/lh.white:edgecolor=white ${SUBJECTS_DIR}/${subj}/surf/rh.pial:edgecolor=lightgreen ${SUBJECTS_DIR}/${subj}/surf/rh.white:edgecolor=white /data/pt_02030/freesurfer/uncorrected_versions/${subj}/surf/lh.pial:edgecolor=red /data/pt_02030/freesurfer/uncorrected_versions/${subj}/surf/rh.pial:edgecolor=red /data/pt_02030/freesurfer/uncorrected_versions/${subj}/surf/lh.white:edgecolor=blue /data/pt_02030/freesurfer/uncorrected_versions/${subj}/surf/rh.white:edgecolor=blue

