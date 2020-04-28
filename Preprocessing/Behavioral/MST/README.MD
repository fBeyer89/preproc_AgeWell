# MST

## Description
These files are used to run and analyze the **Mnemonic similarity task** in the AgeWell.de-MRI Study. This task is publicly available and described under https://faculty.sites.uci.edu/starklab/mnemonic-similarity-task-mst/.

## Folder Stucture

* The test was implemented in Presentation software version 16.5. To run, the whole folder **presentation_script** needs to be copied to a Presentation PC in the lab tract (already installed in RZ1,2 and 4). There, when starting presentation run MST.exp and MST_1.sce. Also see 20180911_MST_SOP_fürAgeWell.docx and MST-testanweisung_agewell.pptx for more details on how to run and instruct the task. **Rando_Liste_MST.ods** is the randomization list so that participants would randomnly do one of the five subversions of the task. **images_for_instructions** were used to adapt the publicly available version of the test to our setup.

* Scripts to run the analysis are located in **MST analysis**. See README.MD in this folder.

## Preprocessing of MST task

### To do the analysis on the logfiles:

- run the script *run_ausw_1_neu.sh* to extract trial-by-trial the correct and given responses

   in the script you have to modify the path to where all the MST logfiles are located.

   This script wraps the command (perl  MST_ausw_1_neu.pl  Logfile (ohne Endung)) and writes results into .txt-files in the same location as the log-files.

### To calculate the MST-scores (recognition + pattern separation):
- use the R script: *analysis_MST_scores.R*.

### Errors we noticed:

9 subjects have wrong/missing logfiles.
It's unclear why and how this happened (as it seems to be across testers &
laboratories). It was discovered so late because it only occurred after July 2019.

### Final results table

LDI (lure discrimination index) and REC (recognition score) final results for 46 subjects are saved
