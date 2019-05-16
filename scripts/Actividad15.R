setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

library(ggplot2)

infoAcad <- read.csv('InfoAcad_gg.csv')
infoAcad <- infoAcad[,c("PeriodoAcad", "Genero", "PromedioAcum")]

ggplot(data=infoAcad, 
       aes(fill=factor(infoAcad$Genero), 
           x=infoAcad$PeriodoAcad, 
           y=infoAcad$PromedioAcum)) + geom_bar(
             stat="identity", 
             position = "dodge") + xlab("PromedioAcum") + ylab("PeriodoAcad") +guides(fill=guide_legend(title="Genero")) + ggtitle("Promedio Acumulado por periodo")  + theme(plot.title = element_text(hjust = 0.5))
