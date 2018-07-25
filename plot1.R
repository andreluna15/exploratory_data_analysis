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
  
#Plot 1
png(file = "plot1.png")

hist(data_filtered$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     ylim = c(0, 1300))

dev.off()

  
  
