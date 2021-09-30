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
