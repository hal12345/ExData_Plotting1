library("datasets")
library("stats")
library("graphics")
library("grDevices")
library("methods")


dataDir<-file.path(getwd(), "data")
zipFile<-file.path(dataDir, "consumption.zip")
pngFile<-file.path(dataDir, "plot1.PNG")
fileName<-"household_power_consumption.txt"
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#create directory dataDir if not exists
if (!file.exists(dataDir)){
  dir.create(dataDir)
}

download.file(url=fileUrl, destfile = zipFile, method="curl")

#unzip and read file
conFile <- unz(zipFile, fileName)
data <- subset(read.table(conFile, header=TRUE, sep=";", na.strings = "?"),Date=="1/2/2007" | Date=="2/2/2007")
unlink(conFile)

#plots
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

#create PNG file
dev.copy(png, file=pngFile, width=480, height=480)
dev.off()
