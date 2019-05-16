setwd('C:/Users/a.de.la.cruz/Documents/tallerR/datasets')
dir()

Survey <- read.csv("Survey_sub.csv")

mean(Survey[
  (Survey$AirlineCode == "AA" &
     Survey$FlightYear == "2014"  &
     Survey$FlightMonth == 1 &
     Survey$FlightDay == 1 ), ]$Satisfaction)
Survey$Satisfaction

Satisfacion <- function(Survey, AirlineCode, FlightYear, FlightMonth, FlightDay) {
  mean(Survey[
    (Survey$AirlineCode == AirlineCode &
     Survey$FlightYear  == FlightYear  &
     Survey$FlightMonth  == as.numeric(FlightMonth) &
     Survey$FlightDay  == as.numeric(FlightDay) ), ]$Satisfaction)
}

Satisfacion ( Survey, 'AA', '2014','01','01')
Satisfacion ( Survey, 'VX', '2014','03','30') 
Satisfacion ( Survey, 'MQ', '2014','02','20') 