#Exploratory Analysis course

#Sys.setlocale(category = "LC_TIME", locale="en_US.UTF-8")

###Reading in
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)


data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", header = T, stringsAsFactors = F, na.strings = "?")

unlink(temp)

## fixing dates
data$Date_time <- with(data, paste(Date, Time))
data$Date_time <- strptime(data$Date_time, format = "%d/%m/%Y %H:%M:%S") 
data$Date_time <- as.POSIXct(data$Date_time)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")



get_dates <- data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02")
data_filtered <- data[get_dates, ] 

#Plot 4
png(file = "plot4.png")

par(mfrow = c(2,2))

with(data_filtered, { 
  plot(Date_time, Global_active_power, type = "l", 
                         ylab = "Global Active Power", xlab = "")

  plot(Date_time, Voltage, type = "l",
                    ylab = "Voltage", xlab = "datetime")
  
  plot(Date_time, Sub_metering_1, type = "l", 
       ylab = "Energy sub metering", xlab = "")
  lines(Date_time, Sub_metering_2, col = "red")
  lines(Date_time, Sub_metering_3, col = "blue")
  legend(x = "topright", lwd = 2, col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         bty = "n",
         lty= c(1,1,1),
         cex = 0.75)
  
  
  plot(Date_time, Global_reactive_power, type = "l",
       ylab = "Global_reactive_power", xlab = "datetime")
  
})


dev.off()
