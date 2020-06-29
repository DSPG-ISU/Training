library(shiny)
library(shinydashboard)

ui <- fluidPage(
  h1("Hello World!"),
  h2("this is me")
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)