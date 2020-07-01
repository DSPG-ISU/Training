#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
# 

library(shiny)
library(shinydashboard)
library(tidyverse)
library(lubridate)
library(shiny)
library(tsibble)
library(scales)
library(leaflet)
library(sf)

# |-------------- Data reading & processing ------------|

population <- read.csv("data/co-est2019-alldata.csv", stringsAsFactors = FALSE)


# |-------------- Setting up the UI ------------|

header <- dashboardHeader(title = "County Population Maps")

sidebar <- dashboardSidebar(
    sidebarMenu(id="menu",
                menuItem("Map of Reproduction number", tabName = "map", icon = icon("draw-polygon")),
                selectInput("selected", "Select State:", 
                            choices = c("Iowa", "Virginia", "Oregon"), 
                            selected = "Iowa",
                            selectize=TRUE)
    )
)

body <- dashboardBody(
    #withMathJax(),
    tabItems(
        tabItem(tabName = "map",
                box(width = 12,
                    leafletOutput("map"))
                )
        )
    )

ui <- dashboardPage(header, sidebar, body)

server <- function(input, output) {
    output$map <- renderLeaflet({
        selected <- input$selected

        states <- USAboundaries::us_boundaries(type="county")
        states <- states %>% filter(state_name == selected) %>%
            mutate(
                COUNTY = as.numeric(countyfp),
                STATE = as.numeric(statefp)
            )
        plotdat <- states %>% left_join(population %>% 
                                            select(STATE, COUNTY, STNAME, CENSUS2010POP, POPESTIMATE2019), 
                                        by=c("COUNTY", "STATE"))
        # COUNTY and STATE are fips codes
        
        # range of numbers in the color palette
        scale_range <- c(0,max(plotdat$POPESTIMATE2019))
        # missing values are bright green, so we can see them and fix them :)
        pal <- colorNumeric("Reds", scale_range, na.color = "#aaff56", reverse=FALSE)
        
        
        
        leaflet() %>%
            addProviderTiles("CartoDB.Positron") %>%  
            # defaults to the middle of the country:
  #          setView(-98.483330, 38.712046, zoom = 4) %>%  
            addPolygons(data = plotdat,
                        color = "#000000", # outline of polygons
                        fillColor = ~pal(plotdat$POPESTIMATE2019), # color mapping
                        fillOpacity = 0.9,
                        weight = 0.2,
                        smoothFactor = 0.2,
                        # text to be shown on click is in html
                        popup = ~ paste0(name,", ", str_extract(state_name, "^([^,]*)"), "<br>", POPESTIMATE2019)) %>%
            addLegend(pal = pal,
                      values = scale_range,
                      position = "bottomleft",
                      title = "Population Estimate 2019"
            )
    })
    
}

shinyApp(ui, server)
