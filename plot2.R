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

dataSet <- transform (dataSet, Wday = factor(weekdays (dataSet$DateTime, abbreviate = TRUE) ))
with (dataSet, plot(Wday, Global_active_power, type = "c"))

png(file = "plot2.png", width = 480, height = 480)


plot(dataSet$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

