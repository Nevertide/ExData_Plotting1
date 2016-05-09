##           Exploratory Data Analysis Week 1 Project
##Script:   PNG Graph Creation 4
##Author:   CS
##Date:     5/8/16
##Desc:     Construct multiple exploratory plots from the power dataset as 
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
png(filename = "plot4.png", height=480, width=480)

# Define the par layout for the plots to utilize.
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

# Combine all of the plots into a single statement using with.
with(data.raw, {
      # Plot 1.
      plot(Time, Global_active_power, pch="", ylab="Global Active Power (kilowats)", xlab="")
      lines(Time, Global_active_power)
      
      #plot 2.
      plot(y=Voltage, x=Time, pch="", ylab="Voltage", xlab="datetime")
      lines(y=Voltage, x=Time)
      
      #Plot 3.
      plot(y=Sub_metering_1, x=Time, pch="", ylab="Global Active Power (kilowatts)", xlab="")
      lines(Time, Sub_metering_1)
      lines(Sub_metering_2~Time,col='Red')
      lines(Sub_metering_3~Time,col='Blue')
      
      #Plot 4.
      plot(y=Global_reactive_power, x=Time, pch="", xlab="datetime")
      lines(y=Global_reactive_power, x=Time)
})


# Close the png device.
dev.off()
