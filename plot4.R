# read data for 1/2/2007 and 2/2/2007
data <- read.csv2("../household_power_consumption.txt", na.strings = "?",
                  colClasses = "character", header = F, skip = 66637, nrows = 2880)

# read colnames for data frame from first line of file
file <- file("../household_power_consumption.txt", "r")
colns <- readLines(file, 1)
close(file)

# formatting
colns <- strsplit(colns, ";")[[1]]
colnames(data) <- colns

# set appropriate data types
data$datetime <- strptime(with(data, paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
for (i in 3:9) {
    data[, i] <- as.numeric(data[, i])
}

# print weekdays in English
Sys.setlocale("LC_TIME", "en_US.UTF-8")

# divide the screen andsave the four plots of the energy sub metering over time
# to a png file

png("plot4.png")
par(mfrow = c(2,2))
with(data, {
    plot(datetime, Global_active_power, type = "l",
         ylab = "Global Active Power (kilowatts)", xlab = "")
    plot(datetime, Voltage, type = "l")
    plot(datetime, Sub_metering_1, type = "l",
         ylab = "Energy sub metering", xlab = "")
    lines(datetime, Sub_metering_2, col = "red")
    lines(datetime, Sub_metering_3, col = "blue")
    legend("topright", names(data[, 7:9]), lty = 1, bty = "n",
           col = c("black", "red", "blue"))
    plot(datetime, Global_reactive_power, type = "l")
})
dev.off()