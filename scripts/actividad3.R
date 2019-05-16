setwd('C:/Users/a.de.la.cruz/Documents/tallerR/scripts')

Semestre     <- rep(c(4:7), each = 6)
Ano          <- rep(c(2016:2018), times = c(6,12,6))
Materia      <- c('Expr verbal en ?mbito profes','Bases de datos','Proyecto desarrollo de videoj','An?lisis y dise?o de algoritm','Fundamentos de redes','M?todos num?ricos en ing',
                  'Humanidades y bellas artes','?lgebra lineal','An?lis y mod de sist softw','Sistemas operativos','Matem?ticas computacionales','Interconexi?n de redes',
                  'Emprendimiento','Proy de desarrollo para disp m','Programaci?n avanzada','Bases de datos avanzadas','Calidad y pruebas de software','Evaluaci?n y adm de proyectos',
                  'Ciudadan?a','Lenguajes de programaci?n','Desarrollo de aplicaciones web','Seguridad inform?tica','Adm?n de proy ingenier?a de sw', 'Animacion')
Calificacion <- c(95,87,89,85,92,92,
                  99,91,86,89,91,100,
                  81,97,89,97,84,90,
                  89,87,92,99,88,84)

df <- data.frame(Semestre, Ano, Materia, Calificacion)
print(df)


install.packages('openxlsx')
