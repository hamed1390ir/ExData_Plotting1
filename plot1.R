library(sqldf)
library(lubridate)
rm(list=ls())
# URL of the data file
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download the data file
download.file(url,destfile = "data.zip", mode = )

# Unzip the data file
unzip("data.zip",exdir = getwd(),unzip = "internal")

# Import the necessary data from the data file
DB <- file("household_power_consumption.txt")
df <- sqldf("select * from DB where Date == '1/2/2007' OR Date == '2/2/2007'",
            file.format = list(header = TRUE, sep = ";"))
close(DB)

# Convert the Dtae column into date format
df$Date<-dmy(df$Date)

png(file="plot1.png",width=480,height=480)
hist(df$Global_active_power,
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency",
     col = "red",
     main = "Global Active Power")
dev.off()
