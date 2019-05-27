
#singularity run -B /data/pt_neuam005 /data/pt_neuam005/episodic_gradients/fmriprep_run/fmriprep-1.1.2.simg  --fs-license-file /data/pt_neuam005/episodic_gradients/fmriprep_run/license.txt /data/pt_neuam005/tmp_data/BIDS/ /data/pt_neuam005/tmp_out/sub-01 -w /data/pt_neuam005/tmp_work/sub-01 --bold2t1w-dof 12  --nthreads 16  --template MNI152NLin2009cAsym --output-space template  --template-resampling-grid 2mm participant --participant-label 01
#


singularity run -B /data/pt_life/data_fbeyer/myimages/mri_qc_latest.simg /data/p_02030/BIDS /data/pt_02030/wd_preprocessing/ 34113a5


