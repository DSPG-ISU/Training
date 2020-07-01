library(tidyverse)
library(leaflet)
library(leaflet.extras)


leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addSearchOSM()

leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addSearchOSM() %>%
  addReverseSearchOSM()

# and add a legend
st15 %>%
  leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addCircleMarkers(lng = ~long, lat = ~lat, label=~name,
                   radius = 3, color = ~pal(name)) %>%
  addLegend(colors = colors, labels = names)

