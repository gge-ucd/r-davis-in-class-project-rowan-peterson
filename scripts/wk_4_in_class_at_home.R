library(tidyverse)
surveys_t <- read_csv('data/portal_data_joined.csv')
surveys_t
class(surveys_t)
?select
select(surveys_t, record_id, species_id, weight) #select is used for rows

filter(surveys_t, species_id == "NL") #filter is used for columns

surveys2 <- filter(surveys_t, weight < 5)
surveys2
surveys_sml <- select(surveys2, species_id, sex, weight)
surveys_sml
surveys_sml <- select(filter(surveys, weight < 5), species_id, sex, weight)
surveys_sml

## %>% is called a pipe, it takes the result of the expression on the left
##and passes it as the first argument for the function to the right
##ctrl-shift-m gets the pipe symbol
surveys_t %>% filter(weight < 5) %>% select(species_id, sex, weight)
surveys_sml2 <- surveys_t %>% filter(weight < 5) %>% select(species_id, sex, weight)

##will break code if you put the thing from the pipe in redundantly
surveys_t %>% filter(surveys_t, weight < 5) %>% select(species_id, sex, weight) #returns an error

##challenge
surveys_challenge <- surveys_t %>% filter(year < 1995) %>% select(year, sex, weight)
surveys_challenge
surveys_challenge2 <- surveys_t %>% filter(year < 1995) %>% select(species_id, sex, weight)
surveys_challenge2

## mutate() creates a new column based on values in existing columns
surveys_t %>%
  mutate(weight_kg = weight / 1000)
surveys_t %>%    ##can make two new columns, one based on the other, in same call
  mutate(weight_kg = weight / 1000,
         weight_kg2 = weight_kg * 2)
surveys_t %>%
  mutate(weight_kg = weight / 1000) %>%
  head()

surveys_t %>% filter(!is.na(weight)) %>% mutate(weight_kg = weight / 1000) %>% head()

##challenge 2
surveys_hindfoot_half <- surveys_t %>%
   mutate(hindfoot_half = hindfoot_length / 2) %>%
   filter(!is.na(hindfoot_half) & hindfoot_half < 30) %>% 
   select(species_id, hindfoot_half)
surveys_hindfoot_half

surveys_t %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

surveys_t %>%
  group_by(species_id, sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

surveys_t %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarise(mean_weight = mean(weight)) %>% 
  print(n = 15)

surveys_t %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            min_weight = min(weight))

##challenge1
surveys_t %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(species_id) %>% 
  summarize(mean_hindfoot = mean(hindfoot_length),
            min_hindfoot = min(hindfoot_length),
            max_hindfoot = max(hindfoot_length))

##challenge2
surveys_t %>% 
  filter(!is.na(weight)) %>% 
  group_by(year) %>% 
  filter(weight == max(weight)) %>% 
  select(year, genus, species, weight) %>% 
  arrange(year) %>% 
  view(n=27)

?arrange ##arranges by value of a given column
?n ##gives current group size within context of summarize, mutate...

##challenge3
##number of indivs of each sex using group_by and tally
surveys_t %>% 
  filter(!is.na(sex)) %>% 
  group_by(sex) %>% 
  tally()

#same task using group_by and summarize
surveys_t %>% 
  filter(!is.na(sex)) %>% 
  group_by(sex) %>% 
  summarize(number_sex = n())
