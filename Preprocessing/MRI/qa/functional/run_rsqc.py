#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue May 21 10:16:37 2019
#eddy quality control
@author: fbeyer
"""
from nipype import Node, Workflow, Function
from nipype.interfaces import fsl
from nipype.interfaces.utility import IdentityInterface
import nipype.interfaces.freesurfer as fs
import nipype.interfaces.afni as afni
import nipype.interfaces.utility as util
import nipype.interfaces.io as nio    
from utils import make_the_plot, calc_frame_displacement, get_aseg, plot_fft
import numpy as np 
import nibabel as nb
import matplotlib
import matplotlib.pyplot as plt
import pandas as pd




def create_rs_qc(subjectlist):
    # main workflow for extended qc of diffusion/rsfmri data
    # fsl output type
    fsl.FSLCommand.set_default_output_type('NIFTI_GZ')
    # some hard coded things
    fd_thres=0.2
    tr=1.4

    # Specify the location of the preprocessed data    
    data_dir="/data/pt_02030/wd_preprocessing/hcp_prep_workflow/resting/"
    working_dir="/data/pt_02030/wd_preprocessing/" #MODIFY
    freesurfer_dir="/data/pt_02030/preprocessed/freesurfer/"
   
    qc = Workflow(name="qc")
    qc.base_dir = working_dir + '/' 
    qc.config['execution']['crashdump_dir'] = qc.base_dir + "/crash_files"
    
    #first get all data needed
    identitynode = Node(util.IdentityInterface(fields=['subject']),
                    name='identitynode')
    identitynode.iterables = ('subject', subjectlist)
    
    info = dict(
       func=[['transform_timeseries/','_subject_','subj','/merge/rest2anat.nii.gz']],
       dvars=[['transform_timeseries/','_subject_','subj','/dvars/rest2anat_dvars.tsv']],
       motpars=[['/motion_correction/','_subject_','subj','/mcflirt/rest_realigned.nii.gz.par']],
       brainmask=[['transform_timeseries/','_subject_','subj','/resample_brain/T1_brain_mask_lowres.nii.gz']])  
    
    ds_rs = Node(
    interface=nio.DataGrabber(infields=['subj'], outfields=['func', 'dvars','motpars','brainmask']),
    name='ds_rs')    
    ds_rs.inputs.base_directory = data_dir
    ds_rs.inputs.template = '%s%s%s%s' 
    ds_rs.inputs.template_args = info
    ds_rs.inputs.sort_filelist = True   

    get_fs=Node(nio.FreeSurferSource(), name="get_fs")
    get_fs.inputs.subjects_dir=freesurfer_dir
    
    
    get_correct_aseg=Node (util.Function(
            input_names=['in_list'],
            output_names=['out_aseg'],
            function=get_aseg), name="get_correct_aseg")
    
    convert=Node(fs.MRIConvert(), name="convert")
    convert.inputs.out_type="niigz"
    
    downsample= Node(afni.Resample(resample_mode='NN',
        outputtype='NIFTI_GZ',
        out_file='aparcaseg_lowres.nii.gz'),
        name = 'downsample')
        
    
    
    
    calc_fd = Node(util.Function(
            input_names=['realignment_parameters_file', 'parameter_source'],
            output_names=['FD_power','fn'],
            function=calc_frame_displacement), name="calc_fd")
    calc_fd.inputs.parameter_source='FSL'
    
    outliers = Node(afni.OutlierCount(fraction=True, out_file='outliers.out'),
                       name='outliers', mem_gb=1 * 2.5)
    
    bigplot = Node(util.Function(
        input_names=['func', 'seg', 'tr', 'fd_thres', 'outliers', 'dvars', 'fd', 'subj','outfile'],
        output_names=['fn', 'dataframe'],
        function=make_the_plot), name="bigplot")
    bigplot.inputs.tr=tr
    bigplot.inputs.fd_thres=fd_thres
    bigplot.inputs.outfile="summary_fmriplot.png"
    
    fftplot= Node(util.Function(
        input_names=['fn_pd', 'tr'],
        output_names=['fn'],
        function=plot_fft), name="fftplot")
    fftplot.inputs.tr=tr

    
    datasink =Node(name="datasink", interface=nio.DataSink())
    datasink.inputs.base_directory="/data/pt_02030/preprocessed/reports/"
    datasink.inputs.substitutions=[('_subject_', '')]
    
    qc.connect([(identitynode, get_fs, [('subject', 'subject_id')]),
                (identitynode, ds_rs, [('subject', 'subj')]),
                (identitynode, bigplot, [('subject', 'subj')]),
                (get_fs, get_correct_aseg, [('aparc_aseg', 'in_list')]),
                (get_correct_aseg, convert,[('out_aseg', 'in_file')]),
                (convert, downsample, [('out_file', 'in_file')]),
                (ds_rs, downsample, [('func', 'master')]),
                (downsample, bigplot, [('out_file', 'seg')]),
                (ds_rs, calc_fd, [('motpars', 'realignment_parameters_file')]),
                (ds_rs, bigplot, [('func', 'func')]),
                (ds_rs, bigplot, [('dvars', 'dvars')]),
                (calc_fd, bigplot, [('FD_power', 'fd')]),
                (ds_rs, outliers, [('func', 'in_file')]),
                (ds_rs, outliers, [('brainmask', 'mask')]),
                (outliers, bigplot, [('out_file', 'outliers')]),
                (bigplot, datasink, [('fn','detailedQA.@bigplot')]),  
                (bigplot, fftplot, [('dataframe', 'fn_pd')]),
                (bigplot, datasink, [('dataframe', 'detailedQA.metrics.@dataframe')]),
                (fftplot, datasink, [('fn', 'detailedQA.@fftplot')]),
                (calc_fd, datasink, [('fn', 'detailedQA.metrics.@fd')])
                ])    


    qc.run(plugin="MultiProc", plugin_args={"n_procs" : 16, "non_daemon" : True})
    

 
    return qc


df=pd.read_table('/data/p_02030/BIDS/participants.tsv',header=None)

subj=df[0].values[5:]#skip the first 5 in the list.
qc=create_rs_qc(subj)
#qc.run()    
   




