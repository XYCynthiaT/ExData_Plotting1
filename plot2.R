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
png("plot2.png", width = 480, height = 480, unit = "px")
with(data, plot(Time, Global_active_power, type = "n",
                xlab = "",
                ylab = "Global Active Power (kilowatts)"))
with(data, lines(Time, Global_active_power))
dev.off()
