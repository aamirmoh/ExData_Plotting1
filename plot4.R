#Read 10 rows to get data in
hhp <- read.table("household_power_consumption.txt",header = T, sep = ";",nrows = 10,na.strings = "?" )
objSize <- object.size(hhp)
totalMemoryinMB <- objSize*2075259/(10*1024*1024)


#speed up the load by supplying classes
hhp_classes <-sapply(hhp,class)

#read File using Grep
readPowerFile <- readLines("household_power_consumption.txt")
#filter for 01022007
searchPowerFilefor01022007 <- grep("^1/2/2007", readPowerFile) #
startrow <- min(searchPowerFilefor01022007)
endrow   <- length(searchPowerFilefor01022007)
hhp_01022007 <- read.table("household_power_consumption.txt",header = FALSE,skip = startrow-1,nrows = endrow, sep = ";",colClasses = hhp_classes,na.strings = "?" )
#filter for 02022007
searchPowerFilefor02022007 <- grep("^2/2/2007", readPowerFile)
startrow <- min(searchPowerFilefor02022007)
endrow   <- length(searchPowerFilefor02022007)
hhp_02022007 <- read.table("household_power_consumption.txt",header = FALSE,skip = startrow -1,nrows = endrow, sep = ";",colClasses = hhp_classes,na.strings = "?" )

hhp_all <- rbind(hhp_01022007,hhp_02022007)
colnames(hhp_all) <- colnames(hhp)


#Perform housekeeping
rm(list = c("hhp","hhp_01022007","hhp_02022007"))

#Date Cleanup
library(lubridate)
hhp_all$Date <- dmy_hms(paste(hhp_all$Date,hhp_all$Time, sep=" ", collapse = NULL))

#hhp_all$Date <- as.Date(hhp_all$Date,"%d/%m/%Y")

#start graphics device
#png(filename = "plot1.png",width = 480, height = 480, units = "px")
#hist(hhp_all$Global_active_power, col = "red", main = "Global Active Power",xlab = "Global Active Power (kilowatts)" )
#dev.off()


#generic X-Y Plot
#png(filename = "plot2.png",width = 480, height = 480, units = "px")
#plot(hhp_all$Global_active_power~hhp_all$Date,type="l", ylab = "Global Active Power (kilowatts)", xlab="")
#dev.off()

#png(filename = "plot3.png",width = 480, height = 480, units = "px")
#plot(hhp_all$Sub_metering_1 ~hhp_all$Date,type="l",col="black" ,ylab = "Energy sub metering", xlab="")
#lines(hhp_all$Sub_metering_2 ~hhp_all$Date,col="red")
#lines(hhp_all$Sub_metering_3 ~hhp_all$Date,col="blue")
#legend("topright",pch = "-" ,col = c("black", "blue", "red"), legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), xjust = 1)
#dev.off()

#Split plot in 2 x 2 Matrix
png(filename = "plot4.png",width = 480, height = 480, units = "px")
par(mfrow= c(2,2))
#plot1
plot(hhp_all$Global_active_power~hhp_all$Date,type="l", ylab = "Global Active Power", xlab="")
#plot2
plot(hhp_all$Voltage~hhp_all$Date,type="l", ylab = "Voltage", xlab="datetime")
#plot3
plot(hhp_all$Sub_metering_1 ~hhp_all$Date,type="l",col="black" ,ylab = "Energy sub metering", xlab="")
lines(hhp_all$Sub_metering_2 ~hhp_all$Date,col="red")
lines(hhp_all$Sub_metering_3 ~hhp_all$Date,col="blue")
legend("topright",pch = "-" ,col = c("black", "blue", "red"), legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), xjust = 1, box.lty = 0)
#plot4
plot(hhp_all$Global_reactive_power~hhp_all$Date,type="l", ylab = "Global_reactive_power", xlab="datetime")
legend(pt.cex = 0.1)
dev.off()















