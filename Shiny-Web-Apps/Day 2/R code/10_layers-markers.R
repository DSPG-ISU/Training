library(tidyverse)
library(leaflet)
library(RColorBrewer) # install.packages("RColorBrewer")

# let's distinguish between multiple years
recent <- storms %>% filter(year >= 2012)

# create a color palette that connects colors with levels:
(years <- unique(recent$year))
(colors <- RColorBrewer::brewer.pal(n = length(years), name="Dark2"))

pal <- colorFactor(
  palette = colors,
  levels = years)

# instead of adding all markers together, we add markers one
# year at a time and group
leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addCircleMarkers(lng = ~long, lat = ~lat, label=~name,
                   radius = 3, color = ~pal(year),
                   data = recent %>% filter(year == 2015),
                   group = "2015") %>%
  addCircleMarkers(lng = ~long, lat = ~lat, label=~name,
                   radius = 3, color = ~pal(year),
                   data = recent %>% filter(year == 2014),
                   group = "2014") %>%
  addCircleMarkers(lng = ~long, lat = ~lat, label=~name,
                   radius = 3, color = ~pal(year),
                   data = recent %>% filter(year == 2013),
                   group = "2013") %>%
  addCircleMarkers(lng = ~long, lat = ~lat, label=~name,
                   radius = 3, color = ~pal(year),
                   data = recent %>% filter(year == 2012),
                   group = "2012") %>%
  addLayersControl(
    overlayGroups = c(2012:2015),
    options = layersControlOptions(collapsed = FALSE)
  )
