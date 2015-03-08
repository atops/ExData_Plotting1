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

# plot 1
png(filename = "plot1.png")
hist(dfp$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red")
dev.off()
