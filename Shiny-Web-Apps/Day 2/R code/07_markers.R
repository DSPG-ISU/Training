library(tidyverse)

summary(storms)
?storms

# how many storms in one year?
storms %>% group_by(year) %>% 
  summarize(named = length(unique(name))) %>%
  arrange(desc(year))

# let's focus on one year
st15 <- storms %>% filter(year == 2015)

leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addCircleMarkers(lng = st15$long, lat = st15$lat)

leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addCircleMarkers(lng = st15$long, lat = st15$lat)

st15 %>%
  leaflet() %>%
    addProviderTiles("CartoDB") %>%
    addCircleMarkers(lng = ~long, lat = ~lat)


storms %>%
  filter(year == 2015) %>%
  leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addCircleMarkers(lng = ~long, lat = ~lat)

# popup or label give more information
storms %>%
  filter(year == 2015) %>%
  leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addCircleMarkers(lng = ~long, lat = ~lat, label=~name)
