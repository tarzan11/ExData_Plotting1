## This script creates line plot of the Gobal Active Power and saves it to .png
library(dplyr)

## read in from file and avoid factors!
elec <- read.csv("household_power_consumption.txt",header=TRUE, sep = ";",na.strings="?" , stringsAsFactors=FALSE)

## turn it into a table for use with dplyr 
elec <- tbl_df(elec)

## get rid of unwanted rows
elec <- filter(elec, as.Date(Date,"%d/%m/%Y") == as.Date("2/1/2007","%m/%d/%Y") |
                       as.Date(Date,"%d/%m/%Y") == as.Date("2/2/2007","%m/%d/%Y") )

## Set the dates right and a setup a new date time variable
elec$Date <- as.Date(elec$Date,"%d/%m/%Y")
elec <- mutate(elec, dTime = as.POSIXct(paste(elec$Date, elec$Time), format="%Y-%m-%d %H:%M:%S"))

## Build the plot
par(mar=c(5,5,5,5))
plot(elec$dTime, elec$Global_active_power,type="n", 
          xlab="",main="",ylab="Global Active Power (kilowatts)")
lines(elec$dTime, elec$Global_active_power, lty=1)
##copy to .png
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()