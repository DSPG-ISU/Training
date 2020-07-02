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
library(leaflet)
library(sf)

# |-------------- Data reading & processing ------------|

population <- read.csv("../data/co-est2019-alldata.csv", stringsAsFactors = FALSE)


# |-------------- Setting up the UI ------------|

header <- dashboardHeader(title = "County Population Maps")

sidebar <- dashboardSidebar(
  selectInput("selected", "Select State:", 
              choices = c("Iowa", "Virginia", "Oregon"), 
              selected = "Iowa",
              selectize=TRUE),
  sidebarMenu(id="menu",
              menuItem("State map - population density", tabName = "map", icon = icon("draw-polygon")),
              menuItem("Histogram", tabName = "histogram", icon = icon("bar-chart"))
  )
)

body <- dashboardBody(
  #withMathJax(),
  tabItems(
    tabItem(tabName = "map",
            box(width = 12, status = "primary",
                leafletOutput("map"))
    ),
    tabItem(tabName = "histogram",
            box(width = 12, status = "primary",
                plotOutput("histogram"))
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
                position = "topright",
                title = "Population<br>Estimate 2019"
      )
  })
  
  output$histogram <- renderPlot({
    selected <- input$selected
    plotdat <- population %>% filter(STNAME == selected)
    
    plotdat %>%
      ggplot(aes(x = POPESTIMATE2019)) + geom_histogram(bins = 15) +
      ggtitle(sprintf("Histogram of estimated 2019 population by county in %s", selected))
  })
}

shinyApp(ui, server)
