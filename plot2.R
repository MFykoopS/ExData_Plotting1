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

# save a plot of the global minute-averaged active power over time to a png file

png("plot2.png")
plot(data$datetime, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()