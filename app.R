library(shiny)
library(tidyverse)

df <- mtcars
df$cyl <- as.factor(df$cyl)

ui <- fluidPage(
  titlePanel("Simple Shiny Dashboard (R Version)"),
  selectInput(
    "cyl",
    "Select number of cylinders:",
    choices = levels(df$cyl)
  ),
  plotOutput("scatter_plot"),
  tableOutput("data_table")
)

server <- function(input, output) {

  filtered_df <- reactive({
    df %>% filter(cyl == input$cyl)
  })

  output$scatter_plot <- renderPlot({
    ggplot(filtered_df(), aes(x = wt, y = mpg)) +
      geom_point() +
      labs(
        x = "Weight",
        y = "Miles per Gallon",
        title = "MPG vs Weight"
      )
  })

  output$data_table <- renderTable({
    filtered_df()
  })

}

shinyApp(ui, server)