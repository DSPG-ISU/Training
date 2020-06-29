library(shiny)
library(shinydashboard)
library(ggplot2)

sidebar <- dashboardSidebar(
  textInput("name", "Enter your name:", value = "Heike"),
  selectInput("state", "Enter your State:", choices=c("Virginia", "Oregon", "Iowa", "Other"), selected = "Iowa")
)

body <- dashboardBody(
  plotOutput("myplot")
)

ui <- dashboardPage(
  dashboardHeader(title = "My shiny app"),
  sidebar = sidebar,
  body = body
)

server <- function(input, output, session) {
  output$myplot <- renderPlot({
    ggplot() +
      ggtitle(sprintf("%s's plot in %s", input$name, input$state))
  })
}

shinyApp(ui, server)

