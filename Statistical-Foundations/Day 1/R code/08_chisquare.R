if (!require(classdata)) {
  devtools::install_github("heike/classdata")
}


library(classdata)
library(tidyverse)

happy16 <- happy %>% dplyr::filter(year==2016)
with(happy16 %>% select(sex, happy) %>% na.omit(), chisq.test(sex, happy))

dframe <- happy16 %>% 
  mutate(age60 = age < 60) %>%
  select(age60, happy) %>% na.omit()

with(dframe, chisq.test(age60, happy))
xtabs(data = dframe, ~happy+age60)

# visualize: install ggmosaic first
#happy16 %>% mutate(age45 = age<60) %>% ggplot() + ggmosaic::geom_mosaic(aes(x = product(happy,  age45), weight=n))
