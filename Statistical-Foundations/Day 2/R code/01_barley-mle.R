library(tidyverse)
data(barley, package="lattice")

b31 <- barley %>%
  filter(year==1931) 
b31 %>%
  ggplot(aes(x = yield)) + 
  geom_dotplot(binwidth=2, colour = "lightblue", fill="lightblue", alpha = 0.8) +
  theme_bw() +
  ylim(c(0,10))


library(gganimate)
# likelihood function:
likelihood <- function(mu, sigma, x) {
  prod(dnorm(x, mean=mu, sd = sigma))
}

# guess sigma to be 10
dframe <- data.frame(
  mus = seq(min(b31$yield), max(b31$yield), by = 0.1),
  Ls = sapply(mus, FUN=likelihood, sigma = 10, x = b31$yield)
)
p <- dframe %>% 
  ggplot(aes(x = mus, y = Ls)) +
  geom_line() +
  theme_bw() +
  theme(axis.text.y = element_blank()) +
  ylab("Likelihood") +
  xlab("Different values for mu") + 
  transition_reveal(along=mus)
animate(p, height = 461, width = 644)

