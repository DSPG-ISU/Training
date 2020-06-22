# your turn - solution - grand slam
library(discreteRV)

#library(help=discreteRV)
D <- RV(c(1,0), probs = c(15/36, 21/36))

(wins <- SofIID(D, n=4, fractions = FALSE))
wins

E(wins)
