### Scripts for AGEWELL_MRI (NRO-211)

* bash_scripts  
  
  * copy_agewell_data.sh > copy data from MR incoming
  
  * create_BIDS_format.sh > make BIDS format without nipype

* nipy1.4

  * **anatomical, DWI and resting-state** preprocessing based on nipype.  
   See readme in this folder.

* tracula
  
  * **tract reconstruction** with Freesurfer.  
  Use run_tracula.sh together with configuration file dmrirc.

* qa 

  * freesurfer: run_freesurfer_qa.sh uses QAtools_v1.2 to create FS visual reports
  
  * diffusion: subject- and group-level eddy QC scripts
  
* Scan_protocol_Skyra_Agewell_BL.pdf: Siemens protocol of scans performed in AgeWell-baseline.
  
  * functional: run_rsqc.py creates more detailed QA plots for rsfMRI