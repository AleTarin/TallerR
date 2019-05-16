setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

infoAcad <- read.csv("infoAcad_sub.csv")



AlumPeriodo <- table(infoAcad$PrepaPrivada, infoAcad$PeriodoAcad)
barplot(AlumPeriodo,col = c('darkseagreen2','lightgoldenrod'), legend=c('Publica','Privada'), beside = TRUE)

