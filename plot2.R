library(sqldf)
library(lubridate)

# URL of the data file
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download the data file
download.file(url,destfile = "data.zip")

# Unzip the data file
unzip("data.zip",exdir = getwd(),unzip = "internal")

# Import the necessary data from the data file
DB <- file("household_power_consumption.txt")
df <- sqldf("select * from DB where Date == '1/2/2007' OR Date == '2/2/2007'",
            file.format = list(header = TRUE, sep = ";",na.strings="?"))
close(DB)

# Convert the Dtae column into date format
df$Date<-dmy(df$Date)

########################################### Main Part
df$dattime<-paste(df$Date, df$Time, sep=" ")
df$dattime<-strptime(df$dattime,"%Y-%m-%d %H:%M:%S")
png(file="plot2.png",width=480,height=480)
plot(df$dattime, df$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
###########################################
dev.off()
