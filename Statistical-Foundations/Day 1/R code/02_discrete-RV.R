library(discreteRV)

#library(help=discreteRV)
fair.coin <- RV(c("H", "T"), probs = 0.5)
fair.coin <- RV(c("1", "0"), probs = 0.5)

iid(fair.coin, 2)
iid(fair.coin, 2, fractions = FALSE)
iid(fair.coin, 3, fractions = FALSE)

(heads10 <- SofIID(fair.coin, 10, fractions = FALSE))

P(heads10 > 3)
