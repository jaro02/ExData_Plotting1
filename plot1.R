## Plot 1 ##

## Read data

library(dplyr)
library(lubridate)

power_cons_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")

## Merging Date and Time into DateTS column
power_cons_data$DateTS <- paste(power_cons_data$Date, power_cons_data$Time, sep = " ")

## Converting DateTS to time format, removing unneeded columns and changing order of columns
power_cons_data$DateTS <- strptime(power_cons_data$DateTS, "%d/%m/%Y %H:%M:%S")
power_cons_data$Date <- NULL
power_cons_data$Time <- NULL
power_cons_data <- power_cons_data[,c(8, 1 ,2, 3, 4, 5, 6, 7)]

## Selecting needed dates only
power_cons_data <- subset(power_cons_data,
                          DateTS >= as.POSIXct('2007-02-01 00:00:00') &
                            DateTS < as.POSIXct('2007-02-03 00:00:00')
)

## Converting remaining columns from factor to character and finally to numeric
power_cons_data[, c(2:7)] <- sapply(power_cons_data[, c(2:7)], as.character)
power_cons_data[, c(2:7)] <- sapply(power_cons_data[, c(2:7)], as.numeric)

## Renaming data set
power_dt <- power_cons_data

## Crerating plot1

png("plot1.png", width = 480, height = 480)
hist(power_dt$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", main = "Global Active Power", col = "red")
dev.off()