## This script creates 4 plots on the same picture in .png 
library(dplyr)

## read in from file and avoid factors!
elec <- read.csv("household_power_consumption.txt",header=TRUE, sep = ";",na.strings="?" , 
                 stringsAsFactors=FALSE)

## turn it into a table for use with dplyr 
elec <- tbl_df(elec)

## get rid of unwanted rows
elec <- filter(elec, as.Date(Date,"%d/%m/%Y") == as.Date("2/1/2007","%m/%d/%Y") |
                       as.Date(Date,"%d/%m/%Y") == as.Date("2/2/2007","%m/%d/%Y") )
## Set the dates right ad setup datetime variable
elec$Date <- as.Date(elec$Date,"%d/%m/%Y")
elec <- mutate(elec, dTime = as.POSIXct(paste(elec$Date, elec$Time), format="%Y-%m-%d %H:%M:%S"))
## Establish matrixed canvas and build each of the graphs
par(mfrow=c(2,2))
plot(elec$dTime, elec$Global_active_power,type="n", 
     xlab="",main="",ylab="Global Active Power (kilowatts)", cex.lab=0.7)
lines(elec$dTime, elec$Global_active_power, lty=1)

plot(elec$dTime, elec$Voltage, 
     xlab="datetime",main="",ylab="Voltage", type="n", cex.lab=0.7)
lines(elec$dTime, elec$Voltage, lty=1)

plot(elec$dTime, elec$Sub_metering_1, 
     xlab="",main="",ylab="Energy sub metering", type="n", cex.lab=0.7)
lines(elec$dTime, elec$Sub_metering_1, lty=1)
lines(elec$dTime, elec$Sub_metering_2, lty=1, col="red")
lines(elec$dTime, elec$Sub_metering_3, lty=1, col="blue")
legend("topright", lty=1, col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.4)

plot(elec$dTime, elec$Global_reactive_power,type="n", xlab="datetime", 
                        ylab="Global_reactive_power", cex.lab=0.7)
lines(elec$dTime, elec$Global_reactive_power, lty=1, cex=0.5)
##copy to .png
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
