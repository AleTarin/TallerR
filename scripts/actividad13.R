setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

InfoAcad <- read.csv("InfoAcad_TS_2008.csv")

hombres <- InfoAcad[InfoAcad$Genero == "M",]
mujeres <- InfoAcad[InfoAcad$Genero == "F",]

par(mfrow=c(1,1))
boxplot(hombres$PromedioAcum, mujeres$PromedioAcum, col = c("blue", "pink"), names = c("M", "F" ), main = "Distribucion de calificaciones", ylim = c(0,100))