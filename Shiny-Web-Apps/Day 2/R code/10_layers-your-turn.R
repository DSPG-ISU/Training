library(tidyverse)
library(leaflet)
library(RColorBrewer) # install.packages("RColorBrewer")

storms %>% filter(year == 2015) %>% glimpse()

# that will create one big storm track :(
storms %>% 
  filter(year == 2015) %>%
  leaflet() %>%
    addProviderTiles("CartoDB") %>%
    addPolylines(lng = ~long, lat = ~lat, label=~name) 

# create one track at a time
st15 <- storms %>% filter(year == 2015)
(unique(st15$name))

leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addPolylines(lng = ~long, lat = ~lat, label=~name,
               data = filter(st15, name=="Ana"), group ="Ana") %>%
  addPolylines(lng = ~long, lat = ~lat, label=~name,
               data = filter(st15, name=="Bill"), group ="Bill") %>%
  addPolylines(lng = ~long, lat = ~lat, label=~name,
               data = filter(st15, name=="Claudette"), group ="Claudette") %>%
  addLayersControl(overlayGroups = unique(st15$name))

# this is pretty clumsy ... better use shapefiles exported directly from QGIS
