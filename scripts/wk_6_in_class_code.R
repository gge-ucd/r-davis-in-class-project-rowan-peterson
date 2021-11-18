library(tidyverse)
surveys <- read_csv('data/portal_data_joined.csv')

surveys <- surveys %>% 
  filter(complete.cases(.))
view(surveys)
##just specifying data starts with a blank canvas
ggplot(data = surveys)
## can use surveys$ in front of variables but not required
##results in a blank canvas with axes
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length))
##add in geom for shape

##+ adds on a layer
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

##can save layers as objects
base_plot <- ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length))
base_plot + geom_point()

##adding plot elements: changing transparency = alpha, color = color, outline = 
  base_plot + geom_point(alpha= 0.2) ##adjust transparency
  
  base_plot + geom_point(color = 'blue')
  
  ##can combine
  
  base_plot + geom_point(color = 'red', alpha = 0.5)

  ## color by categorical
  
  ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point(mapping = aes(color = species_id))

  ##geom_boxplot
ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot()
 

base_plot2 <- ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) 

base_plot2 +
  geom_boxplot(color = 'purple') +
  geom_point()

base_plot2 +
  geom_boxplot() +
  geom_jitter(alpha = 0.2, mapping = aes(color = species_id))

  
##mapping, data, geom
##Use what you just learned to create a scatter plot of weight and species_id with weight on the Y-axis, and species_id on the X-axis. Have the colors be coded by plot_type. Is this a good way to show this type of data? What might be a better graph?
ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_point(mapping = aes(color = plot_type), alpha = .5)

##not a great way to show this  
  ##jitter isn't that much better tho
ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(mapping = aes(color = plot_type))

  
ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_(mapping = aes(color = plot_type))
 
  
ggplot(data = surveys, mapping = aes(x = plot_type, y = weight)) +
  geom_point(mapping = aes(color = species_id), alpha = .5)

  
##plot types as panels
ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_point() +
  facet_wrap(~plot_type)
  
  
##themes
ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_point(mapping = aes(color = plot_type), alpha = .5) +
  theme_classic()
  
ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot() +
  geom_jitter(mapping = aes(color = plot_type), alpha = 0.2)

base_plot_sp_weight <- ggplot(data = surveys, mapping = aes(x = species_id, y = weight))  
base_plot_sp_weight + 
  geom_violin()

?scale_y_log10
  
ggplot(data = surveys, mapping = aes(x = plot_type, y = weight)) +
  geom_point(mapping = aes(color = species_id), alpha = .5)

base_plot_sp_weight + 
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_violin(alpha = 0) +
  scale_y_log10()
##this is a lot easier to read!

hindfoot_survey <- surveys %>% 
  filter(species_id == "NL" | species_id == "PF") %>% 
  select(species_id, hindfoot_length, plot_id)
hindfoot_survey  
hindfoot_survey$plot_factor <- as.factor(hindfoot_survey$plot_id)
ggplot(data = hindfoot_survey, mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot() +
  geom_jitter(mapping = aes(color = plot_factor), alpha = 0.3) 
##doing it directly 
surveys %>% 
  filter(species_id == "NL" | species_id == "PF") %>% 
  select(species_id, hindfoot_length, plot_id) %>% 
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(mapping = aes(color = as.factor(plot_id)), alpha = 0.3) +
  labs( x = "Species ID",
        y = "Hindfoot length",
        title = "Boxplot",
        color = "Plot ID") +
  theme_classic() +
  theme(axis.title.x = element_text(angle = 45))

##don't save .RData files


##can do the conversion to factor included in the above one-step using mutate
  
yearly_count <- surveys %>% 
  count(year, species_id)
yearly_count
ggplot(data = yearly_count, mapping = aes(x = year, y = n, group = species_id)) +
  geom_line(aes(color = species_id))

##or
ggplot(data = yearly_count, mapping = aes(x = year, y = n, color = species_id)) +
  geom_line()

##faceting
ggplot(data = yearly_count, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id)

##challenge
mystery <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mysteryData.csv")
spec(mystery)
head(mystery)
ggplot(data = mystery, mapping = aes(x = x, y = y)) +
  geom_point(alpha = 0.01, size = 0.1) +
  facet_wrap(~ Group) +
  coord_equal()
##they're cute little animals!

##challenge
#Let’s make one final change to our facet wrapped plot of our yearly count data. What if we wanted to split the counts of species up by sex where the lines for each sex are different colors? Make sure you have a nice theme on your graph too!
  
 # Hint Make a new dataframe using the count function we learned earlier!

