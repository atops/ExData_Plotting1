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

# plot 3
png(filename = "plot3.png")
with(dfp, { plot(x = datetime, y = Sub_metering_1,
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
                  col = "blue") }
)
legend("topright", 
       lwd = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", 
                  "Sub_metering_3"))
dev.off()
