#install.packages("psych")
#library(psych)

#This code is just to generate the table.
# aw=read.csv("/data/p_02030/participants_16.01.2020.txt", header=FALSE)
# colnames(aw)[1]="subj.ID"
#aw$ID=c(1:nrow(aw))
#aw$ID=as.factor(aw$ID)
# aw[aw$subj.ID=="34673.79","MRIcomment"]="no MRI was acquired"
# aw[aw$subj.ID=="34419.7a", "MSTcomment"]="no MST was acquired"
# 
# aw$age=rnorm(nrow(aw), mean = 65, sd = 10)
# aw$memory=rnorm(nrow(aw), mean = 10, sd = 3)
# aw$hippocampus=rnorm(nrow(aw), mean = 4000, sd = 200)

write.csv(aw[,c(2:7)], "/data/pt_02030/Analysis/Project_Hippocampus_MCI/example_data.csv")

##Some code examples
aw=read.csv("example_data.csv") #put here the name of the csv-file
head(aw)

aw$age

hist(aw$age)

mean(aw$age)

cor.test(aw$age, aw$memory)

res=lm(age~memory, data=aw)
summary(res)
