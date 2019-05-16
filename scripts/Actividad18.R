setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

install.packages("ggplot2")
library(ggplot2)


infoAcad <- read.csv('InfoAcad_TS_2008.csv')

hombres <- infoAcad[infoAcad$Genero == "M",]
mujeres <- infoAcad[infoAcad$Genero == "F",]

ggplot(data=infoAcad, aes(x=infoAcad$PromedioAcum)) + 
  geom_histogram( fill="#93EC90", color="black") +
  facet_grid(rows = vars(infoAcad$Genero)) +
  labs(x = "PromedioAcum", y = "" ) +
  ggtitle("Distribucion de calificaciones") +
  theme(plot.title = element_text(hjust = 0.5))
  

