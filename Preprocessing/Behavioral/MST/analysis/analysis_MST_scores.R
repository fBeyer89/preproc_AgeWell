library(psych)
path="/data/pt_02030/Data/preprocessed/mst/"
file.names <- dir(path, pattern =".txt")
setwd(path)
res=setNames(data.frame(matrix(ncol = 13, nrow = length(file.names))),c("ID","N_lures_as_similar","N_lures_as_old","N_lures_as_new",
                                                                        "N_new_as_similar","N_new_as_new", "N_new_as_old",
                                                                        "N_old_as_old","N_old_as_new","N_old_as_similar",
                                                                        "N_misses_lures","N_misses_old","N_misses_new"))
for(i in 1:length(file.names)){
  print(file.names[i])
  
  x <- read.table(file.names[i],header=TRUE, nrows=192, fill=TRUE)
  
  N_lures_as_similar=length(x$Trial[x$Bed=="sim"&x$Wahl=="sim"])
  res[i,"N_lures_as_similar"]=N_lures_as_similar
  N_lures_as_old=length(x$Trial[x$Bed=="sim"&x$Wahl=="old"])
  res[i,"N_lures_as_old"]=N_lures_as_old
  N_lures_as_new=length(x$Trial[x$Bed=="sim"&x$Wahl=="new"])
  res[i,"N_lures_as_new"]=N_lures_as_new 
  
  N_new_as_similar=length(x$Trial[x$Bed=="new"&x$Wahl=="sim"])
  res[i,"N_new_as_similar"]=N_new_as_similar
  N_new_as_new=length(x$Trial[x$Bed=="new"&x$Wahl=="new"])
  res[i,"N_new_as_new"]=N_new_as_new
  N_new_as_old=length(x$Trial[x$Bed=="new"&x$Wahl=="old"])
  res[i,"N_new_as_old"]=N_new_as_old
  
  N_old_as_old=length(x$Trial[x$Bed=="old"&x$Wahl=="old"])
  res[i,"N_old_as_old"]=N_old_as_old
  N_old_as_new=length(x$Trial[x$Bed=="old"&x$Wahl=="new"])
  res[i,"N_old_as_new"]=N_old_as_new
  N_old_as_similar=length(x$Trial[x$Bed=="old"&x$Wahl=="sim"])
  res[i,"N_old_as_similar"]=N_old_as_similar
  
  ##MISSES
  N_misses_similar=length(x$Trial[x$Bed=="sim"&x$Wahl=="---"])
  res[i,"N_misses_lures"]=N_misses_similar
  N_misses_old=length(x$Trial[x$Bed=="old"&x$Wahl=="---"])
  res[i,"N_misses_old"]=N_misses_similar
  N_misses_new=length(x$Trial[x$Bed=="new"&x$Wahl=="---"])
  res[i,"N_misses_new"]=N_misses_new
  ID = substr(file.names[i], 1, 8)
  res[i,"ID"]=ID
  
  
}
res

##Detection of Errors:
#the maximal number of missed items is 
max(res$N_misses_lures)
#this means all items have been missed! 
#This is an acquisition error!

#This is the case for 9 participants. See "/data/pt_02030/Analysis/Preprocessing/Behavioral/MST/README.MD"
res[res$N_misses_lures==max(res$N_misses_lures),"ID"]


##DEFINITION OF OUTLIERS:
#1. exclude participants with less than 20 trials per condition (e.g. too many missings)
boxplot(res$N_misses_lures)
boxplot(res$N_misses_new)
boxplot(res$N_misses_old)

max(res$N_misses_lures)

max(res$N_misses_new)
res[res$N_misses_new==max(res$N_misses_new),"ID"]
max(res$N_misses_old)
res[res$N_misses_old==max(res$N_misses_old),"ID"]

res=res[res$N_misses_lures<44&res$N_misses_old<44&res$N_misses_new<44,]

#2. exclude participants with 0 responses in "old" or "new" or "lure" categorie
res$n_new=res$N_lures_as_new+res$N_new_as_new+res$N_old_as_new
res$n_old=res$N_lures_as_old+res$N_new_as_old+res$N_old_as_old
res$n_lure=res$N_lures_as_similar+res$N_new_as_similar+res$N_old_as_similar

hist(res$n_new)
hist(res$n_old)
hist(res$n_lure)

##indicates people who did not perform the test correctly/follow instructions.
length(res$ID[res$n_lure==0])
length(res$ID[res$n_new==0])
length(res$ID[res$n_old==0])

res=res[res$n_lure!=0&res$n_new!=0&res$n_old!=0,]


##QA check
#participants respond more often "SIMILAR" to "NEW" cues, than "SIMILAR" to "SIMILAR" cues 
#exclude those participants in sensitivity analysis
boxplot(res$N_new_as_similar)
ids=res$ID[res$N_new_as_new<res$N_new_as_similar]
length(ids)#1 individuals with weird behavior. check and exclude for sensitivity analysis.


###MAIN ANALYSIS:
##calculate based on STARK, 2015:
# Discrimination Index (LDI) was calculated as the difference between the rate of “Similar”
# responses given to the lure items minus “Similar” responses given to the foils. 
#(to correct for any bias in responding “similar” overall). Additionally adjusting for missed trials.

res$LDI=res$N_lures_as_similar/(64-res$N_misses_lures)-res$N_new_as_similar/(64-res$N_misses_new)

#Recognition (REC) for repeat items was calculated as the difference between the rate of “Old” responses
# given to repeat items minus “Old” responses given to foils. These scores correct for any
# response bias on a per-subject basis. Additionally adjusting for missed trials.
res$REC=res$N_old_as_old/(64-res$N_misses_old)-res$N_new_as_old/(64-res$N_misses_new)

#ANALYSIS of main outcome LDI
hist(res$LDI, xlab="Lure Discrimination Index", 
     main = "Histogram", cex.axis=1.1, cex.main=1.1, cex.lab=1.1)
boxplot(res$LDI, xlab="Lure Discrimination Index", 
        main = "Histogram", cex.axis=1.1, cex.main=1.1, cex.lab=1.1)

hist(res$REC, xlab="Recognition Score", 
     main = "Histogram", cex.axis=1.1, cex.main=1.1, cex.lab=1.1)
boxplot(res$REC, xlab="Recognition Score", 
        main = "Histogram", cex.axis=1.1, cex.main=1.1, cex.lab=1.1)

#tradeoff between old and similar:
plot(res$N_old_as_similar,res$N_old_as_old)

#this selection removes extreme outliers in LDI
hist(res[res$N_new_as_new>=res$N_new_as_similar,]$LDI, xlab="Lure Discrimination Index", 
     main = "Histogram", cex.axis=1.1, cex.main=1.1, cex.lab=1.1)
#this selection removes extreme outliers in REC
hist(res[res$N_new_as_new>=res$N_new_as_similar,]$REC, xlab="Recognition", 
     main = "Histogram", cex.axis=1.1, cex.main=1.1, cex.lab=1.1)

#save final dataset
write.csv(res,"/data/pt_02030/Data/preprocessed/mst/final_mst_results.csv")
