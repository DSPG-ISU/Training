library(shiny)
library(shinydashboard)

sidebar <- dashboardSidebar(
  textInput("name", "Enter your name:", value = "Heike"),
  selectInput("state", "Enter your State:", choices=c("Virginia", "Oregon", "Iowa", "Other"))
)

ui <- dashboardPage(
  dashboardHeader(title = "My shiny app"),
  sidebar = sidebar,
  dashboardBody()
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)
