x <- rnorm(100)
eps1 <- rnorm(100)
eps2 <- runif(100)*abs(x) 
eps2 <- eps2 - mean(eps2)
eps3 <- runif(100)*(x-min(x))^2
eps3 <- eps3 - mean(eps3)

dframe <- data.frame(x, eps1/sd(eps1), eps2/sd(eps2), eps3/sd(eps3))
p1 <- dframe %>%
  ggplot(aes(x = x, y = eps1)) +
  geom_point() +
  theme_bw() +
  geom_hline(yintercept=0, colour = "steelblue")

p2 <- dframe %>%
  ggplot(aes(x = x, y = eps2)) +
  geom_point() +
  theme_bw() +
  geom_hline(yintercept=0, colour = "steelblue")

p3 <- dframe %>%
  ggplot(aes(x = x, y = eps3)) +
  geom_point() +
  theme_bw() +
  geom_hline(yintercept=0, colour = "steelblue")

(p <- gridExtra::grid.arrange(p1,p2,p3))

