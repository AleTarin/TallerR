install.packages("rpart")
install.packages("rpart.plot")

library(rpart)
library(rpart.plot)

setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

names(apple.original)

apple.original <- read.csv('AppleStore.csv')
datos <- as.data.frame(cbind(
  apple.original[,'price'],
  apple.original[,'size_bytes'],
  apple.original[,'user_rating'],
  apple.original[,'ver'],
  apple.original[,'lang.num']))
names(datos) <- c('price', 'size_bytes', 'user_rating','ver','lang.num')

newData <- rweibull(100000, shape = 7.741399, scale = 4.317312 )
?rweibull()

ind <- sample(2, nrow(datos),  replace = TRUE, prob = c(0.6, 0.4))
trainData <- datos[ind==1,]
testData <- datos[ind==2,]


ArbolRpart <- rpart(user_rating ~ ., data = trainData)

print(ArbolRpart)
rpart.plot(ArbolRpart)

printcp(ArbolRpart)
plotcp(ArbolRpart)

