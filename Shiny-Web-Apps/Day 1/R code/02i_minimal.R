library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(DT)

sidebar <- dashboardSidebar(
  textInput("name", "Enter your name:", value = "Heike"),
  selectInput("state", "Enter your State:", choices=c("Virginia", "Oregon", "Iowa", "Other"), selected = "Iowa"),
  sliderInput("size", "Sample Size:", min = 1, max = nrow(mtcars), value = 32)
)

body <- dashboardBody(
  plotOutput("myplot"),
  DTOutput("mytable")
)

ui <- dashboardPage(
  dashboardHeader(title = "My shiny app"),
  sidebar = sidebar,
  body = body
)

server <- function(input, output, session) {
  output$myplot <- renderPlot({
    gg <- ggplot(data = mtcars, aes(x = mpg, y = disp)) +
      geom_point() +
      ggtitle(sprintf("%s's plot in %s", input$name, input$state))
    
    idx <- input$mytable_rows_selected
    if (!is.null(idx))
      gg + geom_point(size = 5, data = mtcars %>% slice(idx)) 
    else gg
  })
  
  output$mytable <- DT::renderDT({
    head(mtcars, input$size)
  })
}

shinyApp(ui, server)

