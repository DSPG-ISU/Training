library(shiny)
library(shinydashboard)
library(ggplot2)

sidebar <- dashboardSidebar(
  textInput("name", "Enter your name:", value = "Heike"),
  selectInput("state", "Enter your State:", choices=c("Virginia", "Oregon", "Iowa", "Other"), selected = "Iowa"),
  sliderInput("size", "Sample Size:", min = 1, max = nrow(mtcars), value = 10)
)

body <- dashboardBody(
  plotOutput("myplot"),
  tableOutput("mytable")
)

ui <- dashboardPage(
  dashboardHeader(title = "My shiny app"),
  sidebar = sidebar,
  body = body
)

server <- function(input, output, session) {
  output$myplot <- renderPlot({
    ggplot(data = mtcars, aes(x = mpg, y = disp)) +
      geom_point() +
      ggtitle(sprintf("%s's plot in %s", input$name, input$state))
  })
  
  output$mytable <- renderTable({
    head(mtcars, input$size)
  })
}

shinyApp(ui, server)

