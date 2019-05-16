setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

carros <- read.csv("carros.csv")
carros <- carros[,c("wt", "mpg")]

plot(carros, pch =19, col="green", col.lab="blue", col.axis="red", xlab="Peso en toneladas", ylab="Millas por galon")