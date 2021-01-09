# Loading data

if (!file.exists("data")) {
    dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip", method = "curl")

install.packages("zip")
library(zip)
unzip("./data/household_power_consumption.zip", exdir = "./data/")
fileName <- "./data/household_power_consumption.txt"

# Reading data
dataOriginal <- read.csv(fileName, na.strings = "?", header = TRUE, sep = ";", stringsAsFactors = FALSE)

dataOriginal <- cbind(dataOriginal, "DateTime" = strptime (paste (dataOriginal$Date, dataOriginal$Time), format = "%d/%m/%Y %H:%M:%S")) 
dataSet <- dataOriginal[as.Date(dataOriginal$Date, format = "%d/%m/%Y") == as.Date("2007-02-01"),]
dataSet <- rbind(dataSet, dataOriginal[as.Date(dataOriginal$Date, format = "%d/%m/%Y") == as.Date("2007-02-02"),])

png(file = "plot3.png", width = 480, height = 480)

dataSet <- transform (dataSet, Wday = factor(weekdays (dataSet$DateTime, abbreviate = TRUE) ))


par (yaxt = 's', yaxs = 'r', xaxt = 's')
with (dataSet, plot(DateTime, Sub_metering_1, ylab = "", type = "l"))
par(new = TRUE, yaxt = 'n')
with (dataSet, plot(DateTime, Sub_metering_2, ylab = "", type = "l", col = "red", ylim = c(0,30)))
par(new = TRUE, yaxt = 'n')
with (dataSet, plot(DateTime, Sub_metering_3, ylab= "Energy sub metering", type = "l", col = "blue", ylim = c(0,30)))

legend ("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
par(new = FALSE, yaxt = 's')

dev.off()

