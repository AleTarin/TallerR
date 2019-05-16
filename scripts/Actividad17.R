setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

install.packages("ggplot2")
library(ggplot2)


ordenes <- read.csv('OrdenesVenta.csv')

ordenes_summary <- aggregate(x=ordenes$OrdarId, by = list(ordenes$Month, ordenes$Year), FUN = length)

names(ordenes_summary) <-c("Month", "Year", "Total")

ordenes_summary <- ordenes_summary[ordenes_summary$Year > 2010 & ordenes_summary$Year < 2015,]


ggplot(data = ordenes_summary, aes(x=factor(ordenes_summary$Month), y = ordenes_summary$Total, group = ordenes_summary$Year)) + 
  geom_line(aes(color= factor(ordenes_summary$Year)))+
  geom_point(aes(color= factor(ordenes_summary$Year)))+
  labs(x = "Month", y = "Total", color = "Year" ) +
  ggtitle("Venta en miles de dolares") +
  theme(plot.title = element_text(hjust = 0.5))
