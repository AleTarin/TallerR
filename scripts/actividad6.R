setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

Orders <- read.csv('Orders.csv')
Orders$OrderDate <- as.Date(Orders$OrderDate, "%m/ %d/ %Y")

Anios <- format(Orders$OrderDate, "%Y")
OrdersYear <- as.data.frame(table(Anios))
names(OrdersYear) <- c("Años", "NumOrdenes")

