## Plot 3 ##

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

## Creating plot 3

## png("plot3.png", width = 480, height = 480)
plot(power_dt$DateTS, power_dt$Sub_metering_1, type = "n", xaxt = "n", 
     ylab = "Energy sub metering", xlab = "")
lines(power_dt$DateTS, power_dt$Sub_metering_1, type = "l")
lines(power_dt$DateTS, power_dt$Sub_metering_2, type = "l", col = "red")
lines(power_dt$DateTS, power_dt$Sub_metering_3, type = "l", col = "blue")
axis(1,at = seq.POSIXt(from = power_dt$DateTS[1], by = "day", length.out = 3), 
     labels = wday(seq.POSIXt(from = power_dt$DateTS[1], by = "day", length.out = 3), label = TRUE))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

## dev.off()