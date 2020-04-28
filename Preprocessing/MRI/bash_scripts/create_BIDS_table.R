#make table for BIDS

IDs=read.table("/data/pt_02030/Analysis/Preprocessing/MRI/bash_scripts/IDs.txt")
timepoints=read.table("/data/pt_02030/Analysis/Preprocessing/MRI/bash_scripts/time.txt")

data=data.frame(IDs,timepoints)
data$preprocessing=1
colnames(data)=c("ID","scan date")
data$ID=gsub("\\.","",data$ID)

write.table(data, "/data/p_02030/BIDS/participants.tsv", sep="\t", row.names = FALSE)
