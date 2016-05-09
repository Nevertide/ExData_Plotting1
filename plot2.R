##           Exploratory Data Analysis Week 1 Project
##Script:   PNG Graph Creation 2
##Author:   CS
##Date:     5/8/16
##Desc:     Construct an exploratory line plot from the power dataset as 
##          provided by the UC Urvine Machine Learning repository.


# Now download and load the file if it doesn't exist.
if (!file.exists("household_power_consumption.txt")) {
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      temp <- tempfile()
      download.file(fileURL, temp, mode="wb")
      unzip(temp, "household_power_consumption.txt")
      data.raw <- read.csv("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
}

# Now convert the date field, subset, and then convert the time field.
data.raw$Date <- as.Date(data.raw$Date, '%d/%m/%Y')
data.raw <- subset(data.raw, Date >= '2007-02-01' & Date <= '2007-02-02')
data.raw$Time <- as.POSIXct(paste(data.raw$Date, data.raw$Time), format='%Y-%m-%d %H:%M:%S')

# Initiate the png device.
png(filename = "plot2.png", height=480, width=480)

# Now build the base plot. The LINE function will draw it out, so we want to hide the 
# specific data points by setting pch = "".
plot(data.raw$Time,data.raw$Global_active_power, pch="", ylab="Global Active Power (kilowats)", xlab="", yaxt = "n")

# Now, draw in the lines.
lines(data.raw$Time,data.raw$Global_active_power)

# Unfortunately, I can't seem to figure out how to edit the axis. I'm hoping someone will be kind
# enough to point me in the right direction.
axis(2, xlab=c(0, 6000, 4))

# Close the png device.
dev.off()
