library(tidyverse)

flights <- read_csv('https://gge-ucd.github.io/R-DAVIS/data/nyc_13_flights_small.csv')
planes <- read_csv('https://gge-ucd.github.io/R-DAVIS/data/nyc_13_planes.csv')
weather <- read_csv('https://gge-ucd.github.io/R-DAVIS/data/nyc_13_weather.csv')

str(flights)
str(planes)
str(weather)


planes_flights <- full_join(flights, planes, by = "tailnum")
View(planes_flights)

alldata <- full_join(planes_flights, weather, by = "time_hour")
View(alldata)
summary(alldata$precip)
summary(alldata$dep_delay)
##Part 1: plotting departure delay against precipitation

alldata %>% 
  filter(is.na(precip)==FALSE) %>% 
  filter(is.na(dep_delay)==FALSE) %>% 
  ggplot(mapping = aes(x = precip, y = dep_delay)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = lm) ##adds a trend line, linear model
  
ggsave(filename = "precipvsdelay.pdf", path = "plots") 

##Part 2: Create a figure that has date on the x axis and each day’s mean departure delay on the y axis. Plot only months September through December. Somehow distinguish between airline carriers (the method is up to you). Again, save your final product into the “plot” folder.

##create a column with day month year date formats
summary(alldata$day.x)
##make a day month year column
alldata_completedates <- alldata %>% 
  filter(!is.na(year.x) & !is.na(month.x) & !is.na(day.x))
summary(alldata_completedates$day.x)
alldata_completedates$dmypaste <- paste(alldata_completedates$day.x, alldata_completedates$month.x, alldata_completedates$year.x, sep = " ")
class(alldata_completedates$dmypaste)
alldata_completedates$dmypaste
library(lubridate)
alldata1 <- alldata_completedates %>% 
  mutate(date_dmy = dmy(dmypaste))
class(alldata1$date_dmy)  

alldata1 <- alldata1 %>% 
  filter(!is.na(dep_delay)) %>% 
  group_by(date_dmy) %>% 
  mutate(meandelay = mean(dep_delay)) %>% 
  ungroup()
alldata1

alldata_septhrudec <- alldata1 %>% 
  filter(month.x >= 9 & month.x <= 12 )
