import math

import time
from misc import plot_vline
from matplotlib.figure import Figure
from pylab import cm
from matplotlib.gridspec import GridSpec
from matplotlib.backends.backend_pdf import FigureCanvasPdf as FigureCanvas
import pylab as plt


    
def calculate_mean_bo_b_images(dwi_file, bval_file=False, bvec_file=False):    
    from dipy.io import read_bvals_bvecs
    from nipype.utils.filemanip import split_filename
    import nibabel as nb
    import numpy as np
    import os
    import re

    #for the case that there is one DWI file identified by the nifti wrangler
    if (len(dwi_file)==1 and os.path.isfile(dwi_file[0])):
        
        #if there is more than one element for the bval/bvecs
        if type(bval_file)==list:
                
            series_num_dwi=re.compile(".*cmrr_mbep2d_DTI_32Ch_s(.*).nii.gz*").match(dwi_file[0]).groups()
            
            for i in np.arange(0,len(bval_file)):
                series_num_bval=re.compile(".*cmrr_mbep2d_DTI_32Ch_s(.*).bval*").match(bval_file[i]).groups()
                
                if (series_num_dwi==series_num_bval):
                    index=i
                    
            bvals,bvecs = read_bvals_bvecs(bval_file[index],bvec_file[index])
        else:
            bvals,bvecs = read_bvals_bvecs(bval_file, bvec_file)        
               
        dwi = nb.load(dwi_file[0])
        dwi_data = dwi.get_data()
        
        #create average bo image
        bo_id=bvals<=5
        print np.shape(dwi_data[:,:,:,bo_id])
        if np.shape(dwi_data[:,:,:,bo_id])[3] != 7:
            print "why there are not 7 B0s"
        mean_bo=np.mean(dwi_data[:,:,:,bo_id],3)    
        b_id=bvals>5
        b_images=dwi_data[:,:,:,b_id]
        print np.shape(b_images)
        if np.shape(b_images)[3]!=60:
           print "why there are not 60 directions?"
        
        mean_bo_nii = nb.Nifti1Image(mean_bo, dwi.get_affine(), dwi.get_header())
        mean_bo_nii.set_data_dtype(np.float32)
        _, base, _ = split_filename(dwi_file[0])
        nb.save(mean_bo_nii, base + "_mean_bo.nii.gz")
        
        b_images_nii = nb.Nifti1Image(b_images, dwi.get_affine(), dwi.get_header())
        b_images_nii.set_data_dtype(np.float32)
        _, base, _ = split_filename(dwi_file[0])
        print base
        nb.save(b_images_nii, base + "_b_images.nii.gz")
        print os.path.abspath(base + "_mean_bo.nii.gz")
        return True, str(os.path.abspath(base + "_mean_bo.nii.gz")), str(os.path.abspath(base + "_b_images.nii.gz"))
    
#if there is no or more than 1 dti acquired, we have to manually check what happened.
    else:
        print "no dti or more than 1 dti acquired"
        return False, str('not acquired'), str('not acquired')

   
