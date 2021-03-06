# downloading data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./exdata_data_household_power_consumption.zip")

# loading data 
listZip <- unzip("exdata_data_household_power_consumption.zip")
full <- readLines(file("./household_power_consumption.txt"))
part <- grep("^[1,2]/2/2007", full, value = TRUE)
top5 <- read.table("./household_power_consumption.txt",
                   header = TRUE, sep = ";", nrows = 5)
colnm <- names(top5) # get colnames
data <- read.table(text = part, header = FALSE, sep = ";", col.names = colnm, na.strings = "?", stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# making plots
png("plot4.png", width = 480, height = 480, unit = "px")
par(mfrow = c(2, 2))
with(data, plot(Time, Global_active_power, type = "n",
                xlab = "",
                ylab = "Global Active Power"))
with(data, lines(Time, Global_active_power))

with(data, plot(Time, Voltage, type = "n", xlab = "datetime", ylab = "Voltage"))
with(data, lines(Time, Voltage))

with(data, plot(Time, Sub_metering_1, type = "n",
                xlab = "",
                ylab = "Energy sub meeting"))
with(data, lines(Time, Sub_metering_1))
with(data, lines(Time, Sub_metering_2, col = "red"))
with(data, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

with(data, plot(Time, Global_reactive_power, type = "n",
                xlab = "datetime",
                ylab = "Global_reactive_power"))
with(data, lines(Time, Global_reactive_power))
dev.off()
