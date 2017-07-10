setwd("C:/MyGITWorkspace/")

#-------------------------------------------------------------------------------

## step 1: download zip file from website
if(!file.exists("./data")) dir.create("./data")
if(!file.exists("./data/projectData.zip"))
{
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "./data/projectData.zip")
  listZip <- unzip("./data/projectData.zip", exdir = "./data")
}


## step 2: load Data into R
PowerData <- read.table("./data/household_power_consumption.txt",sep=";",header = TRUE ,stringsAsFactors = FALSE)
PowerData$Date<-as.Date(PowerData$Date,format = "%d/%m/%Y")
PowerData <-subset(PowerData,(Date == as.Date("2007-02-01",format = "%Y-%m-%d")) | (Date == as.Date("2007-02-02",format ="%Y-%m-%d")))
hist(as.numeric(PowerData$Global_active_power),col="red",main="Global Active Power",xlab ="Global Active Power (kilowatts)" ,ylab ="Frequency" )
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()