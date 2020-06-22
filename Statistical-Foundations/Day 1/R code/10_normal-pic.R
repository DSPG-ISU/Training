library(tidyverse)
x <- seq(-4,4, by=0.05)

dframe <- data.frame(
x = c(-1.65, x, 1.65),
y = c(0, dnorm(x), 0),
type = c("poly", rep("line", 161), "poly")
)

dframe %>%
  ggplot(aes(x = x, y = y)) + 
  geom_hline(yintercept = 0, colour = "grey50") +
  geom_line(data = dframe %>% filter(type=="line"), colour = "grey50") +
  geom_polygon(aes(x = x, y = y), fill = "lightblue", colour = "lightblue",
               alpha = 0.5,
               data = dframe %>% filter(between(x, -1.65, 1.65))) + 
  geom_text(x = 0, y = 0.2, label="c", size = 10, colour = "lightblue") + 
  theme_bw() + 
  xlab("") +
  ylab("") +
  scale_x_continuous(breaks=c(-4,-2,-1.65, 0,1.65, 2,4), labels=c(-4,-2,"-t", 0,"+t",2,4),
                     minor_breaks = -3:3) 
