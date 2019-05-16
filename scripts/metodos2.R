setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

apple.original <- read.csv('AppleStore.csv')

apple.filter <- as.data.frame(cbind(
  apple.original[,'price'],
  apple.original[,'user_rating']))
names(apple.filter) <- c('price', 'user_rating')
apple.scale <- as.data.frame(scale(apple.filter))

set.seed(10)




# Determinar cluster optimos
sumbt <- kmeans(apple.scale, centers = 1)$betweenss
for (i in 2:10) {
  sumbt[i]<-kmeans(apple.scale, centers = i)$betweenss
}
plot(1:10, sumbt, type="b", xlab = "numero de clusters", ylab = "suma de cuadrados inter grupos")



# Con los centros hacer el algoritmo 
cn <- 4
#apple.km <- kmeans(apple.filter, centers = cn)
apple.km <- kmeans(apple.scale, centers = cn)

apple.km$cluster # Asignación observaciones a clusters
apple.km$totss # inercia total
apple.km$betweenss # inercia inter grupos (mayor mejor)
apple.km$withinss # inercia intra grupos (menor mejor)
apple.km$tot.withinss #inercia intra grupos total (menor mejor)

apple.summary <- aggregate(apple.filter, by = list(apple.km$cluster), mean)
min(apple.filter$price)
plot(apple.filter$price, apple.filter$user_rating, main="Mapa de clusters (Zoom out)",col=apple.km$cluster, xlab = "Price", ylab = "User rating")
plot(apple.filter$price, apple.filter$user_rating, main="Mapa de clusters (Zoom)", xlim=c(0,50), col=apple.km$cluster, xlab = "Price", ylab = "User rating")


apple.filter <- data.frame(
  "user_rating" = rweibull(1000, shape = 7.741399, scale = 4.317312 ))
apple.scale <- as.data.frame(scale(newData))


sumbt <- kmeans(apple.scale, centers = 1)$betweenss
for (i in 2:10) {
  sumbt[i]<-kmeans(apple.scale, centers = i)$betweenss
}
plot(1:10, sumbt, type="b", xlab = "numero de clusters", ylab = "suma de cuadrados inter grupos")


# Con los centros hacer el algoritmo 
cn <- 4
#apple.km <- kmeans(apple.filter, centers = cn)
apple.km <- kmeans(apple.scale, centers = cn)

apple.km$cluster # Asignación observaciones a clusters
apple.km$totss # inercia total
apple.km$betweenss # inercia inter grupos (mayor mejor)
apple.km$withinss # inercia intra grupos (menor mejor)
apple.km$tot.withinss #inercia intra grupos total (menor mejor)

apple.summary <- aggregate(apple.filter, by = list(apple.km$cluster), mean)
min(apple.filter$price)
plot(apple.filter$price, apple.filter$user_rating, main="Mapa de clusters (Zoom out)",col=apple.km$cluster, xlab = "Price", ylab = "User rating")
plot(apple.filter$price, apple.filter$user_rating, main="Mapa de clusters (Zoom)", xlim=c(0,50), col=apple.km$cluster, xlab = "Price", ylab = "User rating")

