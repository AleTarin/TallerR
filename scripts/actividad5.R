### Actividad 5 ###
#Script 1
#Set directory to datasets
setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')

#Save datasets into dataframes
AIR <- read.csv('airquality.csv')

#Script 2
Num <- length(colnames(AIR)) * length(rownames(AIR))

#Script 3
COLUMNAS <- colnames(AIR)

#Script 4
CLASECOLUMNAS <- sapply(AIR[0,],class)

#Script 5
ColName <- c(2,3,1)
AIRSUB <- AIR[ColName]

#Script 6
AIRQUERY <- AIR[AIR$Temp >= 8 & AIR$Month == 6,]

