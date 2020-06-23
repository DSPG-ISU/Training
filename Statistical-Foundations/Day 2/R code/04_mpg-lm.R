library(ggplot2)

mpg %>%
  ggplot(aes(x = displ, y = cty)) +
  geom_point() +
  theme_bw()


mpg %>%
  ggplot(aes(x = displ, y = cty)) +
  geom_point() +
  theme_bw() +
  geom_smooth()

mpg %>%
  ggplot(aes(x = 1/displ, y = cty)) +
  geom_point() +
  theme_bw()

mpg %>%
  ggplot(aes(x = 1/displ, y = cty)) +
  geom_point() +
  theme_bw() +
  geom_smooth()


m0 <- lm(cty~I(1/displ), data = mpg)

mpg %>%
  mutate(pred = predict(m0)) %>%
  ggplot(aes(x = 1/displ, y = cty)) +
  theme_bw() +
  geom_smooth(method="lm", se=FALSE, colour = "steelblue") +
  geom_segment(aes(x = 1/displ, xend=1/displ, y = pred, yend=cty), size = 0.15, colour = "steelblue") +
  geom_point()


mpg <- mpg %>% mutate(
  displ_inv = 1/displ
)

mod <- lm(cty~displ_inv, data = mpg)
summary(mod)

mpg$fitted <- fitted(mod)


mpg %>%
  ggplot(aes(x = displ, y = cty)) +
  theme_bw() +
  geom_point() +
  geom_line(aes(y = fitted), colour = "steelblue", size = 1)

