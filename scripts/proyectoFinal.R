##############################################################
# Alejandro De la Cruz Tarin A00816503
##############################################################
setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets/proyecto')
dir()
install.packages("ggplot2")
library(ggplot2)
##################################################################
# Auxiliar functions for repeated code, 
# yeiii more readable code !
##################################################################
getData <- function() {
  files = list.files(pattern="*.csv")
  return (do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE))))
}
filterByCarriers <- function(data,series) {
  if(length(series) < 1) return(data)

  filtered <- data.frame(YEAR = integer(),
                         DEP_DELAY_NEW = double(), 
                         OP_UNIQUE_CARRIER=character(), 
                         stringsAsFactors=FALSE) 
  for (s in series) {
    # TODO: Delete head
    filtered <- rbind(filtered, data[data$OP_UNIQUE_CARRIER == s,])
  }
  return(filtered)
}
filterByCanceled <- function(data, status = 0) {
  return (data[data$CANCELLED == status,])
}
filterByYear <- function(data, years) {
  if(length(years) < 1) return(data)
  
  filtered <- data.frame(YEAR = integer(),
                         DEP_DELAY_NEW = double(), 
                         OP_UNIQUE_CARRIER=character(), 
                         stringsAsFactors=FALSE) 
  for (y in years) {
    filtered <- rbind(filtered, data[data$YEAR == y,])
  }
  return(filtered)
}
####################################################################
# Pregunta 1
# compareDelayLines
# Parametros: Set de datos, array con ids de aerolineas
# Retorno: GGplot o FALSO en caso de que no se proporcionen series
#####################################################################
compareDelayLines <- function(data,series) {
  if(length(series) < 1) return(FALSE)
  d <- data[data$CANCELLED == 0,c(
    "YEAR", 
    "DEP_DELAY_NEW", 
    "OP_UNIQUE_CARRIER")]
  filtered <- filterByCarriers(d, series)
  delay_summary <- aggregate(x=filtered$DEP_DELAY_NEW, by = list(filtered$YEAR, filtered$OP_UNIQUE_CARRIER), FUN = mean)
  names(delay_summary) <-c("YEAR", "CARRIER", "MEAN_DELAY")
  ggplot(data = delay_summary, aes(x=factor(delay_summary$YEAR), y = delay_summary$MEAN_DELAY, group = delay_summary$CARRIER)) + 
    geom_line(aes(color= factor(delay_summary$CARRIER))) +
    geom_point(aes(color= factor(delay_summary$CARRIER))) +
    labs(x = "YEAR", y = "DELAY (MEAN)", color = "CARRIER", title="Retraso promedio de salida por aerolinea", subtitle="Pregunta 1" ) +
    theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
}
####################################################################
# Pregunta 2
# compareDelayBox
# Parametros: Set de datos, array con ids de aerolineas, 
# array de años, booleano para hacer zoom (opcional)
# Retorno: GGplot o FALSO en caso de que no se proporcionen series
# Nota: Ya que el maximo es muy alto proporcionalmente a la media 
# y a los quantiles se añadio una opcion para hacer zoom donde se 
# se restringen los limites y a 2.5 la media
#####################################################################
compareDelayBox <- function(data,series, years, zoom = TRUE) {
  if(length(series) < 1) return(FALSE)
  d <- data[data$CANCELLED == 0,
               c("YEAR", "DEP_DELAY_NEW", "OP_UNIQUE_CARRIER")]
  filtered <- filterByCarriers(d, series)
  filtered <- filterByYear(filtered, years)
  # Limite superior, ya que el maximo es muy alto proporcionalmente a la media y a los quantiles
  if (zoom == TRUE) p <- mean(filtered$DEP_DELAY_NEW) * 2.5 
  else  p <- max(filtered$DEP_DELAY_NEW)
  ggplot(data = filtered, aes(x=factor(filtered$YEAR), y = filtered$DEP_DELAY_NEW, fill = factor(filtered$OP_UNIQUE_CARRIER))) + 
    geom_boxplot() +
    coord_cartesian(ylim = c(0, p))+ 
    labs(x = "YEAR", y = "DELAY", fill = "CARRIER", title="Distribución de Retraso de salida por aerolinea", subtitle = "Pregunta 2") +
    theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
}
####################################################################
# Pregunta 3
# compareDelayTypes
# Parametros: Set de datos, id de aerolinea
# Retorno: GGplot
#####################################################################
compareDelayTypes <- function(data,carrier) {
  filtered <- data[data$CANCELLED == 0 ,c(
    "YEAR",
    "DEP_DELAY_NEW", 
    "OP_UNIQUE_CARRIER",
    "CARRIER_DELAY" ,
    "WEATHER_DELAY", 
    "SECURITY_DELAY",
    "LATE_AIRCRAFT_DELAY",
    "NAS_DELAY")]
  filtered <- filtered[filtered$OP_UNIQUE_CARRIER == carrier, ]
  filtered[is.na(filtered)] <- 0
  delay_summary <- aggregate(x=list(
    filtered$DEP_DELAY_NEW, 
    filtered$CARRIER_DELAY,
    filtered$WEATHER_DELAY,
    filtered$SECURITY_DELAY,
    filtered$LATE_AIRCRAFT_DELAY,
    filtered$NAS_DELAY), 
    by = list(
      filtered$YEAR, 
      filtered$OP_UNIQUE_CARRIER)
    , FUN = mean)
  names(delay_summary) <-c("YEAR", 
                           "CARRIER", 
                           "MEAN_DELAY",
                           "CARRIER_DELAY" ,
                           "WEATHER_DELAY", 
                           "SECURITY_DELAY",
                           "LATE_AIRCRAFT_DELAY",
                           "NAS_DELAY")
  ggplot(data = delay_summary) + 
    geom_line(aes(x=delay_summary$YEAR ,y=delay_summary$CARRIER_DELAY, color="Carrier")) +
    geom_line(aes(x=delay_summary$YEAR ,y=delay_summary$WEATHER_DELAY, color="Weather")) +
    geom_line(aes(x=delay_summary$YEAR ,y=delay_summary$SECURITY_DELAY, color="Security")) + 
    geom_line(aes(x=delay_summary$YEAR ,y=delay_summary$LATE_AIRCRAFT_DELAY, color="Late Aircraft")) +
    geom_line(aes(x=delay_summary$YEAR ,y=delay_summary$NAS_DELAY, color="NAS")) +
    labs(x = "YEAR", y = "DELAY (MEAN)", color = "Delay causes", title = "Distribución de Retraso de salida por causa", subtitle = "Pregunta 3" ) +
    theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
}
####################################################################
# Pregunta 4
# Funcion Delaydistance
# Parametros: Set de datos, año especifico (Opcional)
# Retorno: GGplot
# Nota: Si se añade el año especifico se hara solo el grafico de este,
# sino se hara el grafico de todos los años de la data
#####################################################################
Delaydistance <- function(data, year = NULL) {
  filtered <- data[data$CANCELLED == 0 ,c(
    "YEAR", "DISTANCE", "DEP_DELAY_NEW")]
  if (!is.null(year)) {
    filtered <- filtered[filtered$YEAR == year,]
  }
  summary <- aggregate(x=list(filtered$DEP_DELAY_NEW), by=list(filtered$YEAR, filtered$DISTANCE), FUN=mean)
  names(summary) <- c("YEAR", "DISTANCE", "DEP_DELAY_NEW")
  summary[is.na(summary)] <- 0
  ggplot(data = summary, aes(x=summary$DISTANCE, y=summary$DEP_DELAY_NEW, colour = summary$YEAR)) + 
      geom_line() +
      theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)) +
      facet_grid(rows = vars(summary$YEAR)) +
      labs(x = "DISTANCE", y = "DELAY (MEAN)", color="YEAR", title="Relación entre Restraso de salida y distancia recorrida", subtitle="Pregunta 4")
}
# Pruebas ##########################################################
carrier <- "WN"
series <- c('DL', 'OO')
years <- seq(2011,2012)
data <- getData()
compareDelayLines(data,series)
compareDelayBox(data,series, years, zoom = TRUE)
compareDelayTypes(data,carrier)
Delaydistance(data)
