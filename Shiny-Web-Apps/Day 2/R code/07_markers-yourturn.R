library(tidyverse)
library(leaflet)

# popup or label give more information
storms %>%
  filter(year == 2000) %>%
  leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addCircleMarkers(lng = ~long, lat = ~lat, label=~name,
                   radius = 3, color = "#009999")

