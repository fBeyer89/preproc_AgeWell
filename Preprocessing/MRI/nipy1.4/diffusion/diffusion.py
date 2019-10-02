# -*- coding: utf-8 -*-
"""
Created on Thu Aug  9 13:41:03 2018

@author: Rui Zhang
"""

'''
Main workflow for preprocessing of diffusion-weighted data
==========================================================
Uses file structure set up by conversion
'''
from nipype import Node, Workflow
from distor_correct import create_distortion_correct
from nipype.interfaces import fsl
from nipype.interfaces.utility import IdentityInterface
import nipype.interfaces.freesurfer as fs
import nipype.interfaces.utility as util
from inspect import getsourcefile
import os.path as path, sys
current_dir = path.dirname(path.abspath(getsourcefile(lambda:0)))
sys.path.insert(0, current_dir[:current_dir.rfind(path.sep)])
from util import return_list_element
sys.path.pop(0) 

def create_dti():
    # main workflow for preprocessing diffusion data
    # fsl output type
    fsl.FSLCommand.set_default_output_type('NIFTI_GZ')
    # Initiation of a workflow
    dwi_preproc = Workflow(name="dwi_preproc")
    # inputnode
    inputnode = Node(IdentityInterface(fields=[
        'subject_id',
        'freesurfer_dir',
        'aseg',
        'dwi',
        'dwi_ap',
        'dwi_pa',
        'bvals',
        'bvecs'
    ]),
        name='inputnode')
    # output node
    outputnode = Node(IdentityInterface(fields=[
        'dwi_denoised',
        "dwi_unringed",
        "topup_corr",
        "topup_field",
        "topup_fieldcoef",
        "eddy_corr",
        "rotated_bvecs",
        	'total_movement_rms',
        'shell_params',
        'cnr_maps',
        'residuals',
        	'outlier_report',
        'shell_params',
        'dti_fa',
        'dti_md',
        'dti_l1',
        'dti_l2',
        'dti_l3',
        'dti_v1',
        'dti_v2',
        'dti_v3',
        'fa2anat',
        'fa2anat_mat',
        'fa2anat_dat'
    ]),
        name='outputnode')

    '''
    workflow to run distortion correction
    -------------------------------------
    '''
    distor_corr = create_distortion_correct()

    #''
    ## upsampling #TODO: upsample with eddy directly, waiting for Alfred for the method
    #''
    #flirt = Node(fsl.FLIRT(), name='flirt')
    #flirt.inputs.apply_isoxfm = 1
    #TODO: to use this for dtifit, needed to creat another brain mask

    '''
    getting first bval/bvec files
    '''

    
    get_bvalsvecs = Node(util.Function(input_names=["bvals","bvecs","dwi"],
                              output_names=["bval_file","bvec_file"],
                              function = return_list_element), name="get_bvalsvecs")  

    '''
    tensor fitting
    --------------
    '''
    dti = Node(fsl.DTIFit(), name='dti')

    #connecting the nodes
    dwi_preproc.connect([

        (inputnode, distor_corr, [('dwi', 'inputnode.dwi')]),
        (inputnode, distor_corr, [('dwi_ap', 'inputnode.dwi_ap')]),
        (inputnode, distor_corr, [('dwi_pa', 'inputnode.dwi_pa')]),
        (inputnode, get_bvalsvecs, [("bvals", "bvals")]),
        (inputnode, get_bvalsvecs, [("bvecs", "bvecs")]),
        (inputnode, get_bvalsvecs, [("dwi", "dwi")]),
        (get_bvalsvecs, distor_corr, [("bval_file", "inputnode.bvals")]),
        (get_bvalsvecs, distor_corr, [("bvec_file", "inputnode.bvecs")]),
        (get_bvalsvecs, dti, [("bval_file", "bvals")]),
        (distor_corr, outputnode, [('outputnode.bo_brain', 'bo_brain')]),
        (distor_corr, outputnode, [('outputnode.bo_brainmask', 'bo_brainmask')]),
        (distor_corr, outputnode, [('outputnode.noise', 'noise')]),
        (distor_corr, outputnode, [('outputnode.dwi_denoised', 'dwi_denoised')]),
        (distor_corr, outputnode, [('outputnode.dwi_unringed', 'dwi_unringed')]),
        (distor_corr, outputnode, [('outputnode.topup_corr', 'topup_corr')]),
        (distor_corr, outputnode, [('outputnode.topup_field', 'topup_field')]),
        (distor_corr, outputnode, [('outputnode.topup_fieldcoef', 'topup_fieldcoef')]),
        (distor_corr, outputnode, [('outputnode.eddy_corr', 'eddy_corr')]),
        (distor_corr, outputnode, [('outputnode.rotated_bvecs', 'rotated_bvecs')]),
        (distor_corr, outputnode, [('outputnode.total_movement_rms', 'total_movement_rms')]),
        (distor_corr, outputnode, [('outputnode.cnr_maps', 'cnr_maps')]),
        (distor_corr, outputnode, [('outputnode.residuals', 'residuals')]),
        (distor_corr, outputnode, [('outputnode.shell_params', 'shell_params')]),
        (distor_corr, outputnode, [('outputnode.outlier_report', 'outlier_report')]),
        (distor_corr, dti, [("outputnode.rotated_bvecs", "bvecs")]),
        (distor_corr, dti, [('outputnode.bo_brainmask', 'mask')]),
        #(distor_corr, flirt, [('outputnode.eddy_corr', 'in_file')]),
        #(distor_corr, flirt, [('outputnode.eddy_corr', 'reference')]),
        #(flirt, dti, [('out_file', 'dwi')]),
        (distor_corr, dti, [('outputnode.eddy_corr', 'dwi')]),
        (dti, outputnode, [('FA', 'dti_fa')]),
        (dti, outputnode, [('MD', 'dti_md')]),
        (dti, outputnode, [('L1', 'dti_l1')]),
        (dti, outputnode, [('L2', 'dti_l2')]),
        (dti, outputnode, [('L3', 'dti_l3')]),
        (dti, outputnode, [('V1', 'dti_v1')]),
        (dti, outputnode, [('V2', 'dti_v2')]),
        (dti, outputnode, [('V3', 'dti_v3')])

    ])

    '''
    coregistration of FA and T1
    ------------------------------------
    '''

    # linear registration with bbregister
    bbreg = Node(fs.BBRegister(contrast_type='t1',
    out_fsl_file='fa2anat.mat',
    out_reg_file='fa2anat.dat',
    registered_file='fa2anat_bbreg.nii.gz',
    init='fsl'
    ),
    name='bbregister')

    # connecting the nodes
    dwi_preproc.connect([

        (inputnode, bbreg, [('subject_id', 'subject_id')]),
        (inputnode, bbreg, [('freesurfer_dir', 'subjects_dir')]),
        (dti, bbreg, [("FA", "source_file")]),
        (bbreg, outputnode, [('out_fsl_file', 'fa2anat_mat'),
                             ('out_reg_file', 'fa2anat_dat'),
                             ('registered_file', 'fa2anat')])

    ])

    return dwi_preproc
