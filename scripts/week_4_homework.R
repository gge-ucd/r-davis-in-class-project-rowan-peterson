surveys <- read_csv('data/portal_data_joined.csv')

#Problem 2

surveys %>% 
  filter(weight > 30 & weight < 60)


#Problem 3
biggest_critters <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarise(max_weight = max(weight))

biggest_critters %>%    ##sorted in ascending order of max_weight
  arrange(max_weight)

biggest_critters %>% 
  arrange(desc(max_weight)) ##sorted in descending order

#Problem 4: figuring out where NA values are concentrated
surveys %>% 
  filter(is.na(weight)) %>%    
  group_by(species_id) %>% 
  tally() %>% 
  arrange(desc(n))
##this found the species ids with the most NA values: AH, DM, AB, SS...
surveys %>% 
  filter(is.na(weight)) %>%    
  group_by(plot_id) %>% 
  tally() %>% 
  arrange(desc(n))
##this found the plot ids with the most NA values: plots 13-15, 20, 12, and 17 all had a lot
surveys %>% 
  filter(is.na(weight)) %>%    
  group_by(genus) %>% 
  tally() %>% 
  arrange(desc(n))
##this found the genera with the most NA values: Dipodomys and Ammospermophilus

##Problem 5
surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(mean_weight_by_species_sex = mean(weight)) %>% 
  select(species_id, sex, weight, mean_weight_by_species_sex)
surveys_avg_weight

##Problem 6
surveys_avg_weight <- surveys_avg_weight %>% 
  mutate(above_average = weight > mean_weight_by_species_sex)
