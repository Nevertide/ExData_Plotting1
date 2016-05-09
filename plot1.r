##           Exploratory Data Analysis Week 1 Project
##Script:   PNG Graph Creation 1
##Author:   CS
##Date:     5/8/16
##Desc:     Construct an exploratory histogram from the power dataset as 
##          provided by the UC Urvine Machine Learning repository.

# Initially this was attempted via sqldf to only draw in the required dates. However, I ran
# into errors initially in the DBI and RSQLite packages. When that was resolved, I would get
# hanging connections that would never resolve - or perhaps the process was taking 30+ mins for
# some very strange reason.
# Here's the SQL statement: data.sqlfilter <- "SELECT * FROM file WHERE date BETWEEN '2007-02-01' AND '2007-02-02'"

# Now download and load the file if it doesn't exist.
if (!file.exists("household_power_consumption.txt")) {
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      temp <- tempfile()
      download.file(fileURL, temp, mode="wb")
      unzip(temp, "household_power_consumption.txt")
      data.raw <- read.csv("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
}
# data.sqlfilter <- "SELECT * FROM file WHERE date BETWEEN '2007-02-01' AND '2007-02-02'"
# data.raw2 <- read.csv2.sql("household_power_consumption.txt", sql = "SELECT * FROM file LIMIT 10", header = T, eol = )

# Now convert the date field, subset, and then convert the time field.
data.raw$Date <- as.Date(data.raw$Date, '%d/%m/%Y')
data.raw <- subset(data.raw, Date >= '2007-02-01' & Date <= '2007-02-02')
data.raw$Time <- as.POSIXct(paste(data.raw$Date, data.raw$Time), format='%Y-%m-%d %H:%M:%S')

# Initiate the png device.
png(filename = "plot1.png", height=480, width=480)

# Now build the histogram of global active power.
hist(as.numeric(data.raw$Global_active_power), col = "red", xlab = "Global Active Power (kilowats)", main = "Global Active Power")

# Close the png device.
dev.off()
