setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()
install.packages("ggplot2")
install.packages("e1071")
library(ggplot2)
library(e1071) 
apple <- read.csv("AppleStore.csv")

apple1 <- apple[apple$user_rating > 0.0, ] 

# Estadisticos
mean(apple1$user_rating)
var(apple1$user_rating)
sd(apple1$user_rating)
skewness(apple1$user_rating)
kurtosis(apple1$user_rating) 

# Count
ggplot(data=apple1, aes(apple1$user_rating)) +
  geom_density(
    aes(y=.5 * ..count..),
    fill="#558fed",
    color="red",
    bw=.25,
    alpha = 0.5) +
  labs(x="Rating", y="Count")
  xlim(c(1,5))
  
# Density
ggplot(data=apple1, aes(apple1$user_rating)) +
  geom_density(
    fill="red",
    color="blue",
    bw=.25,
    alpha = 0.5) +
  labs(x="Rating", y="Density")
  xlim(c(1,5))
  
  