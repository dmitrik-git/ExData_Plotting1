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

# Setting up PNG device
png(file = "plot4.png", width = 480, height = 480)

# Setting up the 2x2 grid
par (mfcol = c(2,2))

# The first plot
with (dataSet, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))

## The second plot
# yaxt to show the y-scaling, xaxt to make sure x-scale is visible 
par (yaxt = 's', xaxt = 's') 

#First line
with (dataSet, plot(DateTime, Sub_metering_1, ylab = "", xlab = "", type = "l"))

# new to make lines overlap, yaxt to hide y-labels
par(new = TRUE, yaxt = 'n')

# Second line
with (dataSet, plot(DateTime, Sub_metering_2, ylab = "", xlab = "", type = "l", col = "red", ylim = c(0,30)))

# new to make lines overlap, yaxt to hide y-labels
par(new = TRUE, yaxt = 'n')

# Third line
with (dataSet, plot(DateTime, Sub_metering_3, ylab= "Energy sub metering", xlab = "", type = "l", col = "blue", ylim = c(0,30)))

# Adding the legend
legend ("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Resetting parameters
par(new = FALSE, yaxt = 's', xaxt = 's')

### The third plot
with (dataSet, plot(DateTime, Voltage, type = "l", ylab = "Voltage"))

#### The fourth plot
with (dataSet, plot(DateTime, Global_reactive_power, type = "l"))


dev.off()

