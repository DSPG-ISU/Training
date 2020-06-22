set.seed(10111213)

y <- runif(1000, min = 0, max = 10)
summary(y)

qunif(c(0, 0.25, 0.5, 0.75, 1), min = 0, max = 10)
# mean and median are the same values in a symmetric
# density function