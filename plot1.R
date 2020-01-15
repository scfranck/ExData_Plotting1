## Configuration
install.packages('data.table')                                          ## install required package
install.packages('zip')                                                 ## install required package
library(data.table)                                                     ## load package
library(zip)                                                            ## load package

## Read data
setwd("C:/Users/chrisse1/Desktop/Exploratory Data Analysis by Johns Hopkins University")  ## customize to your own settings
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "C:/Users/chrisse1/Desktop/Exploratory Data Analysis by Johns Hopkins University/exdata_data_household_power_consumption.zip")  ## download the file locally
unzip("exdata_data_household_power_consumption.zip")                    ## unzip the data into to current working directory
mydat <- fread('household_power_consumption.txt')                       ## read the data

## Check data
dim(mydat)                                                              ##  check dimensions
str(mydat)                                                              ##  check data types and show samples

## Fix data types
mydat$Global_active_power <- as.numeric(mydat$Global_active_power)      ## set numbers to num
mydat$Global_reactive_power <- as.numeric(mydat$Global_reactive_power)  ## set numbers to num
mydat$Voltage <- as.numeric(mydat$Voltage)                              ## set numbers to num
mydat$Global_intensity <- as.numeric(mydat$Global_intensity)            ## set numbers to num
mydat$Sub_metering_1 <- as.numeric(mydat$Sub_metering_1)                ## set numbers to num
mydat$Sub_metering_2 <- as.numeric(mydat$Sub_metering_2)                ## set numbers to num
mydat$Sub_metering_3 <- as.numeric(mydat$Sub_metering_3)                ## set numbers to num
mydat$DateTime <- paste(mydat$Date, mydat$Time, sep=" ")                ## concatenate date and time
mydat$DateTime <- as.POSIXct(mydat$DateTime, format = "%d/%m/%Y %H:%M:%S")  ## set to date time

## Check data again
dim(mydat)                                                              ## check dimensions
str(mydat)                                                              ## check data types and show samples

## Limit data to the dates 2007-02-01 to 2007-02-02 and check
mydat2 <- mydat[mydat$DateTime >= "2007-02-01 00:00:00" & mydat$DateTime < "2007-02-03 00:00:00"]   ## limit to 2 days
dim(mydat2)                                                             ## check dimensions
str(mydat2)                                                             ## check data types and show samples

## Build Plot 1
dev.new(width=480, height=480, unit="px")                              ## set the plot are to 480x480 px
hist(mydat2$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")                         ## create the plot in the screen device
dev.copy(png, file = "plot1.png")                                      ## copy the plot as a png file in the cwd  
dev.off()     
