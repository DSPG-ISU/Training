crabs <- read.csv("http://ggobi.org/book/data/australian-crabs.csv")

library(GGally)
ggpairs(crabs %>% select(FL, RW, CL, CW))


m1 <- lm(RW~CL, data = crabs)

crabs$fitted <- fitted(m1)
crabs$resid <- resid(m1)

crabs %>%
  ggplot(aes(x = CL, y = resid)) + geom_point() +
  theme_bw()

crabs %>%
  ggplot(aes(x = CL, y = resid)) + geom_point(aes(colour = sex)) +
  theme_bw()


crabs %>%
  ggplot(aes(x = CL, y = resid)) + 
  geom_point(aes(colour = species)) +
  theme_bw()

m2 <- lm(RW ~ CL + sex, data = crabs)
summary(m2)

crabs$fitted <- fitted(m2)
crabs$resid <- resid(m2)

crabs %>%
  ggplot(aes(x = CL, y = resid)) + 
  geom_point(aes(colour = sex)) +
  theme_bw()

crabs %>%
  ggplot(aes(x = CL, y = RW)) + 
  geom_point(aes(colour = sex)) +
  theme_bw()


####
m3 <- lm(RW ~ CL * sex, data = crabs)
summary(m3)

crabs$fitted <- fitted(m3)
crabs$resid <- resid(m3)

crabs %>%
  ggplot(aes(x = CL, y = resid)) + 
  geom_point(aes(colour = sex)) +
  theme_bw()

####
m3b <- lm(RW ~ sex + CL:sex, data = crabs)
summary(m3b)

summary(fitted(m3)-fitted(m3b))

crabs$fitted <- fitted(m3b)
crabs$resid <- resid(m3b)

crabs %>%
  ggplot(aes(x = CL, y = resid)) + 
  geom_point(aes(colour = sex)) +
  theme_bw()
