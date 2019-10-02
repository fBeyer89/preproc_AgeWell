import nipype.interfaces.io as nio           # Data i/o
import nipype.interfaces.utility as util     # utility
import nipype.pipeline.engine as pe   
from nipype import Function
from nipype.interfaces.dcm2nii import Dcm2niix
from interfaces import *
from config import *
from util import *
from bids_conversion import *

class HCPrepWorkflow(pe.Workflow):
    def __init__(self, config=None, base_dir=None, *args, **kwargs):
        super(HCPrepWorkflow, self).__init__(*args, **kwargs)
        self.hc_config = config
        self.base_dir = base_dir

    @property
    def hc_config(self):
        return self._hc_config
    @hc_config.setter
    def hc_config(self, value):
        self._hc_config = value
        if self._hc_config:
            self.update_nodes_from_config()

    def get_conf(self, section, option):
        if not self.hc_config:
            return None
        return self.hc_config.get(section,{}).get(option, None)

    def update_nodes_from_config(self):
        # subjects node
        subs = self.get_conf("general","subjects")
        if subs:
            self.subjects_node.iterables = ("subject", subs)
        # dcm grabber
        sub_dir = self.get_conf("general","subject_dir")
        dcm_temp = self.get_conf("general","dicom_template")    
        fs_dir = "/data/pt_02030/Data/preprocessed/freesurfer"
        out_dir = self.get_conf("general","out_dir")
        report_dir=self.get_conf("general","report_dir")
        standard = self.get_conf("templates","t1_template_2mm")  
        outputdir_dti=self.get_conf("general", "outputdir_dti")
        outputdir_resting=self.get_conf("general", "outputdir_resting")
        bids_outputdir=self.get_conf("general", "bids_outputdir")
        vol_to_remove=self.get_conf("rspreproc","vol_to_remove")
        epi_resolution=self.get_conf("rspreproc","epi_resolution")
        ep_unwarp_dir=self.get_conf("rspreproc","ep_unwarp_dir")
        #working_dir = self.get_conf("general","working_dir")     
        if sub_dir:
            self.dicom_grabber.inputs.base_directory = sub_dir
            self.data_sink.inputs.base_directory=sub_dir 
            self.data_sink.inputs.substitutions=[('_subject_', '')]
        if dcm_temp:
            self.dicom_grabber.inputs.field_template = {"dicom": dcm_temp}   
        if fs_dir:
            self.structural_wf.inputs.inputnode.freesurfer_dir=fs_dir
            self.resting.inputs.inputnode.freesurfer_dir=fs_dir
	    self.dwi_wf.inputs.inputnode.freesurfer_dir=fs_dir
            self.report.inputs.inputnode.freesurfer_dir=fs_dir
        if out_dir:
            self.structural_wf.inputs.inputnode.out_dir=out_dir
            self.resting.inputs.inputnode.out_dir=out_dir
        if report_dir:
            self.report.inputs.inputnode.out_dir=report_dir
        if standard:
            self.structural_wf.inputs.inputnode.standard_brain=standard  
        if vol_to_remove:
            self.resting.inputs.inputnode.vol_to_remove=vol_to_remove
        if epi_resolution:
            self.resting.inputs.inputnode.epi_resolution=epi_resolution           
        if outputdir_resting:
            self.data_sink_rs.inputs.base_directory=outputdir_resting
            self.data_sink_rs.inputs.substitutions=[('_subject_', '')]
        if outputdir_dti:
            self.data_sink_dti.inputs.base_directory=outputdir_dti
            self.data_sink_dti.inputs.substitutions=[('_subject_', '')]
        if bids_outputdir:
            self.bids.inputs.bids_output=bids_outputdir
        if ep_unwarp_dir:
            self.resting.inputs.inputnode.pe_dir=ep_unwarp_dir
                            
        # nifti wrangler
        series_map = self.hc_config.get("series", {})
        if series_map:
            self.nii_wrangler.inputs.series_map = series_map
        # set template and config values (names are also input names on some nodes)
        temps = self.hc_config.get("templates", {})
        c_files = self.hc_config.get("config_files", {})
        # any other per-step hcp config - a good place to overide un-derived values
        apply_dict_to_obj(self.hc_config.get("nifti_wrangler", {}), self.nii_wrangler.inputs)

    def run(self, *args, **kwargs):
        self.connect_nodes()
        super(HCPrepWorkflow, self).run(*args, **kwargs)

    def write_graph(self, *args, **kwargs):
        self.connect_nodes()
        super(HCPrepWorkflow, self).write_graph(*args, **kwargs)
        
    def clear_nodes(self):
        all_nodes = self._get_all_nodes()
        if all_nodes is not None:
            self.remove_nodes(all_nodes)

    def connect_nodes(self):
        # Some connections that don't change
        self.clear_nodes()
        self.connect([
            # prep steps
            (self.subjects_node, self.dicom_grabber, [("subject", "subject")]),
            (self.dicom_grabber, self.dicom_convert, [("dicom", "source_names")]),
            (self.dicom_grabber, self.dicom_info, [("dicom", "files")]),
            (self.dicom_convert, self.nii_wrangler, [("converted_files", "nii_files")]),                  
            (self.dicom_info, self.nii_wrangler, [("info", "dicom_info")]),
            (self.nii_wrangler, self.bids, [('dicom_info', 'dicom_info')]),
            (self.dicom_convert, self.bids, [('bids', 'bids_info')]),  
            (self.subjects_node,self.bids, [('subject', 'subj')]),     
            (self.nii_wrangler, self.data_sink, [("t1_uni", "nifti.@t1_uni")]), 
            (self.nii_wrangler, self.data_sink, [("t1_inv2", "nifti.@t1_inv2")]), 
            (self.nii_wrangler, self.data_sink, [("t1_q", "nifti.@t1_q")]), 
            (self.nii_wrangler, self.data_sink, [("rsfmri", "nifti.@rsfmri")]), 
            (self.nii_wrangler, self.data_sink, [("rs_ap", "nifti.@rs_ap")]),       
            (self.nii_wrangler, self.data_sink, [("rs_pa", "nifti.@rs_pa")]),    
            (self.nii_wrangler, self.data_sink, [("dwi", "nifti.@dwi")]), 
            (self.nii_wrangler, self.data_sink, [("flair", "nifti.@flair")]),
            (self.nii_wrangler, self.data_sink, [("dwi_ap", "nifti.@dwi_ap")]),  
            (self.nii_wrangler, self.data_sink, [("dwi_pa", "nifti.@dwi_pa")]), 
            (self.dicom_convert, self.data_sink, [("bvals", "nifti.@bval")]),
            (self.dicom_convert, self.data_sink, [("bvecs", "nifti.@bvecs")]),
            (self.dicom_convert, self.data_sink, [("bids", "nifti.@bids")]),    

            #structural workflow
            (self.nii_wrangler, self.structural_wf, [("t1_uni", "inputnode.uni")]),      
            (self.nii_wrangler, self.structural_wf, [("t1_inv2", "inputnode.inv2")]),     
            (self.nii_wrangler, self.structural_wf, [("t1_q", "inputnode.t1map")]),         
            (self.subjects_node, self.structural_wf, [("subject", "inputnode.subject")]),
            (self.structural_wf, self.data_sink_rs, [('outputnode.brain', 'structural.@brain')]),
            (self.structural_wf, self.data_sink_rs, [('outputnode.anat_head', 'structural.@anat_head')]),
            (self.structural_wf, self.data_sink_rs, [('outputnode.brainmask', 'structural.@brainmask')]),
            (self.structural_wf, self.data_sink_rs, [('outputnode.anat2std', 'structural.@anat2std')]),
            (self.structural_wf, self.data_sink_rs, [('outputnode.anat2std_transforms', 'structural.@anat2std_transforms')]),
            (self.structural_wf, self.data_sink_rs, [('outputnode.std2anat_transforms', 'structural.@std2anat_transforms')]),
            
            #diffusion workflow

            (self.structural_wf, self.dwi_wf, [("outputnode.subject_id", "inputnode.subject_id")]),
            (self.nii_wrangler, self.dwi_wf, [("dwi", "inputnode.dwi")]),
            (self.nii_wrangler, self.dwi_wf, [("dwi_ap", "inputnode.dwi_ap")]),
            (self.nii_wrangler, self.dwi_wf, [("dwi_pa", "inputnode.dwi_pa")]),
            (self.dicom_convert, self.dwi_wf, [("bvals", "inputnode.bvals")]),
            (self.dicom_convert, self.dwi_wf, [("bvecs", "inputnode.bvecs")]),            
            (self.dwi_wf, self.data_sink_dti, [('outputnode.dwi_denoised', 'diffusion.@dwi_denoised')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.dwi_unringed', 'diffusion.@dwi_unringed')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.topup_corr', 'diffusion.@topup_corr')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.topup_field', 'diffusion.@topup_field')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.topup_fieldcoef', 'diffusion.@topup_fieldcoef')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.rotated_bvecs', 'diffusion.@rotated_bvecs')]),
    	        (self.dwi_wf, self.data_sink_dti, [('outputnode.eddy_corr', 'diffusion.@eddy_corr')]),
	        (self.dwi_wf, self.data_sink_dti, [('outputnode.total_movement_rms', 'diffusion.@total_movement_rms')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.cnr_maps', 'diffusion.@cnr_maps')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.residuals', 'diffusion.@residuals')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.shell_params', 'diffusion.@shell_params')]),
	        (self.dwi_wf, self.data_sink_dti, [('outputnode.outlier_report', 'diffusion.@outlier_report')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.dti_fa', 'diffusion.@dti_fa')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.dti_md', 'diffusion.@dti_md')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.dti_l1', 'diffusion.@dti_l1')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.dti_l2', 'diffusion.@dti_l2')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.dti_l3', 'diffusion.@dti_l3')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.dti_v1', 'diffusion.@dti_v1')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.dti_v2', 'diffusion.@dti_v2')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.dti_v3', 'diffusion.@dti_v3')]),
            (self.dwi_wf, self.data_sink_dti, [('outputnode.fa2anat', 'diffusion.@fa2anat')]),
	        (self.dwi_wf, self.data_sink_dti, [('outputnode.fa2anat_dat', 'diffusion.@fa2anat_dat')]),
	        (self.dwi_wf, self.data_sink_dti, [('outputnode.fa2anat_mat', 'diffusion.@fa2anat_mat')]),
                        
