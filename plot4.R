#      Exploratory-Data-Analysis Project Week 1
#      Author: Loc Nguyen
# Load Package
library(tidyverse)
library(lubridate)

# Set wd (Difference from other devices)
setwd("C:/Users/ASUS/Documents/GitHub/Exploratory-Data-Analysis")

# Data download
dataurl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# Get data
path <- getwd()
download.file(dataurl, file.path(path, "datafiles.zip"))
unzip(zipfile = "datafiles.zip")

# Read data
power.dt <- read.table("./household_power_consumption.txt", sep = ";", header = T, na.strings = "?")
p1 <- power.dt ## Back up original data

# Check and Change Date Column to Date Type
class(power.dt$Date)
power.dt["Date"] <- as.Date(power.dt$Date, format = "%d/%m/%Y")

# Filter Dates for 2007-02-01 and 2007-02-02
power.dt <- filter(power.dt, (Date >= "2007-02-01") & (Date <= "2007-02-02"))

# Prevents histogram from printing in scientific notation
options(scipen = 5)

# Combine Date and Time col 
p2 <- power.dt %>%
      unite(datetime, Date, Time, sep = " ")
p2$datetime <- ymd_hms(p2$datetime)


# 4 Plots
png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

## Plot 1
plot(p2[, "datetime"], p2[, "Global_active_power"], type="l", xlab="", ylab="Global Active Power")

## Plot 2
plot(p2[, "datetime"],p2[, "Voltage"], type="l", xlab="datetime", ylab="Voltage")

## Plot 3
plot(p2[, "datetime"], p2[, "Sub_metering_1"], type="l", xlab="", ylab="Energy sub metering")
lines(p2[, "datetime"], p2[, "Sub_metering_2"], col="red")
lines(p2[, "datetime"], p2[, "Sub_metering_3"],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")
       , lty=c(1,1)
       , bty="n") 

## Plot 4
plot(p2[, "datetime"], p2[ , "Global_reactive_power"], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
