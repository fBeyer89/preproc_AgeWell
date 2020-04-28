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

#write.csv(aw[,c(2:7)], "/data/pt_02030/Analysis/Project_Hippocampus_MCI/example_data.csv")

##Some code examples
aw=read.csv("/data/pt_02030/Analysis/Project_Hippocampus_MCI/example_data.csv") #put here the name of the csv-file
head(aw)

aw$age

hist(aw$age)

mean(aw$age)

cor.test(aw$age, aw$memory)


###für lineare regression
source('/a/share/gr_agingandobesity/literature/methods/statistics/linear_models_course_rogermundry_2018/functions/diagnostic_fcns.r')
#/Ort/an/dem/das/Programm/liegt/diagnostic_fcns.r')
source('/Ort/an/dem/das/Programm/liegt/diagnostics_dfbeta_cooks.R')

#Berechne das Modell
res=lm(age~memory, data=aw)
summary(res)

#sieh dir die Residuen an
diagnostics.plot(res)

#guck, ob es influential cases (also outlier gibt)
round(cbind(coefficients(res), coefficients(res)+
              t(apply(X=dfbeta(res), MARGIN=2, FUN=range))), 3)
#diese Funktion berechnet die Regression immer wieder und
#lässt dabei jeweils einen anderen Probanden weg -Spalte 1 ist der Koeffizient, Spalten 2 und 3
#geben den kleinsten und größten Koeffizienten bei den verschiedenen Berechnungen an. Wenn diese sehr 
#stark abweichen, zB eine andere Richtung haben, spricht das für einen Outlier.


install.packages("car")
library(car)
#es könnte sein, dass gewisse Variablen kolinear sind (d.h. Alter und SMI)- Dies wird problematisch,
#ab einem VIF > 10. Dieser kann so berechnet werde
res=lm(hippocampus~memory+age, data=aw)
summary(res)
vif(res)
