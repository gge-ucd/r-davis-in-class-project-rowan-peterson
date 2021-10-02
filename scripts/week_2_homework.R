set.seed(15)
(hw2 <- runif(50, 4, 50))  #generates 50 numbers between 4 and 50 following uniform distribution
(hw2 <- replace(hw2, c(4,12,22,27), NA)) #replaces values found at indices 4,12,22,27 of hw2 with NAs
hw2


hw2_na_logical <- is.na(hw2) 
hw2.na.remove <- hw2[hw2_na_logical==FALSE]
prob1 <- hw2.na.remove[14 <= hw2.na.remove & 38>= hw2.na.remove]
prob1

times3 <- 3*prob1
times3

plus10 <- times3 + 10
plus10

?seq
odds <- seq(from = 1, to = 23, by = 2)
odds

final <- plus10[odds]
final