#            #functional
            (self.structural_wf, self.resting, [("outputnode.subject_id", "inputnode.subject_id")]),
            (self.nii_wrangler, self.resting, [("rsfmri", "inputnode.func")]),    
            (self.nii_wrangler, self.resting, [("rs_ap", "inputnode.rs_ap")]), 
            (self.nii_wrangler, self.resting, [("rs_pa", "inputnode.rs_pa")]),
            (self.structural_wf, self.resting, [('outputnode.brain', 'inputnode.anat_brain')]),
            (self.structural_wf, self.resting, [('outputnode.anat_head', 'inputnode.anat_head')]),
            (self.structural_wf, self.resting, [('outputnode.brainmask', 'inputnode.anat_brain_mask')]),
            (self.nii_wrangler, self.resting, [("ep_rsfmri_echo_spacings", "inputnode.echo_space")]),
            (self.nii_wrangler, self.resting, [("ep_TR", "inputnode.TR")]),
          
            #sink
            (self.resting,self.data_sink_rs, [('outputnode.tsnr','resting.moco.@tsnr_file')]),
            (self.resting,self.data_sink_rs, [('outputnode.par','resting.moco.@realignment_parameters_file')]),
            (self.resting,self.data_sink_rs, [('outputnode.rms','resting.moco.@rms')]),
            (self.resting,self.data_sink_rs, [('outputnode.mean_epi','resting.moco.@mean_epi')]),
            (self.resting,self.data_sink_rs, [('outputnode.unwarped_mean_epi2fmap','resting.unwarp.@mean_epi_file_unwarped')]),
            (self.resting,self.data_sink_rs, [('outputnode.coregistered_epi2fmap','resting.unwarp.@mean_epi_file')]),
            (self.resting,self.data_sink_rs, [('outputnode.fmap','resting.unwarp.@fmap')]),
            (self.resting,self.data_sink_rs, [('outputnode.fmap_fullwarp','resting.unwarp.@fmap_fullwarp')]),
            (self.resting,self.data_sink_rs, [('outputnode.epi2anat_dat','resting.anat_coreg.@reg_file')]),
            (self.resting,self.data_sink_rs, [('outputnode.epi2anat','resting.anat_coreg.@epi2anat')]),
            (self.resting,self.data_sink_rs, [('outputnode.epi2anat_mat','resting.anat_coreg.@epi2anat_mat')]),
            (self.resting,self.data_sink_rs, [('outputnode.full_transform_ts','resting.transform_ts.@full_transform_ts')]),
            (self.resting,self.data_sink_rs, [('outputnode.full_transform_mean','resting.transform_ts.@full_transform_mean')]),
            (self.resting,self.data_sink_rs, [('outputnode.resamp_brain','resting.transform_ts.@resamp_brain')]),
            (self.resting,self.data_sink_rs, [('outputnode.detrended_epi','resting.transform_ts.@detrended_epi')]),
            #report
            (self.subjects_node, self.report, [("subject", "inputnode.subject")]),
            (self.resting,self.report, [('outputnode.tsnr','inputnode.tsnr_file')]),
            (self.resting,self.report, [('outputnode.dvars_file','inputnode.dvars_file')]),
            (self.resting,self.report, [('outputnode.par','inputnode.realignment_parameters_file')]),
            (self.resting,self.report, [('outputnode.unwarped_mean_epi2fmap','inputnode.mean_epi_file_unwarped')]),
            (self.resting,self.report, [('outputnode.coregistered_epi2fmap','inputnode.mean_epi_file')]),
            (self.resting,self.report, [('outputnode.epi2anat_dat','inputnode.reg_file')]),
            (self.nii_wrangler, self.report, [("dwi", "inputnode.dwi_file")]), 
            (self.nii_wrangler, self.report, [("flair", "inputnode.flair_file")]),
            (self.dicom_convert, self.report, [("bvals", "inputnode.bvals")]),
            (self.dicom_convert, self.report, [("bvecs", "inputnode.bvecs")]),
            (self.dwi_wf, self.report, [('outputnode.fa2anat_dat', 'inputnode.reg_file_dwi')]),
            (self.dwi_wf, self.report, [('outputnode.dti_fa', 'inputnode.FA_file')]),
            (self.structural_wf, self.report, [('outputnode.wmseg','inputnode.wm_file')]),
            (self.structural_wf, self.report, [('outputnode.brainmask','inputnode.brain_mask')]),
            (self.structural_wf, self.report, [('outputnode.anat_head','inputnode.T1')])
            
     
            ])

    """ self-inflating nodes """
    
    @property
    def subjects_node(self):
        if not getattr(self,"_subjects_node",None):
            self._subjects_node = pe.Node(
                    name="subs_node",
                    interface=util.IdentityInterface(
                            fields=["subject"]))
        return self._subjects_node
    @subjects_node.setter
    def subjects_node(self, val):
        self._subjects_node = val

    @property
    def dicom_grabber(self):
        if not getattr(self,"_dicom_grabber",None):
            self._dicom_grabber = pe.Node(
                    name = "dicom_source_1",
                    interface = nio.DataGrabber(
                            infields = ["subject"],
                            outfields = ["dicom"],))
            self._dicom_grabber.inputs.template = "subject"
            self._dicom_grabber.inputs.template_args = {"dicom": [["subject"]]}
            self._dicom_grabber.inputs.sort_filelist = True
        return self._dicom_grabber
    @dicom_grabber.setter
    def dicom_grabber(self, val):
        self._dicom_grabber = val

    @property
    def dicom_convert(self):
        if not getattr(self,"_dicom_convert",None):
            #self._dicom_convert = pe.Node(name="dicom_convert", interface=Dcm2nii())
            #self._dicom_convert = pe.Node(name="dicom_convert", interface=HCDcm2nii())
            self._dicom_convert = pe.Node(name="dicom_convert", interface=Dcm2niix())
            self._dicom_convert.inputs.out_filename="%p_s%s"
            #self._dicom_convert.inputs.convert_all_pars = True
            #self._dicom_convert.inputs.gzip_output = False
            #self._dicom_convert.inputs.reorient = False
            #self._dicom_convert.inputs.reorient_and_crop = False
            #self._dicom_convert.inputs.events_in_filename=True
            #self._dicom_convert.inputs.protocol_in_filename=True
            #self._dicom_convert.inputs.date_in_filename= False
        return self._dicom_convert
    @dicom_convert.setter
    def dicom_convert(self, val):
        self._dicom_convert = val

    @property
    def dicom_select(self):
        if not getattr(self,'_dicom_select',None):
            self._dicom_select = pe.Node(name="select_dicom", interface=util.Select(index = 0))
        return self._dicom_select
    @dicom_select.setter
    def dicom_select(self, val):
        self._dicom_select = val

    @property
    def dicom_info(self):
        if not getattr(self,'_dicom_info',None):
            self._dicom_info = pe.Node(name="dicom_info", interface=DicomInfo())
        return self._dicom_info
    @dicom_info.setter
    def dicom_info(self, val):
        self._dicom_info = val
        
    @property
    def bids(self):
        from bids_conversion import create_bids
        if not getattr(self,'_bids',None):
               self._bids = pe.Node(name="bids", interface=Function(
                           input_names=["dicom_info","bids_info","bids_output","subj","ses"],
                           output_names=["out"],
                           function=create_bids))
               self._bids.inputs.ses = 'bl'
        return self._bids
    @bids.setter
    def bids(self, val):
        self._bids = val

    @property
    def nii_wrangler(self):
        if not getattr(self,'_nii_wrangler',None):
            self._nii_wrangler = pe.Node(name="nii_wrangler", interface=NiiWrangler())
        return self._nii_wrangler
    @nii_wrangler.setter
    def nii_wrangler(self, val):
        self._nii_wrangler = val
        
    @property
    def structural_wf(self):
        from structural.structural import create_structural
        if not getattr(self,'_structural_wf',None):
            self._structural_wf = create_structural()
        return self._structural_wf
    @structural_wf.setter
    def structural_wf(self, val):
        self._structural_wf = val

    @property
    def resting(self):
        from functional.resting import create_resting
        if not getattr(self,'_resting',None):
            self._resting = create_resting()
        return self._resting
    @resting.setter
    def resting(self, val):
        self._resting = val
       
    @property
    def dwi_wf(self):
        from diffusion.diffusion import create_dti
        if not getattr(self,'_dwi_wf',None):
            self._dwi_wf = create_dti()
        return self._dwi_wf
    @dwi_wf.setter
    def dwi_wf(self, val):
        self._dwi_wf = val
   
    @property
    def report(self):
        from reports.generate_base_report import create_base_report
        if not getattr(self,'_report',None):
            self._report = create_base_report()
        return self._report
    @report.setter
    def report(self, val):
        self._report = val
        
    @property
    def data_sink(self):
        if not getattr(self,'_data_sink',None):
            self._data_sink = pe.Node(name="data_sink", interface=nio.DataSink())
        return self._data_sink
    @data_sink.setter
    def data_sink(self, val):
        self._data_sink = val

    @property
    def data_sink_rs(self):
        if not getattr(self,'_data_sink_rs',None):
            self._data_sink_rs = pe.Node(name="data_sink_rs", interface=nio.DataSink())
        return self._data_sink_rs
    @data_sink_rs.setter
    def data_sink_rs(self, val):
        self._data_sink_rs = val

    @property
    def data_sink_dti(self):
        if not getattr(self,'_data_sink_dti',None):
            self._data_sink_dti = pe.Node(name="data_sink_dti", interface=nio.DataSink())
        return self._data_sink_dti
    @data_sink_dti.setter
    def data_sink_dti(self, val):
        self._data_sink_dti = val
