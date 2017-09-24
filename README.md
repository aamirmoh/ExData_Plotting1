## Introduction
Read 10 rows of data to understand the class of each variable in the file
Use of object.size function for the data read above provides a size of 4176 bytes for 10 rows, thus total memory = 826.5MB

I don;t want to read ~ 800MB of data into my RAM. So i wanted to grep the file to get the two dates i need. 
using readLines, i was able to load no more than 230MB of data.
readPowerFile <- readLines("household_power_consumption.txt")

Then used grep to find the starting row where the data existed. 
searchPowerFilefor01022007 <- grep("^1/2/2007", readPowerFile) #
startrow <- min(searchPowerFilefor01022007)
endrow   <- length(searchPowerFilefor01022007)
hhp_01022007 <- read.table("household_power_consumption.txt",header = FALSE,skip = startrow-1,nrows = endrow, sep = ";",colClasses = hhp_classes,na.strings = "?" )
#filter for 02022007
searchPowerFilefor02022007 <- grep("^2/2/2007", readPowerFile)
startrow <- min(searchPowerFilefor02022007)
endrow   <- length(searchPowerFilefor02022007)
hhp_02022007 <- read.table("household_power_consumption.txt",header = FALSE,skip = startrow -1,nrows = endrow, sep = ";",colClasses = hhp_classes,na.strings = "?" )

Use rbind to combine the two data sets. 
Clean out all other datasets, or dataframes in memory

use the lubridate library to convert date and time.

After that, the creation of basic plots can be found within the individual R files.



