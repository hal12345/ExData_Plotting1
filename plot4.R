library("datasets")
library("stats")
library("graphics")
library("grDevices")
library("methods")

dataDir<-file.path(getwd(), "data")
zipFile<-file.path(dataDir, "consumption.zip")
pngFile<-file.path(dataDir, "plot4.PNG")
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName<-"household_power_consumption.txt"

#create directory dataDir if not exists
if (!file.exists(dataDir)){
  dir.create(dataDir)
}

download.file(url=fileUrl, destfile = zipFile, method="curl")

#unzip and read file
conFile <- unz(zipFile, fileName)
data <- subset(read.table(conFile, header=TRUE, sep=";", na.strings = "?"),Date=="1/2/2007" | Date=="2/2/2007")
unlink(conFile)

#add new date column
data<- cbind(data, true_date = strptime(paste(data$Date,data$Time), "%d/%m/%Y%H:%M:%S"))

#plots
par(mfrow = c(2, 2), pin=c(2,2))

#plot1
plot(data$true_date, data$Global_active_power, type="l", xlab="",ylab="Global Active Power (kilowatts)")

#plot2
plot(data$true_date, data$Voltage, type="l", xlab="datetime",ylab="Voltage")

#plot3
plot(data$true_date, data$Sub_metering_1, type="l", xlab="",ylab="Energy sub metering")
lines(data$true_date, data$Sub_metering_2, col="red")
lines(data$true_date, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=c(1,1), col=c("black", "blue","red"),bty="n")

#plot4
plot(data$true_date, data$Global_reactive_power, type="l", xlab="datetime",ylab="Global_reactive_power")

#create PNG file
dev.copy(png, file=pngFile, width=480, height=480)
dev.off()


