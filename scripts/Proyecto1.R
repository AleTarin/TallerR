setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

# 1.- Generar un script que integre todos los archivos
# en un solo data frame llamado Rita2016 y que contenga
# los registros de vuelo de todo el 2016

Rita2016 <- rbind(
  read.csv('Ene2016.csv'),
  read.csv('Feb2016.csv'),
  read.csv('Mar2016.csv'),
  read.csv('Abr2016.csv'),
  read.csv('May2016.csv'),
  read.csv('Jun2016.csv'),
  read.csv('Jul2016.csv'),
  read.csv('Ago2016.csv'),
  read.csv('Sep2016.csv'),
  read.csv('Oct2016.csv'),
  read.csv('Nov2016.csv'),
  read.csv('Dic2016.csv')
  )

# 2.-  Crear una función llamada RitaTop que 
# genere una tabla con el Top n o el Bottom n 
# de los aeropuertos (ORIGIN_CITY_NAME) en función
# al tiempo promedio de retraso de salida (DEP_DELAY_NEW)


RitaTop = function(Data, TipoLista, Num, Mes) {
  
  # Considerar solo los vuelos NO cancelados
  Rita <- Data[Data$CANCELLED == 0,]
  
  # Considerar solo los del mes
  if (Mes != 0) {
    Rita <- Rita[Rita$MONTH == Mes,]
  }
  
  # Obtener el promedio de retrasos
  MEAN_DELAY <- aggregate( x = Rita["DEP_DELAY_NEW"], 
                           by = list(AIRPORT = Rita$ORIGIN_CITY_NAME), 
                           FUN = mean, 
                           na.rm =TRUE)
  
  # Obtener el numero de vuelos
  FLIGHTS <- aggregate( x = Rita["ORIGIN_CITY_NAME"], 
                        by = list(AIRPORT = Rita$ORIGIN_CITY_NAME), 
                        FUN = length)
  
  
  # El data frame debe contener las siguientes columnas: 
  # Clave de Aeropuerto, Nombre de aeropuerto, Estado, Ciudad y retraso promedio y Numero de vuelos
  cols <-  c("AIRLINE_ID", "UNIQUE_CARRIER", "ORIGIN_CITY_NAME", "ORIGIN_STATE_NM")
  RSS <- Rita[,cols]
  
  # Combinar los datasets
  Merge <- merge(MEAN_DELAY, FLIGHTS, by = "AIRPORT")
  RMerge <- merge(Merge, RSS, by.x = "AIRPORT", by.y = "ORIGIN_CITY_NAME")
  
  # Eliminar los duplicados
  RFilter <- RMerge[!duplicated(RMerge$AIRPORT),]
  
  # Ordenar los resultados ordenados
  RFinal <- RFilter[order(RFilter$DEP_DELAY_NEW, decreasing = as.logical(TipoLista)),]
  
  names(RFinal) <- c('Ciudad','Retraso Promedio','Numero de vuelos', 'Clave del Aeropuerto', 'Nombre del aeropuerto', 'Estado')
  head(RFinal, Num)
}

Respuesta = RitaTop(Data = Rita2016, TipoLista = 1, Num = 10, Mes = 1)
