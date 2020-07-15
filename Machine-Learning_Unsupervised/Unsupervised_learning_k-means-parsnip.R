# Portion of the code is from: https://www.tidymodels.org/learn/statistics/k-means/

# 1.0 INTRODUCTION ----
# To use the code in this article, you will need to install the following packages: tidymodels and tidyr.
# K-means clustering serves as a useful example of applying tidy data principles to statistical analysis, and especially the distinction between the three tidying functions:
# tidy()
# augment()
# glance()

# Let’s start by generating some random two-dimensional data with three clusters. Data in each cluster will come from a multivariate gaussian distribution, with different means for each cluster:

#update R
install.packages(c("tidymodels", "tidyr"))

# Core packages
library(tidymodels)
library(tidyr)

# 2.0 Data Setup ----
set.seed(27)

centers <- tibble(
  cluster = factor(1:3), 
  num_points = c(100, 150, 50),  # number points in each cluster
  x1 = c(5, 0, -3),              # x1 coordinate of cluster center
  x2 = c(-1, 1, -2)              # x2 coordinate of cluster center
)

labelled_points <- 
  centers %>%
  mutate(
    x1 = map2(num_points, x1, rnorm),
    x2 = map2(num_points, x2, rnorm)
  ) %>% 
  select(-num_points) %>% 
  unnest(cols = c(x1, x2))

# 3.0 Plot Data ----
ggplot(labelled_points, aes(x1, x2, color = cluster)) +
  geom_point(alpha = 0.3)

