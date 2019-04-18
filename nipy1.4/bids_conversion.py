# -*- coding: utf-8 -*-
"""
Created on Tue Mar 19 11:08:45 2019

@author: fbeyer
"""


def strip_subj(subj):
    import re
    subject=re.sub('[.]','',subj)
    return subject


def create_bids(dicom_info,bids_info,bids_output,subj, ses):
    import os
    import shutil
    import re
    import json


    subj=re.sub('[.]','',subj)
    
    #print subj
    #print dicom_info
    if not (os.path.isdir('%ssub-%s/ses-%s' %(bids_output,subj,ses))):
        os.makedirs('%ssub-%s/ses-%s' %(bids_output,subj,ses))

    #create necessary folders.
    if not (os.path.isdir('%ssub-%s/ses-%s/anat' %(bids_output,subj,ses))):
        os.mkdir('%ssub-%s/ses-%s/anat' %(bids_output,subj,ses))
    if not (os.path.isdir('%ssub-%s/ses-%s/func' %(bids_output,subj,ses))):
        os.mkdir('%ssub-%s/ses-%s/func' %(bids_output,subj,ses))
    if not (os.path.isdir('%ssub-%s/ses-%s/dwi' %(bids_output,subj,ses))):
        os.mkdir('%ssub-%s/ses-%s/dwi' %(bids_output,subj,ses))
    if not (os.path.isdir('%ssub-%s/ses-%s/fmap' %(bids_output,subj,ses))):
        os.mkdir('%ssub-%s/ses-%s/fmap' %(bids_output,subj,ses))

    for sm in dicom_info:
        
        if sm['protocol_name']=="t2_space_sag_p2_0.9iso":
            #find list element from json
            r = re.compile('.*%s_s%s.json' %(sm['protocol_name'],sm['series_num']))
            sel_json=list(filter(r.match,bids_info))

            shutil.copyfile(sm['nifti_file'], '%ssub-%s/ses-%s/anat/sub-%s_ses-%s_FLAIR.nii.gz' %(bids_output,subj,ses,subj,ses))
            shutil.copyfile(sel_json[0], '%ssub-%s/ses-%s/anat/sub-%s_ses-%s_FLAIR.json' %(bids_output,subj,ses,subj,ses))

        elif sm['series_desc']=="t1_mp2rage_p3_32Ch_T1_Images":

            #find list element from json
            r = re.compile('.*%s_s%s.json' %(sm['protocol_name'],sm['series_num']))
            sel_json=list(filter(r.match,bids_info))

            shutil.copyfile(sm['nifti_file'],'%ssub-%s/ses-%s/anat/sub-%s_ses-%s_T1map.nii.gz' %(bids_output,subj,ses,subj,ses))
            shutil.copyfile(sel_json[0],'%ssub-%s/ses-%s/anat/sub-%s_ses-%s_T1map.json' %(bids_output,subj,ses,subj,ses))

        elif sm['series_desc']=="t1_mp2rage_p3_32Ch_UNI_Images":

            #find list element from json
            r = re.compile('.*%s_s%s.json' %(sm['protocol_name'],sm['series_num']))
            sel_json=list(filter(r.match,bids_info))
            #print sel_json

            shutil.copyfile(sm['nifti_file'], '%ssub-%s/ses-%s/anat/sub-%s_ses-%s_T1w.nii.gz' %(bids_output,subj,ses,subj,ses))
            shutil.copyfile(sel_json[0], '%ssub-%s/ses-%s/anat/sub-%s_ses-%s_T1w.json' %(bids_output,subj,ses,subj,ses))
                       
        elif sm['series_desc']=="cmrr_mbep2d_bold_2.3iso":

            #find list element from json
            r = re.compile('.*%s_s%s.json' %(sm['protocol_name'],sm['series_num']))
            sel_json=list(filter(r.match,bids_info))
            #print sel_json

            shutil.copyfile(sm['nifti_file'], '%ssub-%s/ses-%s/func/sub-%s_ses-%s_task-rest_bold.nii.gz' %(bids_output,subj,ses,subj,ses))
            shutil.copyfile(sel_json[0], '%ssub-%s/ses-%s/func/sub-%s_ses-%s_task-rest_bold.json' %(bids_output,subj,ses,subj,ses))
            
            
            fname='%ssub-%s/ses-%s/func/sub-%s_ses-%s_task-rest_bold.json' %(bids_output,subj,ses,subj,ses)
            with open(fname, 'r') as f:
                data = json.load(f)
                #print data
                data['TaskName']='rest'

            f.close()
            with open(fname, 'w') as f:
                json.dump(data, f)
              
        elif sm['series_desc']=="cmrr_mbep2d_se_2.3iso_norm":

            #find list element from json
            r = re.compile('.*%s_s%s.*.json' %(sm['protocol_name'],sm['series_num']))
            sel_json=list(filter(r.match,bids_info))

            shutil.copyfile(sm['nifti_file'],'%ssub-%s/ses-%s/fmap/sub-%s_ses-%s_dir-norm_epi.nii.gz' %(bids_output,subj,ses,subj,ses))
            shutil.copyfile(sel_json[0],'%ssub-%s/ses-%s/fmap/sub-%s_ses-%s_dir-norm_epi.json' %(bids_output,subj,ses,subj,ses))

            fname='%ssub-%s/ses-%s/fmap/sub-%s_ses-%s_dir-norm_epi.json' %(bids_output,subj,ses,subj,ses)
            with open(fname, 'r') as f:
                data = json.load(f)
                #print data
                data['IntendedFor']='ses-%s/func/sub-%s_ses-%s_task-rest_bold.nii.gz' %(ses,subj,ses)

            f.close()
            with open(fname, 'w') as f:
                json.dump(data, f)
                
        elif sm['series_desc']=="cmrr_mbep2d_se_2.3iso_invpol":
            #find list element from json
            r = re.compile('.*%s_s%s.*.json' %(sm['protocol_name'],sm['series_num']))
            sel_json=list(filter(r.match,bids_info))
            

            shutil.copyfile(sm['nifti_file'],'%ssub-%s/ses-%s/fmap/sub-%s_ses-%s_dir-invpol_epi.nii.gz' %(bids_output,subj,ses,subj,ses))
            shutil.copyfile(sel_json[0],'%ssub-%s/ses-%s/fmap/sub-%s_ses-%s_dir-invpol_epi.json' %(bids_output,subj,ses,subj,ses))

            fname='%ssub-%s/ses-%s/fmap/sub-%s_ses-%s_dir-invpol_epi.json' %(bids_output,subj,ses,subj,ses)
            with open(fname, 'r') as f:
                data = json.load(f)
                #print data
                data['IntendedFor']='ses-%s/func/sub-%s_ses-%s_task-rest_bold.nii.gz' %(ses,subj,ses)

            f.close()
            with open(fname, 'w') as f:
                json.dump(data, f)
                
        elif sm['series_desc']=="cmrr_mbep2d_DTI_32Ch":

                #find list element from json
                r = re.compile('.*%s_s%s.json' %(sm['protocol_name'],sm['series_num']))
                sel_json=list(filter(r.match,bids_info))

                
                shutil.copyfile(sm['nifti_file'], '%ssub-%s/ses-%s/dwi/sub-%s_ses-%s_dwi.nii.gz' %(bids_output,subj,ses,subj,ses))
                shutil.copyfile(sel_json[0], '%ssub-%s/ses-%s/dwi/sub-%s_ses-%s_dwi.json' %(bids_output,subj,ses,subj,ses))


                #copy bval/bvec
                #get dir name of bval/bvex
                dirname=os.path.dirname(sel_json[0])
                shutil.copyfile('%s/%s_s%s.bvec' %(dirname,sm['protocol_name'],sm['series_num']), '%ssub-%s/ses-%s/dwi/sub-%s_ses-%s_dwi.bvec' %(bids_output,subj,ses,subj,ses))
                shutil.copyfile('%s/%s_s%s.bval' %(dirname,sm['protocol_name'],sm['series_num']), '%ssub-%s/ses-%s/dwi/sub-%s_ses-%s_dwi.bval' %(bids_output,subj,ses,subj,ses)) 
                
        elif sm['series_desc']=="cmrr_mbep2d_DTI_32Ch_norm":
                r = re.compile('.*%s_s%s.*.json' %(sm['protocol_name'],sm['series_num']))
                sel_json=list(filter(r.match,bids_info))
                
                
                shutil.copyfile(sm['nifti_file'], '%ssub-%s/ses-%s/fmap/sub-%s_ses-%s_acq-dwi_dir-norm_epi.nii.gz' %(bids_output,subj,ses,subj,ses))
                shutil.copyfile(sel_json[0], '%ssub-%s/ses-%s/fmap/sub-%s_ses-%s_acq-dwi_dir-norm_epi.json' %(bids_output,subj,ses,subj,ses))
                
                fname='%ssub-%s/ses-%s/fmap/sub-%s_ses-%s_acq-dwi_dir-norm_epi.json' %(bids_output,subj,ses,subj,ses)
                with open(fname, 'r') as f:
                    data = json.load(f)
                    #print data
                    data['IntendedFor']='ses-%s/dwi/sub-%s_ses-%s_dwi.nii.gz' %(ses,subj,ses)

                f.close()
                with open(fname, 'w') as f:
                    json.dump(data, f)
        elif sm['series_desc']=="cmrr_mbep2d_DTI_32Ch_invpol":

                r = re.compile('.*%s_s%s.*.json' %(sm['protocol_name'],sm['series_num']))
                sel_json=list(filter(r.match,bids_info))
                
                
                shutil.copyfile(sm['nifti_file'], '%ssub-%s/ses-%s/fmap/sub-%s_ses-%s_acq-dwi_dir-invpol_epi.nii.gz' %(bids_output,subj,ses,subj,ses))
                shutil.copyfile(sel_json[0], '%ssub-%s/ses-%s/fmap/sub-%s_ses-%s_acq-dwi_dir-invpol_epi.json' %(bids_output,subj,ses,subj,ses))
                
                fname='%ssub-%s/ses-%s/fmap/sub-%s_ses-%s_acq-dwi_dir-invpol_epi.json' %(bids_output,subj,ses,subj,ses)
                with open(fname, 'r') as f:
                    data = json.load(f)
                    #print data
                    data['IntendedFor']='ses-%s/dwi/sub-%s_ses-%s_dwi.nii.gz' %(ses,subj,ses)

                f.close()
                with open(fname, 'w') as f:
                    json.dump(data, f)
    
    
    
    
    return 1