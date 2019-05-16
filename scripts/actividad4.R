#Instalar xlsx package si no se tiene
#install.packages('openxlsx')

#Set directory to datasets
setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

#Save datasets into dataframes
datos001 <- read.csv('ST_Data.csv')
datos002 <- read.xlsx('Medallistas Olimpicos.xlsx')

#Probar que tienen datos
#head(datos001)
#head(datos002)

#Obtener renglones / columnas
rowsAndCols <- function( df ) {
  print(paste('Numero de renglones=',length(rownames(df))))
  print(paste('Numero de columnas=',length(colnames(df))))
}

rowsAndCols(datos001)
rowsAndCols(datos002)

#Comprobar con la funcion dim 
dim(datos001)
dim(datos002)

