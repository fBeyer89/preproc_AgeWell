# -*- coding: utf-8 -*-
"""
Created on Mon Feb  9 14:33:51 2015

@author: fbeyer
"""

'''
Main workflow for preprocessing of mprage data
===============================================
Uses file structure set up by conversion
'''
from nipype.pipeline.engine import Node, Workflow
import nipype.interfaces.io as nio
from reconall import create_reconall_pipeline
from mp2rage_cbstools import create_mp2rage_pipeline
from mgzconvert import create_mgzconvert_pipeline
from ants import create_normalize_pipeline
import nipype.interfaces.utility as util


def create_structural():
 
    # main workflow
    struct_preproc = Workflow(name='anat_preproc')   
    #struct_preproc.config['execution']['crashdump_dir'] = struct_preproc.base_dir + "/crash_files"
    #inputnode
    inputnode=Node(util.IdentityInterface(fields=['subject','inv2', 't1map', 'uni',
    'out_dir',
    'freesurfer_dir',
    'standard_brain'
    ]),
    name='inputnode')    
    
    outputnode=Node(util.IdentityInterface(fields=['brain','brainmask','anat2std_transforms','std2anat_transforms','anat2std',
                                                   'anat_head','wmseg','wmedge', 'subject_id', 'uni_masked', 'background_mask']),
    name='outputnode')      
    
        
    # workflow for mp2rage background masking
    mp2rage=create_mp2rage_pipeline()
    
    # workflow to run freesurfer reconall
    reconall=create_reconall_pipeline()
    
    # workflow to get brain, head and wmseg from freesurfer and convert to nifti
    mgzconvert = create_mgzconvert_pipeline()
   
    normalize = create_normalize_pipeline()

    # sink to store files
    #sink = Node(nio.DataSink(parameterization=False,
    #                         substitutions=[
    #                             ('transform_Warped', 'T1_brain2mni')]),
    #            name='sink')

    # connections
    struct_preproc.connect(
        [(inputnode, mp2rage, [('inv2', 'inputnode.inv2'),
                               ('t1map', 'inputnode.t1map'),
                               ('uni', 'inputnode.uni')]),
         (mp2rage, reconall, [('outputnode.uni_stripped', 'inputnode.anat')]),
         (inputnode, reconall, [('subject', 'inputnode.fs_subject_id')]),
         (inputnode, reconall, [('freesurfer_dir', 'inputnode.fs_subjects_dir')]),
         (inputnode, mgzconvert, [('freesurfer_dir', 'inputnode.fs_subjects_dir')]),
         (reconall, mgzconvert,  [('outputnode.fs_subject_id', 'inputnode.fs_subject_id')]),  
         (inputnode, normalize, [('standard_brain', 'inputnode.standard')]),  
         (mgzconvert, normalize, [('outputnode.anat_brain', 'inputnode.anat')]),
         (normalize, outputnode, [('outputnode.anat2std', 'anat2std'),
                            ('outputnode.anat2std_transforms', 'anat2std_transforms'),
                            ('outputnode.std2anat_transforms', 'std2anat_transforms')]),
         (mgzconvert, outputnode, [('outputnode.anat_brain', 'brain')]),
         (mgzconvert, outputnode, [('outputnode.anat_brain_mask', 'brainmask')]),
         (mgzconvert, outputnode, [('outputnode.anat_head', 'anat_head')]),
         (mgzconvert, outputnode, [('outputnode.wmseg', 'wmseg')]),
         (mgzconvert, outputnode, [('outputnode.wmedge', 'wmedge')]),
         (reconall, outputnode, [('outputnode.fs_subject_id', 'subject_id')]),
         (mp2rage, outputnode,  [('outputnode.uni_masked', 'uni_masked'),
                                 ('outputnode.background_mask', 'background_mask')])
         ])

    return struct_preproc
