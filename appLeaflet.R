library(shiny)
library(ggplot2)
library(plotly)
library(tidyverse)
library(shinydashboard)
library(leaflet)
library(rnaturalearth)
library(wesanderson)

# global data
source("plot_Leaflet.R")
world <- rnaturalearth::countries110
happinessData <- read.csv("data/cleaned/happinessData.csv")

##############
# UI
###
ui <- dashboardPage(
    
    # Application title
    dashboardHeader(title="World Happiness Report"),
    
    # Sidebar with a slider input for number of bins
    dashboardSidebar(
            selectInput("year",
                        "Year",
                       choices = unique(happinessData$Year))
        ),
        
        # Show a plot of the generated distribution
        dashboardBody(
            leafletOutput("map_World"),
            )
)


##############
# Server
###
server <- function(input, output) {
    
    # leaflet map plot
    output$map_World <- renderLeaflet({
        world@data <- dataForYear(world, happinessData, input$year)
        palLeaflet <- makePalette(world)
        world$label <- makeLabels(world)
        makeMap(world, palLeaflet)
    })
}




##############
# Run the application 
###
shinyApp(ui = ui, server = server)
