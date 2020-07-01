# see https://rstudio.github.io/leaflet/ for great examples
library(tidyverse)
library(leaflet)

leaflet() %>% addTiles()

leaflet() %>% addProviderTiles("OpenStreetMap.DE")


m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
m


###########################
# the code below only works if you are registered with the google API
library(ggmap)
isu <- geocode("Iowa State University")
durham <- geocode("Durham Center, Iowa State University", output="more")
write.csv(durham, "data/durham.csv", row.names = FALSE)
###########################

durham <- read.csv("data/durham.csv", stringsAsFactors = FALSE)

m <- leaflet() %>%
  addProviderTiles(provider = "Esri") %>% 
  addMarkers(lng=durham$lon, lat=durham$lat, popup="The birthplace of the Atanasoff-Berry Computer")
m
