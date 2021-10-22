##challenge myself to write a quartiles function to soft code the iris stuff

library(tidyverse)
surveys <- read_csv('data/portal_data_joined.csv')

##Problem 1
str(surveys)
#manipulate surveys to create a new dataframe called surveys_wide with a row for genus and a column named after every plot type, with each of these columns containing the mean hindfoot length of animals in that plot type and genus. So every row has a genus and then a mean hindfoot length value for every plot type. The dataframe should be sorted by values in the Control plot type column. This question will involve quite a few of the functions you’ve used so far, and it may be useful to sketch out the steps to get to the final result.
#step one: create a new data frame with just the three columns I'm interested in with the mean hindfoot length by genus
surveys <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(plot_type, genus) %>% 
  summarise(mean_hindfoot_length = mean(hindfoot_length))
head(surveys)  ##success!

surveys_wide <- pivot_wider(surveys, names_from = "plot_type", values_from = "mean_hindfoot_length")
surveys_wide   ##success!