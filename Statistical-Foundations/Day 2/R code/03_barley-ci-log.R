library(tidyverse)
data(barley, package="lattice")

b31 <- barley %>%
  filter(year==1931) 

b31$lyield <- log(b31$yield)

b31 %>%
  ggplot(aes(x = lyield)) + 
  geom_dotplot(binwidth=.1, fill="skyblue", colour = "skyblue", alpha = 0.8) +
  theme_bw()

mu <- mean(b31$lyield)
s <- sd(b31$lyield)
t <- qt(.975, 59)

mu + c(-1,1)*t*s/sqrt(60)
exp(mu + c(-1,1)*t*s/sqrt(60))
