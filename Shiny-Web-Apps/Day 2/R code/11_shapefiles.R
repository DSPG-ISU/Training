library(tidyverse)
library(leaflet)
library(USAboundaries) # install.packages("USAboundaries")
library(sf)

# comment out to install the Data add-on - but beware - you will
# need a fast internet connection!
#library(USAboundariesData) # devtools::install_github("ropensci/USAboundariesData")

states <- us_states()
states %>% 
  leaflet() %>%
    addProviderTiles("CartoDB") %>%
    addPolygons(label = ~name) 

counties <- us_counties()
counties %>% 
  filter(state_name == "Iowa") %>%
  leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addPolygons(label = ~name) 

# Adding additional information
population <- read.csv("data/co-est2019-alldata.csv")
# Census Bureau estimates for each county see documentation
# in the pdf file

counties <- counties %>% 
  mutate(
    COUNTY = as.numeric(countyfp),
    STATE = as.numeric(statefp)
  )

plotdat <- counties %>% 
  filter(state_name == "Iowa") %>%
  left_join(population %>% 
              select(STATE, COUNTY, STNAME, POPESTIMATE2019), 
            by=c("COUNTY", "STATE"))
# COUNTY and STATE are fips codes

# range of numbers in the color palette
scale_range <- c(0,max(plotdat$POPESTIMATE2019))
# missing values are bright green, so we can see them and fix them :)
pal <- colorNumeric("Red", scale_range, na.color = "#aaff56", reverse=FALSE)

plotdat %>% 
  leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addPolygons(color = ~pal(POPESTIMATE2019),
              fillOpacity = 0.9, weight = 2,
              popup = ~paste0(name,", ", str_extract(state_name, "^([^,]*)"), "<br>", POPESTIMATE2019)) %>%
  addLegend(title="2019 Population<br>Estimates",
            position = "topright",
            pal = pal,
            values = scale_range)
