# -*- coding: utf-8 -*-
"""
Created on Mon Feb  9 12:34:01 2015

@author: fbeyer
"""

from nipype.pipeline.engine import Node, Workflow, MapNode
import nipype.interfaces.fsl as fsl
import nipype.interfaces.freesurfer as fs
import nipype.interfaces.utility as util
import nipype.algorithms.rapidart as ra
import nipype.interfaces.afni as afni
import nipype.interfaces.io as nio
import scipy.io as sio
'''
Workflow for creating J.Powers plot for quality assurance
'''

##
def select_aparc(aparcs):
    return aparcs[2] 

# main workflow


fsdir="/data/pt_02030/preprocessed/freesurfer"
working_dir="/data/pt_02030/wd_preprocessing"
data_dir="/data/pt_02030/wd_preprocessing/hcp_prep_workflow/resting/"
fsl.FSLCommand.set_default_output_type('NIFTI_GZ')

power_plot = Workflow(name='power_plot')
power_plot.base_dir = working_dir
power_plot.config['execution']['crashdump_dir'] = power_plot.base_dir + "/crash_files"



subject_list=['33307.92'] #, '33434.7f', '33503.0e', '33486.7e','33698.f1','33555.22','33724.98','33593.15','33219.97','33808.e4','33809.60']
subj_node=Node(name="subj_node", interface=util.IdentityInterface(fields=["subject"]))
subj_node.iterables = ('subject', subject_list)

