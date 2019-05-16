setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

Semestre <- read.csv('Semestre.csv')
Periodos <- read.csv('PeriodosAcademicos.csv')
Procedencias <- read.csv('Procedencias.csv')
Graduados <- read.csv('Graduados.csv')
Carreras <- read.csv('Carreras.csv')
Escuelas <- read.csv('Escuelas.csv')
Departamentos <- read.csv('Departamentos.csv')
InfoAcad <- read.csv('InfoAcad_EM11_subset.csv')


# Script 1
Merge <- merge(Carreras, InfoAcad,
                     by.x = "idCarrera",
                     by.y = "idCarrera",
                     all.y = TRUE)

Merge2 <- merge(Merge, Procedencias,
                by.x = "IdAlumno",
                by.y = "idAlumno",
                all.x = TRUE)

# Se escogio la carrera 75
Merge2 <- Merge2[Merge2$TerminoIns == "N" & Merge2$idCarrera == "CARR75",]
Columnas <- c("PeriodoAcad", "Desc.Carrera","IdAlumno", "Cd_Procedencia", "Edo_Procedencia", "Semestre", "PromPrepa", "PromPeriodo", "PromedioAcum", "MatRepPeriodo", "MatRepAcum")
CARR75 <- Merge2[, Columnas]
CARR75

# Script 2
Merge <- merge(Escuelas,Departamentos,
               by.x = "idFac",
               by.y = "idFac",
               all.x = TRUE)

Merge2 <- merge(Merge, Carreras,
                by.x = "idDepto",
                by.y = "idDepto",
                all.x = TRUE)

Merge3 <- merge(Merge2, InfoAcad,
                     by.x = "idCarrera",
                     by.y = "idCarrera",
                     all.x = TRUE)

GradEscuela <- merge(Merge3, Graduados,
                     by.x = "IdAlumno",
                     by.y = "idAlumno",
                     all.x = TRUE)

Columnas <- c("PariodoGraduacion", "Desc.Facultad", "Desc.Departamento", "Desc.Carrera", "idFac")

GradEscuela <- GradEscuela[, Columnas]

GradEscuela2<- aggregate(GradEscuela$idFac,
                      by= list(GradEscuela$PariodoGraduacion,
                               GradEscuela$Desc.Facultad,
                               GradEscuela$Desc.Departamento,
                               GradEscuela$Desc.Carrera),
                      FUN= length)

names(GradEscuela2)<- c("PariodoGraduacion", "Desc.Facultad", "Desc.Departamento", "Desc.Carrera", "# Graduados")
GradEscuela2

# Script 3
Merge <- merge(Carreras,InfoAcad,
               by.x = "idCarrera",
               by.y = "idCarrera",
               all.x = TRUE)
Merge <- Merge[,c("idCarrera","PeriodoAcad")]
Periodos <- aggregate(x=Merge$PeriodoAcad,
          by= list(Merge$idCarrera, Merge$PeriodoAcad),
          FUN= length)
names(Periodos)<- c("idCarrera", "PeriodoAcad", "alumnos")
Periodos <- aggregate(x=Periodos$alumnos,
                      by= list(Periodos$idCarrera),
                      FUN= mean)
