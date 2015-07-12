## This script build a three line plot of sub metering with a legend
library(dplyr)

## read in from file and avoid factors!
elec <- read.csv("household_power_consumption.txt",header=TRUE, sep = ";",na.strings="?" , stringsAsFactors=FALSE)

## turn it into a table for use with dplyr 
elec <- tbl_df(elec)

## get rid of unwanted rows
elec <- filter(elec, as.Date(Date,"%d/%m/%Y") == as.Date("2/1/2007","%m/%d/%Y") |
                     as.Date(Date,"%d/%m/%Y") == as.Date("2/2/2007","%m/%d/%Y") )

## Set the dates right and setup date time variable
elec$Date <- as.Date(elec$Date,"%d/%m/%Y")
elec <- mutate(elec, dTime = as.POSIXct(paste(elec$Date, elec$Time), format="%Y-%m-%d %H:%M:%S"))

## Build the plot
plot(elec$dTime, elec$Sub_metering_1, 
     xlab="",main="",ylab="Energy sub metering", type="n")
lines(elec$dTime, elec$Sub_metering_1, lty=1)
lines(elec$dTime, elec$Sub_metering_2, lty=1, col="red")
lines(elec$dTime, elec$Sub_metering_3, lty=1, col="blue")
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.5)
## Copy to .png
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
