
library(tidyverse)
surveys <- read_csv('data/portal_data_joined.csv')

##Problem 1
str(surveys)
#step one: create a new data frame with just the three columns I'm interested in with the mean hindfoot length by genus
surveys2 <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(plot_type, genus) %>% 
  summarise(mean_hindfoot_length = mean(hindfoot_length))
head(surveys2)  ##success!

surveys_wide <- pivot_wider(surveys2, names_from = "plot_type", values_from = "mean_hindfoot_length")
surveys_wide   ##success!

##Problem 2
summary(surveys$weight)
##using ifelse
surveys3 <- surveys %>% 
   mutate(weight_cat = ifelse(weight <= 20, "small", 
                              ifelse(weight >= 48, "large", "medium")))
  
view(surveys3)  ##if weight is NA, the ifelse function automatically makes weight_cat NA

##using case_when
surveys4 <- surveys %>% 
  mutate(weight_cat = case_when(weight <= 20 ~ "small",
                                weight > 20 & weight < 48 ~ "medium",
                                weight >= 48 ~ "large"))
view(surveys4) ##case_when also automatically made weight_cat NA

surveys5 <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_cat = case_when(weight <= 20 ~ "small",
                                weight > 20 & weight < 48 ~ "medium",
                                weight >= 48 ~ "large"))
view(surveys5)
##write a quartiles function to soft code if time