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
  group_by(date_dmy, carrier) %>% 
  mutate(meandelay = mean(dep_delay)) %>% 
  ungroup()
alldata1

alldata_septhrudec <- alldata1 %>% 
  filter(month.x >= 9 & month.x <= 12 )

ggplot(data = alldata_septhrudec, mapping = aes(x = date_dmy, y = meandelay)) +
  geom_point(aes(color = carrier))

ggsave(filename = "mean_delay_by_carrier_sep_dec.pdf", path = "plots")

##Part 3: Create a dataframe with these columns: date (year, month and day), mean_temp, where each row represents the airport, based on airport code. Save this as a new csv into your data folder called mean_temp_by_origin.csv

alldata_complete_date_temp_airport <- alldata_completedates %>% 
  filter(!is.na(temp) & !is.na(origin.x))
alldata_complete_date_temp_airport$ymdpaste <- paste(alldata_complete_date_temp_airport$year.x, alldata_complete_date_temp_airport$month.x, alldata_complete_date_temp_airport$day.x, sep = " ")

alldata2 <- alldata_complete_date_temp_airport %>% 
  mutate(date_ymd = ymd(ymdpaste))
class(alldata2$date_ymd)  
alldata2 <- alldata2 %>% 
  group_by(date_ymd, origin.x) %>% 
  mutate(mean_temp = mean(temp)) %>% 
  ungroup()
View(alldata2)  

##select just relevant columns
ymd_origin_mean_temp <- alldata2 %>% 
  group_by(origin.x, date_ymd) %>% 
  summarise(mean_temp = mean(temp))
ymd_origin_mean_temp
wide_origin_meantemp <- pivot_wider(ymd_origin_mean_temp, names_from = date_ymd, values_from = mean_temp)
write_csv(wide_origin_meantemp, file = "data/wide_origin_meantemp.csv")

##Part 4: minute/hour conversion function
m_h_conv <- function(x, start_with_minute = TRUE) {
  v <- rep(NA, length(x))
  if(start_with_minute == TRUE) {
    v <- x/60}
  else {
    v <- x*60
  }
  v}

save(m_h_conv, file = "scripts/customfunctions.R")

##boxplot of departure delays by carrier, in hours, add mean and median also (for improving the graph)

data_hours <- alldata %>% 
  filter(!is.na(dep_delay) & !is.na(carrier)) %>% 
  mutate(hr_delay = m_h_conv(dep_delay)) %>% 
  group_by(carrier) %>% 
  mutate(mean_delay = mean(hr_delay)) %>% 
  mutate(med_delay = median(hr_delay))

##Part 5: improving a graph
##starting with:
ggplot(data_hours, mapping = aes(x = hr_delay, y = carrier, fill = carrier)) +
  geom_boxplot()
##1: change scale of y axis
##changing the scale only removes <.4% of the data, can still see the trends

ggplot(data_hours, mapping = aes(x = carrier, y = hr_delay, fill = carrier)) +
  geom_boxplot() +
  ylim(-0.5, 6)
##2: reorder by median delay of each carrier
ggplot(data_hours, mapping = aes(x = reorder(carrier, med_delay), y = hr_delay, fill = carrier)) +
  geom_boxplot() +
  ylim(-0.5, 6)
##3. remove lines
ggplot(data_hours, mapping = aes(x = reorder(carrier, med_delay), y = hr_delay, fill = carrier)) +
  geom_boxplot() +
  ylim(-0.5, 4) +
  theme_classic()

##4. adjust transparency
ggplot(data_hours, mapping = aes(x = reorder(carrier, med_delay), y = hr_delay, fill = carrier)) +
  geom_boxplot(alpha = 0.25) +
  ylim(-0.5, 4) +
  theme_classic()

##5. change axis labels
ggplot(data_hours, mapping = aes(x = reorder(carrier, med_delay), y = hr_delay, fill = carrier)) +
  geom_boxplot(alpha = 0.25) +
  ylim(-0.5, 4) +
  theme_classic()+
  labs( x = "Carrier",
        y = "Delay (hours)",
        title = "Delay by Carrier",
        color = "Carrier")

