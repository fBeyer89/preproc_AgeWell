from nipype.pipeline.engine import Workflow, Node
import nipype.interfaces.utility as util
from nipype.interfaces.mipav.developer import JistIntensityMp2rageMasking, JistBrainMp2rageSkullStripping, MedicAlgorithmSPECTRE2010

'''
Workflow to remove noisy background from MP2RAGE images 
AND SKULLSTRIP unsing cbstools
==============================
adapt import in run_structural.py to "structural_cbstools" to use this.

'''


def create_mp2rage_pipeline(name='mp2rage'):
    
    # workflow
    mp2rage = Workflow('mp2rage')
    
    # inputnode 
    inputnode=Node(util.IdentityInterface(fields=['inv2',
                                                  'uni',
                                                  't1map']),
               name='inputnode')
               
    # outputnode                                     
    outputnode=Node(util.IdentityInterface(fields=['uni_masked',
                                                   'background_mask',
                                                   'uni_stripped',
                                                   'skullstrip_mask',
                                                   
                                                   ]),
                name='outputnode')
    
    
    #get filenames from list
    def return_list_element(x):
        x_file=x[0]
        return x_file
    
    get_uni= Node(util.Function(input_names=["x"],
                              output_names=["x_file"],
                              function = return_list_element), name="get_uni")  
    get_t1= Node(util.Function(input_names=["x"],
                              output_names=["x_file"],
                              function = return_list_element), name="get_t1") 
    get_inv2= Node(util.Function(input_names=["x"],
                              output_names=["x_file"],
                              function = return_list_element), name="get_inv2") 
    # remove background noise
    background = Node(JistIntensityMp2rageMasking(outMasked=True,
                                            outMasked2=True,
                                            outSignal2=True), 
                      name='background')
    
    # skullstrip
#    strip = Node(MedicAlgorithmSPECTRE2010(outStripped=True,
#                                           outMask=True,
#                                           outOriginal=True,
#                                           inOutput='true',
#                                           inFind='true',
#                                           inMMC=4
#                                           ), 
#                 name='strip')
        
    strip = Node(JistBrainMp2rageSkullStripping(outBrain=True, outMasked2=True),name='strip')

    
    # connections
    mp2rage.connect([(inputnode, get_uni, [('uni','x')]),
                     (inputnode, get_t1, [('t1map','x')]),
                     (inputnode, get_inv2, [('inv2','x')]),
                     (get_inv2, background, [('x_file', 'inSecond')]),
                     (get_t1, background, [('x_file', 'inQuantitative')]),
                     (get_uni, background, [('x_file','inT1weighted')]),                     
                     (background, strip, [('outMasked2','inT1weighted')]),
                     (get_inv2, strip, [('x_file', 'inSecond')]),
                     (background, outputnode, [('outMasked2','uni_masked'),
                                               ('outSignal2','background_mask')]),
                     (strip, outputnode, [('outMasked2','uni_stripped'),
                                         ('outBrain', 'skullstrip_mask')
                                         
                                         ])
                     ])
    
    
    return mp2rage
