install.packages("lubridate")
library(lubridate)
library(dplyr)
library(readr)

mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
head(mloa)
##removing missing values in rel_humid, temp_C_2m, and windSpeed_m_s
##time zone is UTC
mloa_complete <- mloa %>% 
  filter(rel_humid != -99) %>% 
  filter(temp_C_2m != -999.9) %>% 
  filter(windSpeed_m_s != -999.9) %>% 
  filter(windSpeed_m_s != -99.9)

summary(mloa_complete)

##paste function: combines character strings in R
##works on a single pair of objects, or set(s) of columns
##can turn a vector of character strings into a single character string
##sep= can set a separation character, default is space

mloa_working <- mloa_complete %>% 
  mutate(datetime = ymd_hm(paste(year,month,day,hour24,min, sep = '-')))

?with_tz
mloa_working <- mloa_working %>% 
  mutate(datetimeLocal = with_tz(datetime, tzone = "HST"))

mloa_working$datetime
mloa_working$datetimeLocal

?month
?hour

mloa_working %>% 
  group_by(month(datetimeLocal), hour(datetimeLocal)) %>% 
  summarise(meantemp = mean(temp_C_2m))

mloa_calcs <- mloa_working %>% 
  mutate(localhour = hour(datetimeLocal)) %>% 
  group_by(month(datetimeLocal), localhour) %>% 
  mutate(meantemp = mean(temp_C_2m))
mloa_calcs
mloa_calcs$meantemp

library(ggplot2)

ggplot(data = mloa_calcs, mapping = aes(x = month(datetimeLocal), y = meantemp)) +
  geom_point(aes(color = localhour)) +
  labs(x = "Month", y = "Mean temperature (degrees C)")

