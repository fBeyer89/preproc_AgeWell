#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu May 16 15:48:40 2019

@author: fbeyer
"""
import matplotlib.pyplot as plt
###extract the signal from all voxels and plot..
def plot_graymask(func_file,mask_file_wm, mask_file_gm,figsize=(11.7,8.3)):
    import nibabel as nb
    import numpy as np
    from matplotlib.figure import Figure
    from pylab import cm
    from nilearn.masking import apply_mask
    from matplotlib.gridspec import GridSpec
    from matplotlib.backends.backend_pdf import FigureCanvasPdf as FigureCanvas
    from matplotlib.pyplot import text,axis
   
    print "starting plotting"
    fig = Figure(figsize=figsize)
    FigureCanvas(fig)
    
    #fig.subplots_adjust(top=0.85)
    
    
    func = nb.load(func_file)
    mask_wm=nb.load(mask_file_wm)
    mask_gm=nb.load(mask_file_gm) 
    
    plot_data_wm=apply_mask(func,mask_wm)
    plot_data_gm=apply_mask(func,mask_gm)
    print np.shape(plot_data_wm)
    print np.shape(plot_data_gm)
    
    fig = Figure() #figsize=figsize
    plt.imshow(np.hstack((plot_data_gm,plot_data_wm)), vmin=np.percentile(plot_data_wm, 0.5), 
                      vmax=np.percentile(plot_data_wm,99.5), 
                      cmap=cm.Greys_r, interpolation='nearest', origin='lower') # @UndefinedVariable
#    for ind in range(2):
#        ax = fig.add_subplot(2, 1, ind+1)
#        ax.imshow(np.hstack((plot_data_gm,plot_data_wm)), vmin=np.percentile(plot_data_wm, 0.5), 
#                      vmax=np.percentile(plot_data_wm,99.5), 
#                      cmap=cm.Greys_r, interpolation='nearest', origin='lower') # @UndefinedVariable
#    #return fig
    plt.show()
    
    
#fig=plot_graymask("/data/pt_02030/wd_preprocessing/hcp_prep_workflow/resting/_subject_33307.92/detrend/rest2anat_detrend.nii",
#              "/data/pt_02030/wd_preprocessing/power_plot/_subject_33307.92/resample_wm/aparc+aseg_out_calc_resample.nii.gz",
#              "/data/pt_02030/wd_preprocessing/power_plot/_subject_33307.92/resample_agm/aparc+aseg_out_calc_resample.nii.gz"
#              )    



import nibabel as nb
import numpy as np
from matplotlib.figure import Figure
from pylab import cm
from nilearn.masking import apply_mask
from matplotlib.gridspec import GridSpec
from matplotlib.backends.backend_pdf import FigureCanvasPdf as FigureCanvas
from matplotlib.pyplot import text,axis
import scipy.io as sio
from compute_fd import compute_fd

   
print "starting plotting"
fig = Figure()
FigureCanvas(fig)

#fig.subplots_adjust(top=0.85)


func = nb.load("/data/pt_02030/wd_preprocessing/hcp_prep_workflow/resting/_subject_33307.92/detrend/rest2anat_detrend.nii")
mask_wm=nb.load("/data/pt_02030/wd_preprocessing/power_plot/_subject_33307.92/resample_wm/aparc+aseg_out_calc_resample.nii.gz")
mask_gm=nb.load("/data/pt_02030/wd_preprocessing/power_plot/_subject_33307.92/resample_agm/aparc+aseg_out_calc_resample.nii.gz") 

plot_data_wm=apply_mask(func,mask_wm)
plot_data_gm=apply_mask(func,mask_gm)
print np.shape(plot_data_wm)
#print np.shape(plot_data_gm)

#np.hstack((plot_data_gm.T,plot_data_wm.T))
#fig, ax = plt.subplots()
#ax.imshow(plot_data_wm.T, interpolation='nearest',aspect='auto')
#plt.tight_layout()
#plt.show()

motpar_file="/data/pt_02030/preprocessed/resting/resting/moco/33219.97/rest_realigned.nii.gz.par"
FD=compute_fd(motpar_file)

fig = Figure() #figsize=figsize
ax = fig.add_subplot(3,1,1)
plt.imshow(plot_data_wm.T, vmin=np.percentile(np.hstack((plot_data_gm,plot_data_wm)).T, 0.5), 
                  vmax=np.percentile(plot_data_wm,99.5), 
                  cmap=cm.Greys_r, interpolation='nearest',aspect='auto')
plt.tight_layout() # @UndefinedVariable

ax2 = fig.add_subplot(3,1,2)
plt.plot(FD)
fig.subplots_adjust(left = 0.05, right = 0.95, bottom = 0.05, top = 0.95, wspace=0.01, hspace=0.1)
plt.show()

#fig2=Figure()
#plt.plot(FD)
#plt.tight_layout()
#plt.show()