# Author: Robin Giles Ribera 2014
# File: plot2.R

# This assignment uses data from the UC Irvine Machine Learning Repository, 
# a popular repository for machine learning datasets. In particular, we will 
# be using the "Individual household electric power consumption Data Set"

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
# One alternative is to read the data from just those dates rather 
# than reading in the entire dataset and subsetting to those dates.

# You may find it useful to convert the Date and Time variables to 
# Date/Time classes in R using the strptime() and as.Date() functions.
# Note that in this dataset missing values are coded as ?.

ROOT <- 'exdata-data-household_power_consumption'
sepFile <- '/'
sep <- ';'

## A. Download data files
if ( !file.exists(ROOT) ) {
  dir.create(paste(".", ROOT, sep=sepFile))
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "Data.zip", method = "curl")
  unzip("Data.zip", exdir=".")
}

## B. Loading the data
data.all <- read.table(paste(ROOT,"household_power_consumption.txt", sep=sepFile),
                       header=TRUE, sep=sep, na.strings="?")

## C. We will only be using data from the dates 2007-02-01 and 2007-02-02
dates <- c("1/2/2007", "2/2/2007")
data <- subset(data.all, Date %in% dates)

## D. Construct the plot
library(datasets)
plotData <- as.numeric(data$Global_active_power)
plotData2 <- as.numeric(data$Voltage)
plotData4 <- as.numeric(data$Global_reactive_power)
days <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

submet1 <- as.numeric(as.character(data$Sub_metering_1))
submet2 <- as.numeric(as.character(data$Sub_metering_2))
submet3 <- as.numeric(as.character(data$Sub_metering_3))

par(mfcol = c(2, 2))

## Plot (1,1)
plot(days, plotData, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## Plot (2,1)
plot(days, submet1, type="l", xlab="", ylab="Energy sub metering")
lines(days, submet1, col="black")
lines(days, submet2, col="red")
lines(days, submet3, col="blue")

legend("topright", lty=1, bty = "n", cex=0.5, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot (1,2)
plot(days, plotData2, type = "l", ylab = "Voltage", xlab = "datetime")

## Plot (2, 2)
plot(days, plotData4, type="l", xlab = "datetime", ylab="Global_reactive_power")

## E. Construct the plot and save it to a PNG file with a width of 
## 480 pixels and a height of 480 pixels.
dev.copy(png, "plot4.png", height = 480, width = 480, bg = "transparent")

## F. close device
dev.off()

