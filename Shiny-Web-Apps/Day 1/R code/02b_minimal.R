library(shiny)
library(shinydashboard)

sidebar <- dashboardSidebar(
  textInput("name", "Enter your name:", value = "Heike")
)

ui <- dashboardPage(
  dashboardHeader(),
  sidebar = sidebar,
  dashboardBody()
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)

