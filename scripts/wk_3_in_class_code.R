install.packages('tidyverse')
 surveys <- read.csv('data/portal_data_joined.csv') #read in a spreadsheet

 head(surveys) 
class(surveys)  #data frame 
nrow(surveys) #34786 rows
ncol(surveys) #13
str(surveys)
class(surveys$genus)
class(surveys$species)
summary(surveys)

length(unique(surveys$species_id)) #get number of unique species
head(surveys, 2) #just first two rows

surveys[1,2] #row 1 col 2

length(unique(surveys$species))
table(surveys$species) #counts up number of each unique species
sum(!duplicated(surveys$species))

#levels as a way to identify unique characters
levels(surveys$species)

#always set characters as factors equal to false when reading in data

species_factor <- factor(surveys$species)
typeof(species_factor)
class(species_factor)
levels(species_factor)

surveys_200 <- surveys[200,]
surveys_200

surveys_last <- surveys[nrow(surveys),]
surveys_last

tail(surveys, 1)

surveys_middle <- surveys[nrow(surveys)/2,]
surveys_middle

head_surveys <- surveys[-(7:nrow(surveys)),]
head_surveys
head(surveys)
