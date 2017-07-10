setwd("C:/MyGITWorkspace/")
library(chron)
#-------------------------------------------------------------------------------

## step 1: download zip file from website and extract it
if(!file.exists("./data")) dir.create("./data")
if(!file.exists("./data/projectData.zip"))
{
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "./data/projectData.zip")
  listZip <- unzip("./data/projectData.zip", exdir = "./data")
}


## step 2: load Data into R and Plot it
PowerData <- read.table("./data/household_power_consumption.txt",sep=";",header = TRUE ,stringsAsFactors = FALSE)
PowerData$Date<-as.Date(PowerData$Date,format = "%d/%m/%Y")
PowerData <-subset(PowerData,(Date >= as.Date("2007-02-01",format = "%Y-%m-%d")) & (Date <= as.Date("2007-02-02",format ="%Y-%m-%d")))
PowerData$Time<-chron(times.=PowerData$Time,format=c(times="h:m:s"))
PowerData$newdate <- with(PowerData, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

plot(PowerData$newdate, PowerData$Sub_metering_1, ylim=range(c(0,40)),type="n",xlab="",ylab="Energy sub metering")
par(new=TRUE)
plot(PowerData$newdate, PowerData$Sub_metering_1, ylim=range(c(0,40)),type="S",axes = FALSE,col="black",xlab="",ylab="")
par(new=TRUE)
plot(PowerData$newdate, PowerData$Sub_metering_2, ylim=range(c(0,40)),type="S",axes = FALSE,col="red",xlab="",ylab="")
par(new=TRUE)
plot(PowerData$newdate, PowerData$Sub_metering_3, ylim=range(c(0,40)),type="S",axes = FALSE,col="blue",xlab="",ylab="")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd = 2,col=c("black","red","blue"))





dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()