library(tidyverse)
library(leaflet)
library(RColorBrewer) # install.packages("RColorBrewer")

str15 <- storms %>%
  filter(year == 2015) 

# create a color palette that connects colors with levels:
(names <- unique(st15$name))
(colors <- RColorBrewer::brewer.pal(n = length(names), name="Paired"))

pal <- colorFactor(
  palette = colors,
  levels = names)


# now use the color palette in the call to add circles
st15 %>%
  leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addCircleMarkers(lng = ~long, lat = ~lat, label=~name,
                   radius = 3, color = ~pal(name))

# and add a legend
st15 %>%
  leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addCircleMarkers(lng = ~long, lat = ~lat, label=~name,
                   radius = 3, color = ~pal(name)) %>%
  addLegend(colors = colors, labels = names)

