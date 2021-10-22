##Conditional statements
##ifelse function

library(tidyverse)
##also case_when function

surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_cat = case_when(weight > mean(weight) ~ "big", 
                                weight < mean(weight) ~ "small")) %>%  ##tilde means then
  select(weight, weight_cat) 

#Using the iris data frame (this is built in to R), create a new variable that categorizes petal length into three groups:

#small (less than or equal to the 1st quartile)
#medium (between the 1st and 3rd quartiles)
#large (greater than or equal to the 3rd quartile)

#Hint: Explore the iris data using summary(iris$Petal.Length), to see the petal length distribution. Then use your function of choice: ifelse() or case_when() to make a new variable named petal.length.cat based on the conditions listed above. Note that in the iris data frame there are no NAs, so we don’t have to deal with them here
data(iris)
iris
str(summary(iris$Petal.Length))
##using case_when
iris %>% 
  mutate(petal_length_cat = case_when(Petal.Length <=1.6 ~ "small",
                                      Petal.Length > 1.6 & Petal.Length < 5.1 ~ "medium",
                                      Petal.Length >= 5.1 ~ "large"))
?summary
##using nested ifelse
iris %>% 
  mutate(petal.length.cat = ifelse(Petal.Length <= 1.6, "small", 
                                   ifelse(Petal.Length >= 5.1, "large", "medium")))

##joins
##left, right, inner, full
?join
tails <- read_csv('data/tail_length.csv')
head(tails)
intersect(colnames(surveys), colnames(tails)) ##shows whether there's a variable to merge on
surveys_joined <- left_join(surveys, tails, "record_id")
surveys_joined

surveys_joined_r <- right_join(surveys, tails, "record_id") ##identical result to above
surveys_joined_r

##pivots
##we want number of observations by year by plot id
temp_df <- surveys %>% 
  group_by(year, plot_id) %>% tally()  ##tally is just the n function in a pipe
temp_df
pivot_wider(temp_df, names_from = "year", values_from = "n")
##ungroup is also a function
genera_per_plot <-  surveys %>% 
  group_by(year, plot_id) %>% 
  summarize(number_genera = length(unique(genus)))
##or
gen_per_plot2 <- surveys %>% 
  group_by(year, plot_id) %>% 
  summarize(number_genera = n_distinct(genus))
gen_per_plot2
surveys_wide <- pivot_wider(gen_per_plot2, names_from = "year", values_from = "number_genera")
surveys_wide
