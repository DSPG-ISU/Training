if (!require(devtools)) {
  install.packages("devtools")
  library(devtools)
}

# check you session info:
session_info()

if (!require(shiny)) {
  install.packages("shiny")
  library(shiny)
}
# end of initial setup - 
# the code below are covering all of the other packages needed


####


if (!require(shinydashboard)) {
  install.packages("shinydashboard")
  library(tidyverse)
}

if (!require(tidyverse)) {
  install.packages("tidyverse")
  library(tidyverse)
}

if (!require(plotly)) {
  install.packages("plotly")
  library(plotly)
}

if (!require(colourpicker)) {
  install.packages("colourpicker")
  library(colourpicker)
}


if (!require(leaflet)) {
  install.packages("leaflet")
  library(leaflet)
}

if (!require(leaflet.extras)) {
  install.packages("leaflet.extras")
  library(leaflet.extras)
}

if (!require(RColorBrewer)) {
  install.packages("RColorBrewer")
  library(RColorBrewer)
}
