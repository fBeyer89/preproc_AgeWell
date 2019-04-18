library(psych)
path="/data/p_life_raw/documents/MST/logfiles/"
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
  ID = substr(file.names[i], 8, 15)
  res[i,"ID"]=ID

  
}
res

##DEFINITION OF OUTLIERS:
#1. exclude participants with less than 20 trials per condition (e.g. too many missings)
boxplot(res$N_misses_lures)
boxplot(res$N_misses_new)
boxplot(res$N_misses_old)

max(res$N_misses_lures)
res[res$N_misses_lures==max(res$N_misses_lures),"ID"]#H000EdPc: erst viele Missing, dann mutmaßlich Tastenverwechslung
max(res$N_misses_new)
res[res$N_misses_new==max(res$N_misses_new),"ID"]#J000Eqf0: Probleme beim Bedienen der Tastenbox
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
#"0000EuFx" "1000EpET" "c000F7mg" "H000Ez5s" "k000FGeG" "M000EwW4" "R000F4nn" "Z000EY47" "Z000F5Yn"
length(res$ID[res$n_new==0])
#"e000FFDx" "S000Eceq"
length(res$ID[res$n_old==0])
#"c000F7mg" "k000FGeG" "S000Eceq"

res=res[res$n_lure!=0&res$n_new!=0&res$n_old!=0,]

#+ exclusion based on CRF
res$excl[res$ID=="H000EdPc"]=1#<Einstieg ins Experiment fiel schwer - viele missings; Danach wudre unverhältnismäßig oft die Taste "ähnlich" gedrückt - daher nochmaliger Hinweis, dass die Taste "neu" mit dem Ringfinger zu bedienen ist. 
res$excl[res$ID=="2000EbUn"]=1#2000EbUn: falsche Bedienung, im ersten Drittel drinnen/draußen Entscheidung
res$excl[res$ID=="L000F61z"]=1#<L000F61z : nur Tasten alt und ähnlich gedrückt wegen Verwechslung -> Ausschluss.
res$excl[res$ID=="u000FEks"]=1#<u000FEks : verminderte Konzentration, Instruktionsverständnis fraglich
res$excl[res$ID=="J000Eqf0"]=1#<Probleme mit dem Bedienen der Tastenbox im 2. DG; zuerst mit drei Fingern versucht - viele missings; dann nur mehr mit dem Zeigefinger gedrückt; VP gibt an Linkshänder zu sein. 
res$excl[res$ID=="j000EuC6"]=1#2. DG - hat zu Beginn die Tasten neu und ähnlich verwechselt

res=res[res$ID!="H000EdPc"&res$ID!="2000EbUn"&res$ID!="L000F61z"&
        res$ID!="u000FEks"&res$ID!="J000Eqf0"&res$ID!="j000EuC6",]

##QA check
#participants respond more often "SIMILAR" to "NEW" cues, than "SIMILAR" to "SIMILAR" cues 
#exclude those participants in sensitivity analysis
boxplot(res$N_new_as_similar)
ids=res$ID[res$N_new_as_new<res$N_new_as_similar]
length(ids)#17 individuals with weird behavior. check and exclude for sensitivity analysis.

res$excl=0
res[res$ID==ids[1],]#>0000ECE0: hat angeblich Instruktion verstanden, aber nur einmal Taste neu verwendet -> biased
res[res$ID==ids[2],]#>2000EjhJ: nur einmal Taste neu verwendet -> N_new_as_similar biased
res[res$ID==ids[3],]#<8000Etxp: nur einmal Taste neu verwendet -> N_new_as_similar biased
res[res$ID==ids[4],]#<a000EkwD: taucht nicht in Ullis Liste auf-> N_new_as_similar biased
res[res$ID==ids[5],]#<H000ElbD : selten Taste neu verwendet -> N_new_as_similar biased
res[res$ID==ids[6],]#<j000Et2U : nur einmal Taste neu verwendet -> N_new_as_similar biased
res[res$ID==ids[7],]#<J000EW3p : ok
res[res$ID==ids[8],]#<k000Egwl : ok
res[res$ID==ids[9],]#<k000EMGL : ok,aber eventuell neu und ähnlich verwechselt?
res[res$ID==ids[10],]#<K000EsRM : ok,aber eventuell neu und ähnlich verwechselt?
res[res$ID==ids[11],]#<L000Ejfn : nur einmal Taste neu verwendet -> N_new_as_similar biased
res[res$ID==ids[12],]#<l000FGhx : ok
res[res$ID==ids[13],]#<M000Etfa : did not recognize new objects, but LDI should be fine
res[res$ID==ids[14],]#<Q000F0bh : ok
res[res$ID==ids[15],]#<t000EZMM : ok
res[res$ID==ids[16],]#<Y000Eeez : ok
res[res$ID==ids[17],]#<Z000E9LR : selten Taste neu verwendet -> N_new_as_similar biased

##second quality check -> yields no additional suspicious cases
ids2=res$ID[res$N_old_as_new>res$N_new_as_new]
res[res$ID==ids2[1],]#>a000EkwD: siehe oben
res[res$ID==ids2[2],]#>H000ElbD: siehe oben
res[res$ID==ids2[3],]#<M000Etfa: siehe oben
res[res$ID==ids2[4],]#<<Q000F0bh: siehe oben
res[res$ID==ids2[5],]#<Z000E9LR : siehe oben

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


##SENSITIVITY ANALYSIS:
length(res[res$N_new_as_new>=res$N_new_as_similar,]$ID)

#this selection removes extreme outliers in LDI
hist(res[res$N_new_as_new>=res$N_new_as_similar,]$LDI, xlab="Lure Discrimination Index", 
     main = "Histogram", cex.axis=1.1, cex.main=1.1, cex.lab=1.1)
#this selection removes extreme outliers in REC
hist(res[res$N_new_as_new>=res$N_new_as_similar,]$REC, xlab="Recognition", 
     main = "Histogram", cex.axis=1.1, cex.main=1.1, cex.lab=1.1)
