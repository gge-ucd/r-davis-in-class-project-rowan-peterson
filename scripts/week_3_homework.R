surveys <- read.csv('data/portal_data_joined.csv')
head(surveys, 1)
surveys_base <- surveys[1:60, c(5,6,9)]
head(surveys_base,2)

surveys_base$plot_id <- factor(surveys_base$plot_id)
surveys_base$species_id <- factor(surveys_base$species_id)

class(surveys_base$plot_id) #factor
typeof(surveys_base$plot_id) #integer
str(surveys_base$plot_id) #factor with one level
#factors are different from characters because they convert each unique character vector element
# to an integer labeled with that character--kind of like an integer where if you hover over it you get characters

surveys_base <- surveys_base[is.na(surveys_base$weight)==FALSE,]

challenge_base <- surveys_base[surveys_base$weight > 150, ]
challenge_base
