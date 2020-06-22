library(tidyverse)
#install_github("ropenscilabs/ochRe")
library(ochRe)

# National Survey on Drug Use and Health 
NSDUH <- data.frame(
region = c("central", "north central", "northeast", "northwest",
              "southeast", "southwest"),
alcohol = c(61.26, 54.1, 59.82, 50.81, 53.49, 52.27),
binge = c(26.29, 27.44, 31.76, 25.4, 26.43, 26.28),
perc_binge = c(39.36, 36.86, 33.96, 37.23, 35.6, 39)
)

NSDUH %>% 
  ggplot(aes(x = alcohol, y = binge, colour = region)) +
  geom_point() +
  ggrepel::geom_text_repel(aes(label=region), nudge_y=0.3, min.segment.length = 0.7) +
  theme_bw() +
  theme(legend.position = "none") +
  scale_color_ochre(palette = "tasmania") +
  xlab("Alcohol Use in Past Month") +
  ylab("Binge Alcohol Use in Past Month") +
  coord_equal() 
#  geom_smooth(aes(group=1), method="lm", colour = "darkblue", se=FALSE, linewidth = 1)

NSDUH %>% 
  ggplot(aes(x = perc_binge, y = binge, colour = region)) +
  geom_point() +
  ggrepel::geom_text_repel(aes(label=region), nudge_y = .2, min.segment.length = 0.7)  +
  theme_bw() +
  theme(legend.position = "none") +
  scale_color_ochre(palette = "tasmania") +
  xlab("Perceptions of Great Risk of Having Five\n or More Drinks of an \nAlcoholic Beverage Once or Twice a Week") +
  ylab("Binge Alcohol Use in Past Month") +
  coord_equal()  



  