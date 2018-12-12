# -*- coding: utf-8 -*-
"""
Created on Tue Dec 11 16:44:54 2018

@author: fbeyer
"""

##
import math
import os
import time
import nibabel as nb
import numpy as np
import seaborn as sns
from misc import plot_vline
from matplotlib.figure import Figure
from pylab import cm
from matplotlib.gridspec import GridSpec
from matplotlib.backends.backend_pdf import FigureCanvasPdf as FigureCanvas
from matplotlib.pyplot import text,axis

def _calc_rows_columns(ratio, n_images):
    rows = 1
    for _ in range(100):
        columns = math.floor(ratio * rows)
        total = rows * columns
        if total > n_images:
            break

        columns = math.ceil(ratio * rows)
        total = rows * columns
        if total > n_images:
            break
        rows += 1
    return rows, columns

def plot_mosaic(nifti_file, image_type, overlay_mask = None,title=None, figsize=(11.7,8.3)):
    if isinstance(nifti_file,str):
        nii = nb.load(nifti_file)
        mean_data = nii.get_data()
    elif isinstance(nifti_file, unicode):
        nii = nb.load(nifti_file)
        mean_data = nii.get_data()
    else:
        mean_data = nifti_file
   
    print np.shape(mean_data)
    if image_type=='flair':
            n_images = mean_data.shape[2]
            step=8
            range_plot=np.arange(8,n_images-8,step)   
            row, col = _calc_rows_columns(figsize[0]/figsize[1], (n_images-16)/step)
            #z-direction in flair image is in y-dimension
    elif image_type=='t1':
        n_images=mean_data.shape[2]
        step=4
        range_plot=np.arange(0,n_images-56,step)
        row, col = _calc_rows_columns(figsize[0]/figsize[1], (n_images-56)/step)
        #z-direction is in z-dimension
    else:
        n_images=mean_data.shape[2]
        print n_images
        step=1
        row, col = _calc_rows_columns(figsize[0]/figsize[1], n_images/step)
        print row
        print col
        range_plot=np.arange(0,n_images,step)
  
    if overlay_mask:
        overlay_data = nb.load(overlay_mask).get_data()

    # create figures
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
            ax.imshow(np.fliplr(mean_data[100:480,100:480,image].T), vmin=np.percentile(mean_data[data_mask], 0.5), 
                      vmax=np.percentile(mean_data[data_mask],99.5), 
                      cmap=cm.Greys_r, interpolation='nearest', origin='lower')  # @UndefinedVariable
        elif image_type=="t1":
            ax.imshow(np.flipud(mean_data[:,:,image].T), vmin=np.percentile(mean_data[data_mask], 0.5), 
                      vmax=np.percentile(mean_data[data_mask],99.5), 
                      cmap=cm.Greys_r, interpolation='nearest', origin='lower')  # @UndefinedVariable
            if overlay_mask:
                cmap = cm.Reds  # @UndefinedVariable
                cmap._init() 
                alphas = np.linspace(0, 0.75, cmap.N+3)
                cmap._lut[:,-1] = alphas
                ax.imshow(np.flipud(overlay_data[:,:,image].T), vmin=0, vmax=1,
                          cmap=cmap, interpolation='nearest', origin='lower')  # @UndefinedVariable
        else: 
            ax.imshow(np.fliplr(mean_data[:,:,image].T), vmin=np.percentile(mean_data[data_mask], 0.5), 
                      vmax=np.percentile(mean_data[data_mask],99.5), 
                      cmap=cm.Greys_r, interpolation='nearest', origin='lower')  # @UndefinedVariable
            if overlay_mask:
                cmap = cm.Reds  # @UndefinedVariable
                cmap._init() 
                alphas = np.linspace(0, 0.75, cmap.N+3)
                cmap._lut[:,-1] = alphas
                ax.imshow(np.fliplr(overlay_data[:,:,image].T), vmin=0, vmax=1,
                          cmap=cmap, interpolation='nearest', origin='lower')  # @UndefinedVariable
            
        ax.axis('off')
        ind+=1
    fig.subplots_adjust(left = 0.05, right = 0.95, bottom = 0.05, top = 0.95, wspace=0.01, hspace=0.1)
    
    if not title:
        _, title = os.path.split(nifti_file)
        title += " (last modified: %s)"%time.ctime(os.path.getmtime(nifti_file))
    fig.suptitle(title, fontsize='14')
    
    return fig
    
    
plot_mosaic('/data/pt_02030/wd_preprocessing/hcp_prep_workflow/resting/transform_timeseries/_subject_33219.97/tmean/rest_mean2anat_lowres.nii.gz', 'test', overlay_mask = None,title=None, figsize=(11.7,8.3))