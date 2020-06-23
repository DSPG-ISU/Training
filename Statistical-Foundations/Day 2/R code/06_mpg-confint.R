library(ggplot2)

mpg <- mpg %>% mutate(
  displ_inv = 1/displ
)

mod <- lm(cty~displ_inv, data = mpg)
summary(mod)

confint(mod)
