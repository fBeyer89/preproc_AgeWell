#!/usr/bin/python
"""
Created on Fri Mar 15 11:51:51 2019

@author: fbeyer
"""
import shutil
import os
import nipype.pipeline.engine as pe
from nipype.interfaces.dcm2nii import Dcm2niix
import nipype.interfaces.utility as util
from nipype.interfaces.utility import Function
import nipype.interfaces.io as nio
from bids_conversion import create_bids
from interfaces_bids import *
from config import *
from util import *
sys.path.pop(0) 


subject_list=['33307.92', '33434.7f', '33503.0e', '33486.7e','33698.f1','33555.22','33724.98','33593.15','33219.97','33808.e4','33809.60']
subj_node=pe.Node(name="subj_node", interface=util.IdentityInterface(fields=["subject"]))
subj_node.iterables = ('subject', subject_list)

dicom_grabber = pe.Node(
                    name = "dicom_source_1",
                    interface = nio.DataGrabber(
                            infields = ["subject"],
                            outfields = ["dicom"],))
dicom_grabber.inputs.template = "subject"
dicom_grabber.inputs.template_args = {"dicom": [["subject"]]}
dicom_grabber.inputs.sort_filelist = True
dicom_grabber.inputs.sort_filelist = True
dicom_grabber.inputs.base_directory = '/data/p_02030/'
dicom_grabber.inputs.field_template = {"dicom": '%s/*_201*/DICOM/*'}


nii_wrangler = pe.Node(name="nii_wrangler", interface=NiiWrangler())


dicom_convert=pe.Node(name="dicom_convert", interface=Dcm2niix())
dicom_convert.inputs.out_filename="%p_s%s"
#
#
dicom_info = pe.Node(name="dicom_info", interface=DicomInfo())


cb_node=pe.Node(name='cb_node', interface=Function(
                           input_names=["dicom_info","bids_info","bids_output","subj","ses"],
                           output_names=["out"],
                           function=create_bids)
                           )
cb_node.inputs.ses='bl'
cb_node.inputs.bids_output='/data/p_02030/BIDS/'
cb_node.inputs.dicom_info=dicom_info



data_sink = pe.Node(name="data_sink", interface=nio.DataSink())
data_sink.inputs.base_directory='/data/pt_02030/wd_preprocessing/bids_convert/tmp'


bids_convert = pe.Workflow(name='bids_convert')
bids_convert.base_dir = '/data/pt_02030/wd_preprocessing/'
bids_convert.config['execution']['crashdump_dir'] = bids_convert.base_dir + "/crash_files"
#
#
bids_convert.connect(
[
(subj_node, dicom_grabber, [("subject", "subject")]),
(dicom_grabber, dicom_convert, [("dicom", "source_names")]),
(dicom_grabber, dicom_info, [("dicom", "files")]),
(dicom_convert, nii_wrangler, [("converted_files", "nii_files")]),       
(dicom_info, nii_wrangler, [("info", "dicom_info")]),
(nii_wrangler, cb_node, [('dicom_info', 'dicom_info')]),
(dicom_convert, cb_node, [('bids', 'bids_info')]),
(subj_node, cb_node,  [('subject','subj')]),
(dicom_convert, data_sink, [('bvals','bvals')]),
(dicom_convert, data_sink, [('bvecs','bvecs')])
  #
])
#
bids_convert.run(plugin="MultiProc", plugin_args={"n_procs" : 8, "non_daemon" : True})





