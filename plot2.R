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
with(PowerData,plot(newdate,Global_active_power, type = "S",xlab = ""))
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()