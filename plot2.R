library("datasets")
library("stats")
library("graphics")
library("grDevices")
library("methods")

dataDir<-file.path(getwd(), "data")
zipFile<-file.path(dataDir, "consumption.zip")
pngFile<-file.path(dataDir, "plot2.PNG")
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

data<- cbind(data, true_date = strptime(paste(data$Date,data$Time), "%d/%m/%Y%H:%M:%S"))

#plots
plot(data$true_date, data$Global_active_power, type="l", xlab="",ylab="Global Active Power (kilowatts)")

#create PNG file
dev.copy(png, file=pngFile, width=480, height=480)
dev.off()

