# -*- coding: utf-8 -*-
"""
Created on Mon Feb  9 11:12:37 2015

@author: fbeyer
"""

from nipype.pipeline.engine import Workflow, Node
import nipype.interfaces.utility as util
import nipype.interfaces.freesurfer as fs
'''
Workflow to run freesurfer recon-all -all and collect original output
'''
def create_reconall_pipeline(name='reconall_wf'):
    reconall_wf=Workflow(name='reconall_wf')
    #inputnode
    inputnode=Node(util.IdentityInterface(fields=['anat',
    'fs_subjects_dir',
    'fs_subject_id'
    ]),
    name='inputnode')
    outputnode=Node(util.IdentityInterface(fields=['fs_subjects_dir',
    'fs_subject_id']),
    name='outputnode')
    
 
    # run reconall
    reconall = Node(fs.ReconAll(args='-all -no-isrunning', openmp=8), #subfield segmentation after recon-all
    name="reconall")
    #recon_all.inputs.directive= 'autorecon2-wm' # -autorecon3
    reconall_wf.plugin_args={'submit_specs': 'request_memory = 9000'}
    reconall_wf.connect([
    (inputnode, reconall,  [('fs_subject_id', 'subject_id')]),
    (inputnode, reconall, [('fs_subjects_dir', 'subjects_dir'),
                            ('anat', 'T1_files')]),
    (reconall, outputnode, [('subject_id', 'fs_subject_id'),
    ('subjects_dir', 'fs_subjects_dir')])
    ])
    return reconall_wf
