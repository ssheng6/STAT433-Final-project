# Load packages ----
library(shiny)
library(maps)
library(mapproj)


# Source helper functions -----
library(maps)
library(mapproj)
source("helpers.R")

# Load data ----
counties <- read.csv("data/price.csv")


# User interface ----
ui <- fluidPage(
  titlePanel("Agrculture Econmics -  Corn prices and Meat prices prediction"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("predict meat price info with Corn price change"),
      

      checkboxGroupInput("chose region", 
                                h3("chose region"), 
                                choices = list("west_corn" = 1, 
                                               "east_corn" = 2, 
                                               "iamn_corn" = 3),
                                selected = 1),
      
      dateRangeInput("range", 
                  label = "date range of interest:",
                  h3("Date range"))
    ),
    
    mainPanel(plotOutput("map"))
  )
)



# Server logic ----
server <- function(input, output) {
  output$plot <- renderPlot({
    counties <- getSymbols(input$symb, src = "yahoo",
                       from = input$dates[1],
                       to = input$dates[2],
                       auto.assign = FALSE)
    
    chartSeries(counties, theme = chartTheme("white"),
                type = "line", log.scale = input$log, TA = NULL)
  })
}

# Run app ----
shinyApp(ui=ui, server=server)