# -*- coding: utf-8 -*-
"""
Created on Mon Feb  9 12:33:07 2015

@author: fbeyer
"""

from nipype.pipeline.engine import Node, Workflow
import nipype.interfaces.utility as util
import nipype.interfaces.fsl as fsl
import nipype.interfaces.freesurfer as fs

'''
Workflow using topup to do fieldmap correction
as described in section "Acquiring a field map, method 2: opposite phase encoded EPIs"
on https://lcni.uoregon.edu/kb-articles/kb-0003
'''


def create_topup_coreg_pipeline(name='fmap_coreg'):
    # fsl output type
    fsl.FSLCommand.set_default_output_type('NIFTI_GZ')
    # initiate workflow
    fmap_coreg = Workflow(name='fmap_coreg')
    # inputnode
    inputnode = Node(util.IdentityInterface(fields=['epi_mean',
                                                    'ap',
                                                    'pa',
                                                    'anat_head',
                                                    'anat_brain',
                                                    'fs_subject_id',
                                                    'fs_subjects_dir',
                                                    'echo_space',
                                                    'pe_dir'
                                                    ]),
                     name='inputnode')
    # outputnode
    outputnode = Node(util.IdentityInterface(fields=['fmap',
                                                     'shiftmap',
                                                     'unwarpfield_epi2fmap',
                                                     'unwarped_mean_epi2fmap',
                                                     'epi2anat_mat',
                                                     'epi2anat_dat',
                                                     'epi2anat_mincost',
                                                     'epi2anat',
                                                     'epi2fmap',
                                                     'fmap_fullwarp']),
                      name='outputnode')

    #### merge epi ap and pa
    mergeToFilelist = Node(util.Merge(2), infields = ['in1','in2'],name='mergeToFilelist')
    
    merge_appa=Node(fsl.Merge(),name='merge_appa')
    merge_appa.inputs.dimension='t'
    merge_appa.inputs.merged_file='cmrr_mbep2d_se_23iso_norm.nii.gz'
    
    #use mean file of ap-pa acquisitions as "Mag"-image from fieldmap, only used for coregistration with mean EPI
    mean_appa=Node(fsl.MeanImage(), name='mean_appa')
    

    #### use topup --> creates fieldmap
    topup_prep=Node(fsl.TOPUP(), name='topup_prep')
    topup_prep.inputs.encoding_file='/data/pt_02030/scripts/nipy1.4/functional/aquisition_params.txt'
    
    #multiply topup result to convert to rad/s 
    convertHz_rad=Node(fsl.maths.MathsCommand(args='-mul 6.28'), name='convertHz_rad')
    fmap_coreg.connect([(inputnode, mergeToFilelist, [('ap','in1')]),
                        (inputnode, mergeToFilelist, [('pa','in2')]),
                        (mergeToFilelist, merge_appa, [('out','in_files')]),
                        (merge_appa, mean_appa, [('merged_file', 'in_file')]),
                        (merge_appa, topup_prep, [('merged_file','in_file')]),
                        (topup_prep, convertHz_rad, [('out_field', 'in_file')])
                        ])
    

    #### unmask fieldmap #### is maybe not needed as our fieldmap is already in the whole image space?
    fmap_mask = Node(fsl.maths.MathsCommand(args='-abs -bin'),
                     name='fmap_mask')
#    unmask = Node(fsl.FUGUE(save_unmasked_fmap=True),
#                  name='unmask')
    fmap_coreg.connect([(convertHz_rad, fmap_mask, [('out_file', 'in_file')])
#                        (fmap_mask, unmask, [('out_file', 'mask_file')]),
#                        (convertHz_rad, unmask, [('out_file', 'fmap_in_file')]),
#                        (inputnode, unmask, [('pe_dir', 'unwarp_direction')])
                        ])


    #### register epi to fieldmap ####
    epi2fmap = Node(fsl.FLIRT(dof=6,
                              out_file='rest_mean2fmap.nii.gz',
                              interp='spline'),
                    name='epi2fmap')
    fmap_coreg.connect([(inputnode, epi2fmap, [('epi_mean', 'in_file')]),
                        (mean_appa, epi2fmap, [('out_file', 'reference')]),
                        (epi2fmap, outputnode, [('out_file', 'epi2fmap')])
                        ])

    #### unwarp epi with fieldmap ####
    unwarp = Node(fsl.FUGUE(save_shift=True),
                  name='unwarp')
    fmap_coreg.connect([(epi2fmap, unwarp, [('out_file', 'in_file')]),
                        (convertHz_rad, unwarp, [('out_file', 'fmap_in_file')]),
                        (fmap_mask, unwarp, [('out_file', 'mask_file')]),
                        (inputnode, unwarp, [('echo_space', 'dwell_time'),
                                             ('pe_dir', 'unwarp_direction')]),
                        (unwarp, outputnode, [('shift_out_file', 'shiftmap')])
                        ])

    #### make warpfield and apply ####
    convertwarp0 = Node(fsl.utils.ConvertWarp(out_relwarp=True,
                                              out_file='rest_mean2fmap_unwarpfield.nii.gz'),
                        name='convertwarp0')
    applywarp0 = Node(fsl.ApplyWarp(interp='spline',
                                    relwarp=True,
                                    out_file='rest_mean2fmap_unwarped.nii.gz',
                                    datatype='float'),
                      name='applywarp0')
    fmap_coreg.connect([(mean_appa, convertwarp0, [('out_file', 'reference')]),
                        (epi2fmap, convertwarp0, [('out_matrix_file', 'premat')]),
                        (unwarp, convertwarp0, [('shift_out_file', 'shift_in_file')]),
                        (inputnode, convertwarp0, [('pe_dir', 'shift_direction')]),
                        (inputnode, applywarp0, [('epi_mean', 'in_file')]),
                        (mean_appa, applywarp0, [('out_file', 'ref_file')]),
                        (convertwarp0, applywarp0, [('out_file', 'field_file')]),
                        (convertwarp0, outputnode, [('out_file', 'unwarpfield_epi2fmap')]),
                        (applywarp0, outputnode, [('out_file', 'unwarped_mean_epi2fmap')])
                        ])

    #### register epi to anatomy #####
    # linear registration with bbregister
    bbregister = Node(fs.BBRegister(contrast_type='t2',
                                    out_fsl_file='rest2anat.mat',
                                    out_reg_file='rest2anat.dat',
                                    registered_file='rest_mean2anat_highres.nii.gz',
                                    init='fsl',
                                    epi_mask=True
                                    ),
                      name='bbregister')
    fmap_coreg.connect([(applywarp0, bbregister, [('out_file', 'source_file')]),
                        (inputnode, bbregister, [('fs_subjects_dir', 'subjects_dir'),
                                                 ('fs_subject_id', 'subject_id')]),
                        (bbregister, outputnode, [('out_fsl_file', 'epi2anat_mat'),
                                                  ('out_reg_file', 'epi2anat_dat'),
                                                  ('registered_file', 'epi2anat'),
                                                  ('min_cost_file', 'epi2anat_mincost')
                                                  ]),
                        ])
    # make warpfield
    convertwarp = Node(fsl.utils.ConvertWarp(out_relwarp=True,
                                             out_file='fullwarpfield.nii.gz'),
                       name='convertwarp')
    fmap_coreg.connect([(inputnode, convertwarp, [('anat_head', 'reference')]),
                        (convertwarp0, convertwarp, [('out_file', 'warp1')]),
                        (bbregister, convertwarp, [('out_fsl_file', 'postmat')]),
                        (convertwarp, outputnode, [('out_file', 'fmap_fullwarp')])
                        ])
    return fmap_coreg
