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



##writing functions
library(tidyverse)
install.packages("gapminder")
library(gapminder)

avgGDP <- function(cntry, yr.range){
  gapminder %>%
    filter(country == cntry, year %in% yr.range) %>%
    summarize(avgGDP = mean(gdpPercap, na.rm = T))
}

unique(gapminder$country)[1:10]

##for loops
for(i in 1:10){
  print(i)
}

for (i in unique(gapminder$country)[1:10]) {
  print(avgGDP(cntry = 1, yr.range = 1985:1990))
}

for(i in unique(gapminder$country)[1:10]){
  output <- avgGDP(i, yr.range = 1985:1990)
}
output
##just has one loop because of passby values, keeps getting overwritten
output <- list()
for(i in unique(gapminder$country)[1:10]){
  output[i] <- avgGDP(i, yr.range = 1985:1990)
}
output

time_series_pop_plot <- function(data = gapminder, c){
  dataframe <- data %>% filter(country == c) %>% select(country, year, pop)
  ggplot(data = dataframe, mapping= aes(x = dataframe$year, y = dataframe$pop)) +
  geom_point()  
}
time_series_pop_plot(gapminder, "Sweden")
gapminder %>% filter(country=="Sweden") %>% group_by(year, pop)
ggplot(data = )