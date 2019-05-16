setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

ordenes <- read.csv("OrdenesVenta.csv")

ordenes_summary <- aggregate(x=ordenes$OrdarId, by = list(ordenes$Month, ordenes$Year), FUN = length)

names(ordenes_summary) <-c("Month", "Year", "Total")

ordenes_summary <- ordenes_summary[ordenes_summary$Year > 2010 & ordenes_summary$Year < 2015,]

ord2012 <- ordenes_summary[ordenes_summary$Year == "2011",]
plot(ord2012$Month,ord2012$Total,
     type="l",
     ylim = c(0,150),
     main = "Ventas por mes",
     xlab = "Month",
     ylab = "")

years <- levels(factor(ordenes_summary$Year))
nCols <- length(years)
colors <- rainbow(nCols)

i <- 1
for (year in years) {
  print(colors[i])
  line <- ordenes_summary[ordenes_summary$Year == year,]
  lines(line$Month, line$Total, col=colors[i])
  i <- i + 1
}

# Add a legend
legend( "bottomleft", 
       legend = years, 
       col = colors,
       pch = 15,
       bty = "o",
       pt.cex = 1.5 )
