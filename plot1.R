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
dataOriginal <- read.csv(fileName, na.strings = "?", header = TRUE, sep = ";")

dataSet <- dataOriginal[as.Date(dataOriginal$Date) == "02/01/2007",]
dataSet <- rbind(dataSet, dataOriginal[as.Date(dataOriginal$Date) == "02/02/2007",])
dataSet <- cbind(dataSet, "DateTime" = strptime (paste (dataSet$Date, dataSet$Time), format = "%m/%d/%Y %H:%M:%S")) 
