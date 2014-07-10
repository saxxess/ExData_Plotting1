setwd("~/Dropbox/Coursera/Data Science/04 Exploratory Data Analysis/Project/")
# downloading and unziping the file
if(!file.exists("exdata-data-household_power_consumption.zip")){
      fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileURL,destfile="./exdata-data-household_power_consumption.zip", method="curl")
      unzip("./exdata-data-household_power_consumption.zip")
}


# reading the data into R
tab5rows <- read.table("household_power_consumption.txt", header = T, nrows = 5, sep = ";")
classes <- sapply(tab5rows, class)
classes <- as.vector(classes)
powerConsumption <- read.table("household_power_consumption.txt", colClasses = classes, header = T, sep = ";", na.strings = "?", comment.char = "")


# Updating the date format
powerConsumption$Date <- strptime(powerConsumption$Date, "%d/%m/%Y")
powerConsumption$Date <- as.character(powerConsumption$Date)
powerSubset$Time <- as.character(powerSubset$Time)

# Subsetting the desired dates "2007-02-01" and "2007-02-02"
powerSubset <- powerConsumption[powerConsumption$Date== "2007-02-01" | powerConsumption$Date== "2007-02-02",]
powerSubset$DateTime <- paste(powerSubset$Date, powerSubset$Time, sep = " ")
powerSubset$DateTime <- as.character(powerSubset$DateTime)
powerSubset$DateTime <- strptime(powerSubset$DateTime, format = "%Y-%m-%d %H:%M:%S")


# Global Active Power Plot
png(filename = "plot2.png")
with(powerSubset, plot(DateTime, Global_active_power, type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
)
dev.off()
