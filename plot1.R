#      Exploratory-Data-Analysis Project Week 1
#      Author: Loc Nguyen
# Load Package
library(tidyverse)

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

# Plot1
hist(power.dt[, "Global_active_power"], main="Global Active Power", 
     +      xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.copy(png, file = "plot1.png", width=480, height=480)
dev.off()