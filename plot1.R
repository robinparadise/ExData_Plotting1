# Author: Robin Giles Ribera 2014
# File: plot1.R

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
hist(plotData, main="Global Active Power", 
     col="red", xlab="Global Active Power (kilowatts)",
     ylab = "Frequency")

## E. Construct the plot and save it to a PNG file with a width of 
## 480 pixels and a height of 480 pixels.
dev.copy(png, "plot1.png", height = 480, width = 480, bg = "transparent")

## F. close device
dev.off()