# select files
templates = {'func': '_subject_{subject}/detrend/rest2anat_detrend.nii',
             'physiomat': '

selectfiles = Node(nio.SelectFiles(templates,
                                   base_directory=data_dir),
                   name="selectfiles")


fs_import = Node(interface=nio.FreeSurferSource(),
                 name = 'fs_import')
fs_import.inputs.subjects_dir=fsdir

select_aparc=Node(util.Function(input_names=["aparcs"],
                              output_names=["aparc_file"],
                              function = select_aparc), name="select_aparc")  

##bring to NIFTI format
mc = Node(fs.MRIConvert(out_type = 'niigz'), name="mc")

###white matter mask
extract_wm= Node(afni.Calc(outputtype="NIFTI_GZ"), name="extract_wm")
extract_wm.inputs.expr='equals(a,2)+equals(a,7)+equals(a,41)+equals(a,46)+equals(a,251)+equals(a,252)+equals(a,253)+equals(a,254)+equals(a,255)'
 
erode_wm1 = Node(afni.Calc(outputtype="NIFTI_GZ"), name="erode_wm1")
erode_wm1.inputs.args='-b a+i -c a-i -d a+j -e a-j -f a+k -g a-k'
erode_wm1.inputs.expr='a*(1-amongst(0,b,c,d,e,f,g))'
 
erode_wm2 = Node(afni.Calc(outputtype="NIFTI_GZ"), name="erode_wm2")
erode_wm2.inputs.args='-b a+i -c a-i -d a+j -e a-j -f a+k -g a-k'
erode_wm2.inputs.expr='a*(1-amongst(0,b,c,d,e,f,g))'

erode_wm3 = Node(afni.Calc(outputtype="NIFTI_GZ"), name="erode_wm3")
erode_wm3.inputs.args='-b a+i -c a-i -d a+j -e a-j -f a+k -g a-k'
erode_wm3.inputs.expr='a*(1-amongst(0,b,c,d,e,f,g))'

erode_wm4 = Node(afni.Calc(outputtype="NIFTI_GZ"), name="erode_wm4")
erode_wm4.inputs.args='-b a+i -c a-i -d a+j -e a-j -f a+k -g a-k'
erode_wm4.inputs.expr='a*(1-amongst(0,b,c,d,e,f,g))'
#
####CSF mask
extract_csf= Node(afni.Calc(outputtype="NIFTI_GZ"), name="extract_csf")
extract_csf.inputs.expr='equals(a,4)+equals(a,43)+equals(a,14)'
 
erode_csf1 = Node(afni.Calc(outputtype="NIFTI_GZ"), name="erode_csf1")
erode_csf1.inputs.args='-b a+i -c a-i -d a+j -e a-j -f a+k -g a-k'
erode_csf1.inputs.expr='a*(1-amongst(0,b,c,d,e,f,g))'
 
erode_csf2 = Node(afni.Calc(outputtype="NIFTI_GZ"), name="erode_csf2")
erode_csf2.inputs.args='-b a+i -c a-i -d a+j -e a-j -f a+k -g a-k'
erode_csf2.inputs.expr='a*(1-amongst(0,b,c,d,e,f,g))'

erode_csf3 = Node(afni.Calc(outputtype="NIFTI_GZ"), name="erode_csf3")
erode_csf3.inputs.args='-b a+i -c a-i -d a+j -e a-j -f a+k -g a-k'
erode_csf3.inputs.expr='a*(1-amongst(0,b,c,d,e,f,g))'

erode_csf4 = Node(afni.Calc(outputtype="NIFTI_GZ"), name="erode_csf4")
erode_csf4.inputs.args='-b a+i -c a-i -d a+j -e a-j -f a+k -g a-k'
erode_csf4.inputs.expr='a*(1-amongst(0,b,c,d,e,f,g))'

####cortical ribbon mask
extract_ct= Node(afni.Calc(outputtype="NIFTI_GZ"), name="extract_ct")
extract_ct.inputs.expr='within(a,1000,3000)+equals(a,17)+equals(a,18)+equals(a,53)+equals(a,54)'

###cerebellum
extract_cereb= Node(afni.Calc(outputtype="NIFTI_GZ"), name="extract_cereb")
extract_cereb.inputs.expr='equals(a,47)+equals(a,8)'

erode_cereb1 = Node(afni.Calc(outputtype="NIFTI_GZ"), name="erode_cereb1")
erode_cereb1.inputs.args='-b a+i -c a-i -d a+j -e a-j -f a+k -g a-k'
erode_cereb1.inputs.expr='a*(1-amongst(0,b,c,d,e,f,g))'
 
erode_cereb2 = Node(afni.Calc(outputtype="NIFTI_GZ"), name="erode_cereb2")
erode_cereb2.inputs.args='-b a+i -c a-i -d a+j -e a-j -f a+k -g a-k'
erode_cereb2.inputs.expr='a*(1-amongst(0,b,c,d,e,f,g))'
#
## the subcortical nuclei
extract_subcort= Node(afni.Calc(outputtype="NIFTI_GZ"), name="extract_subcort")
extract_subcort.inputs.expr='equals(a,11)+equals(a,12)+equals(a,10)+equals(a,49)+equals(a,50)+equals(a,51)'
erode_subcort1 = Node(afni.Calc(outputtype="NIFTI_GZ"), name="erode_subcort1")
erode_subcort1.inputs.args='-b a+i -c a-i -d a+j -e a-j -f a+k -g a-k'
erode_subcort1.inputs.expr='a*(1-amongst(0,b,c,d,e,f,g))'
 
erode_subcort2 = Node(afni.Calc(outputtype="NIFTI_GZ"), name="erode_subcort2")
erode_subcort2.inputs.args='-b a+i -c a-i -d a+j -e a-j -f a+k -g a-k'
erode_subcort2.inputs.expr='a*(1-amongst(0,b,c,d,e,f,g))'

# all gray matter
extract_agm= Node(afni.Calc(outputtype="NIFTI_GZ"), name='extract_agm')
extract_agm.inputs.expr='within(a,1000,3000)+equals(a,17)+equals(a,18)+equals(a,53)+equals(a,54)+equals(a,47)+equals(a,8)+equals(a,11)+equals(a,12)+equals(a,10)+equals(a,49)+equals(a,50)+equals(a,51)'

##resample masks into functional space.
resample_wm = Node(afni.Resample(resample_mode='NN',
outputtype='NIFTI_GZ'), name = 'resample_wm')
resample_wm2 = Node(afni.Resample(resample_mode='NN',
outputtype='NIFTI_GZ'), name = 'resample_wm2')
resample_wm4 = Node(afni.Resample(resample_mode='NN',
outputtype='NIFTI_GZ'), name = 'resample_wm4')
resample_csf = Node(afni.Resample(resample_mode='NN',
outputtype='NIFTI_GZ'), name = 'resample_csf')
resample_csf2 = Node(afni.Resample(resample_mode='NN',
outputtype='NIFTI_GZ'), name = 'resample_csf2')
resample_gmr= Node(afni.Resample(resample_mode='NN',
outputtype='NIFTI_GZ'), name = 'resample_gmr')
resample_cereb= Node(afni.Resample(resample_mode='NN',
outputtype='NIFTI_GZ'), name = 'resample_cereb')
resample_subcort= Node(afni.Resample(resample_mode='NN',
outputtype='NIFTI_GZ'), name = 'resample_subcort')

##difference maps
csf_diff= Node(afni.Calc(outputtype="NIFTI_GZ"), name="csf_diff")
csf_diff.inputs.expr='b-a'

wm_diff20= Node(afni.Calc(outputtype="NIFTI_GZ"), name="wm_diff20")
wm_diff20.inputs.expr='b-a'

wm_diff42= Node(afni.Calc(outputtype="NIFTI_GZ"), name="wm_diff42")
wm_diff42.inputs.expr='b-a'
#resample_agm= Node(afni.Resample(resample_mode='NN',
#outputtype='NIFTI_GZ'), name = 'resample_agm')


##load respiration file if available
mat_contents = sio.loadmat(physiomat)


###extract the signal from all voxels and plot..
def plot_graymask(func,mask,figsize=(11.7,8.3)):
    from matplotlib.figure import Figure
    from pylab import cm
    from matplotlib.gridspec import GridSpec
    from matplotlib.backends.backend_pdf import FigureCanvasPdf as FigureCanvas
    from matplotlib.pyplot import text,axis

    fig = Figure(figsize=figsize)
    FigureCanvas(fig)
    
    fig.subplots_adjust(top=0.85)
    
    ind=0
    for image in range_plot:
        ax = fig.add_subplot(row, col, ind+1)
        data_mask = np.logical_not(np.isnan(mean_data))
        if overlay_mask:
            ax.set_rasterized(True)
        if image_type=="flair":
            #old version of DCM conversion with dcm2nii
#            ax.imshow(np.flipud(mean_data[50:256,80:256,image].T), vmin=np.percentile(mean_data[data_mask], 0.5), 
#                      vmax=np.percentile(mean_data[data_mask],99.5), 
#                      cmap=cm.Greys_r, interpolation='nearest', origin='lower') 
            #for new version of DCM conversion with dcm2niix
            ax.imshow(mean_data[1:216,1:220,image].T, vmin=np.percentile(mean_data[data_mask], 0.5), 
                  vmax=np.percentile(mean_data[data_mask],99.5), 
                  cmap=cm.Greys_r, interpolation='nearest', origin='lower') # @UndefinedVariable


power_plot.connect([(subj_node, fs_import, [('subject', 'subject_id')]),
                    (subj_node, selectfiles, [('subject', 'subject')]),
                    (fs_import, select_aparc, [("aparc_aseg", "aparcs")]),
                    (select_aparc, mc, [('aparc_file', 'in_file')]),
                    (mc, extract_wm, [('out_file', 'in_file_a')]), 
                    (extract_wm, erode_wm1, [('out_file', 'in_file_a')]),
                    (erode_wm1, erode_wm2, [('out_file', 'in_file_a')]),
                    (erode_wm2, erode_wm3, [('out_file', 'in_file_a')]),
                    (erode_wm3, erode_wm4, [('out_file', 'in_file_a')]),
                    (mc, extract_csf, [('out_file', 'in_file_a')]), 
                    (extract_csf, erode_csf1, [('out_file', 'in_file_a')]),
                    (erode_csf1, erode_csf2, [('out_file', 'in_file_a')]),
                    (erode_csf2, erode_csf3, [('out_file', 'in_file_a')]),
                    (erode_csf3, erode_csf4, [('out_file', 'in_file_a')]),
                    (mc, extract_ct, [('out_file', 'in_file_a')]), 
                    (mc, extract_cereb, [('out_file', 'in_file_a')]), 
                    (extract_cereb, erode_cereb1, [('out_file', 'in_file_a')]),
                    (erode_cereb1, erode_cereb2, [('out_file', 'in_file_a')]),
                    (mc, extract_subcort, [('out_file', 'in_file_a')]), 
                    (extract_subcort, erode_subcort1, [('out_file', 'in_file_a')]),
                    (erode_subcort1, erode_subcort2, [('out_file', 'in_file_a')]),
                    (mc, extract_agm, [('out_file', 'in_file_a')]),
                    (extract_wm, resample_wm, [('out_file', 'in_file')]),
                    (selectfiles, resample_wm, [('func', 'master')]),
                    (erode_wm2, resample_wm2, [('out_file', 'in_file')]),
                    (selectfiles, resample_wm2, [('func', 'master')]),
                    (erode_wm4, resample_wm4, [('out_file', 'in_file')]),
                    (selectfiles, resample_wm4, [('func', 'master')]),
                    (extract_ct, resample_gmr, [('out_file', 'in_file')]),
                    (selectfiles, resample_gmr, [('func', 'master')]),
                    (extract_cereb, resample_cereb, [('out_file', 'in_file')]),
                    (selectfiles, resample_cereb, [('func', 'master')]),
                    (extract_subcort, resample_subcort, [('out_file', 'in_file')]),
                    (selectfiles, resample_subcort, [('func', 'master')]),
                    (extract_csf, resample_csf, [('out_file', 'in_file')]),
                    (selectfiles, resample_csf, [('func', 'master')]),
                    (erode_csf2, resample_csf2, [('out_file', 'in_file')]),
                    (selectfiles, resample_csf2, [('func', 'master')]),
                    (resample_csf2, csf_diff, [('out_file', 'in_file_a')]),
                    (resample_csf, csf_diff, [('out_file', 'in_file_b')]),
                    (resample_wm4, wm_diff42, [('out_file', 'in_file_a')]),
                    (resample_wm2, wm_diff42, [('out_file', 'in_file_b')]),
                    (resample_wm2, wm_diff20, [('out_file', 'in_file_a')]),
                    (resample_wm, wm_diff20, [('out_file', 'in_file_b')])

                    ])
 
power_plot.run()

