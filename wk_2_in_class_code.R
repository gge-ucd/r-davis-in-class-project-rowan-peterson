weight_g <- c(50, 60, 65, 82)
weight_g
animals <- c("mouse", "rat", "dog")
animals
length(weight_g)
length(animals)
class(weight_g)
str(weight_g)
weight_g <- c(weight_g, 90) # add to the end of the vector
weight_g <- c(30, weight_g) # add to the beginning of the vector
weight_g
typeof(weight_g)
?typeof
num_char <- c(1, 2, 3, "a") #mixed num/char is character
class(num_char)
num_logical <- c(1, 2, 3, TRUE) #mixed num/logical is numeric
class(num_logical)
char_logical <- c("a", "b", "c", TRUE)
class(char_logical) #character
tricky <- c(1, 2, 3, "4")
class(tricky) #character
num_logical <- c(1, 2, 3, TRUE) #coerced to numeric
char_logical <- c("a", "b", "c", TRUE) #coerced to character
combined_logical <- c(num_logical, char_logical)  #all coerced to character
combined_logical

animals <- c("mouse", "rat", "dog", "cat")
animals[2]
animals[c(2,3)]
animals[c(1, 2, 3, 2, 1, 4)]

weight_g <- c(21, 34, 39, 54, 55)
weight_g[c(TRUE, FALSE, TRUE, TRUE, FALSE)] # could be read as "give me the first value, not the second value, etc."
weight_g[weight_g > 50]
weight_g[weight_g < 30 | weight_g > 50]

animals <- c("mouse", "rat", "dog", "cat")
animals[animals == "cat" | animals == "rat"] # returns both rat and cat
animals %in% c("rat", "cat", "dog", "duck", "goat")
animals[animals %in% c("rat", "cat", "dog", "duck", "goat")]

"four" > "five" ##why does this return TRUE?
class("four")
class("five")
as.numeric("five")

TRUE > "five"


a <-1 #object
letters #vector
vec <- c(3, 9,27)
vec
(vec <- c(3,9,27)) #make and print at once
vec[2]
vec[c(2,2)]
vec[c(3,2,1)]
vec <- c(vec, 81)
vec
vec.char <- c("I", "love", "Sleater", "Kinney")
vec.char
str(vec.char)
class(vec)
?data.frame
my_string <- c('dog', "walrus", "person", "cat")
data.frame(my_string)
data.frame(my_string)
df <- data.frame(animal = my_string, count = 1:4)

#lists: big catchall thing
?list
test_list <- list('something or other')
test_list
test_list[1]
test_list[[1]]
test_list <- c(test_list, 28)
test_list
test_list[[1]][2] <- "word"
test_list
test_list[[3]] <- df
test_list
str(test_list)
test_list[[3]][1]
