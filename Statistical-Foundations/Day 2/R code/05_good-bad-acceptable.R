x <- rnorm(100)
y1 <- -2*x + 1
y2 <- rnorm(100)
y3 <- 2*y2-y1

dframe <- data.frame(x, y1, y2, y3)
p1 <- dframe %>%
  ggplot(aes(x = x, y = y1)) +
  geom_point() +
  theme_bw()

p2 <- dframe %>%
  ggplot(aes(x = x, y = y2)) +
  geom_point() +
  theme_bw()

p3 <- dframe %>%
  ggplot(aes(x = x, y = y3)) +
  geom_point() +
  theme_bw()

(p <- gridExtra::grid.arrange(p1,p2,p3))

