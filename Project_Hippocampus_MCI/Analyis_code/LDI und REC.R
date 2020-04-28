library(ggplot2) #hier kannst du alle wichtigen Pakete einlesen

#Hier kannst du Daten einlesen:
R=readxl::read_xlsx("/data/pt_02030/Analysis/Project_Hippocampus_MCI/Analyis_code/ausgewählte Daten.xlsx")

#Hier kannst du die Modelle machen
res_MST<-lm(LDI~Alter+geschlecht, R)
plot(res_MST)

summary(res_MST)


R$Rec_log=log(R$REC)
res_MST<-lm(R$Rec_log~R$Alter+R$geschlecht)
diagnostics.plot(res_MST)

summary(res_MST)

#Und mit ggplot kannst du hübsche Plots erstellen:
ggplot(data=R[R$Alter!=0,], aes(x=Alter, y=LDI)) + 
  geom_point()
