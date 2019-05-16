setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()
carros <- read.csv('carros.csv')

ggplot(carros, aes(wt, mpg)) + geom_point(color='red') + ggtitle("Millas por galon vs peso")  + theme(plot.title = element_text(hjust = 0.5))
