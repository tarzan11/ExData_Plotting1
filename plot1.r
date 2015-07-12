## This script builds a histogram of Global Active Power and saves it to a .png
## I plan to always use dplyr for data manipulation!
library(dplyr)

## read in from file and avoid factors!
elec <- read.csv("household_power_consumption.txt",header=TRUE, sep = ";",na.strings="?" , stringsAsFactors=FALSE)

## turn it into a table for use with dplyr 
elec <- tbl_df(elec)

## get rid of unwanted rows
elec <- filter(elec, as.Date(Date,"%d/%m/%Y") == as.Date("2/1/2007","%m/%d/%Y") |
                       as.Date(Date,"%d/%m/%Y") == as.Date("2/2/2007","%m/%d/%Y") )

## Set the dates right
elec$Date <- as.Date(elec$Date,"%d/%m/%Y")

## Create a histogram
par(mar=c(5,5,5,5))
hist(elec$Global_active_power, col ="red", xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", xaxt="n")
axis(1, at=c(0,2,4,6), labels=c(0,2,4,6))
## Copy to .png
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()