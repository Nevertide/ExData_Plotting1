##           Exploratory Data Analysis Week 1 Project
##Script:   PNG Graph Creation 3
##Author:   CS
##Date:     5/8/16
##Desc:     Construct an exploratory line plot from the power dataset as 
##          provided by the UC Urvine Machine Learning repository.

# Download and load the file if it doesn't exist.
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
png(filename = "plot3.png", height=480, width=480)

with(data.raw, {
            plot(y=Sub_metering_1, x=Time, pch="", ylab="Global Active Power (kilowatts)", xlab="", yaxt = "n")
            lines(Time, Sub_metering_1)
            lines(Sub_metering_2~Time,col='Red')
            lines(Sub_metering_3~Time,col='Blue')
      })

# Apply the legend in the upper right
legend("topright", col=c("black", "red", "blue"), lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Modify the axis values. I'm sure there is a better way to do this and am open to improvement.
axis(2, at = c(0,10,20,30))

# Close the png device.
dev.off()
