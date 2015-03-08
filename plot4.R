library(dplyr)
library(tidyr)
library(lubridate)

setwd("~/dropbox/coursera")

df <- read.table(file = "household_power_consumption.txt", 
                 header = TRUE, 
                 sep = ";", 
                 na.strings = "?",
                 colClasses = c(rep("character", 2),
                                rep("numeric", 7)),
                 nrows = -1)

dfp <- df %>% 
        filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
        mutate(datetime = parse_date_time(paste(Date, Time), "dmy HMS")) %>%
        select(-Date, -Time) %>%
        filter(!is.na(Global_active_power))

# plot 4
png(filename = "plot4.png")
par(mfrow = c(2,2))
with (dfp, { plot(x = datetime,
                  y = Global_active_power,
                  type = "l",
                  xlab = "",
                  ylab = "Global Active Power")
             plot(x = datetime,
                  y = Voltage,
                  type = "l")
             plot(x = datetime, 
                  y = Sub_metering_1,
                  type = "n",
                  main = "",
                  xlab = "",
                  ylab = "Energy sub metering")
             lines(x = datetime, 
                   y = Sub_metering_1, 
                   type = "l", 
                   col = "black")
             lines(x = datetime, 
                   y = Sub_metering_2, 
                   type = "l", 
                   col = "red")
             lines(x = datetime, 
                   y = Sub_metering_3, 
                   type = "l", 
                   col = "blue")
             legend("topright", 
                    lwd = 1, 
                    bty = "n",
                    col = c("black", "red", "blue"), 
                    legend = c("Sub_metering_1", 
                               "Sub_metering_2", 
                               "Sub_metering_3"))
             plot(x = datetime,
                  y = Global_reactive_power,
                  type = "l")
             }
      )
dev.off()
