library(shiny)
library(ggplot2)
library(plotly)
library(tidyverse)
library(shinydashboard)
library(leaflet)
library(rnaturalearth)
library(wesanderson)
library(DT)

# load functions
source("plot_Map.R")
source("happinessYear.R")

# global data
world <- rnaturalearth::countries110
happinessData <- read.csv("data/cleaned/happinessData.csv")
countryNamesRefTable <- read.csv("data/inGeoNotInHappy_corrected.csv")
choices_Year <- rev(unique(happinessData$Year))

# make map with input
makeMapShiny <- function(world, happinessData, inputYear){
    world@data <- dataForYear(world, happinessData, countryNamesRefTable, inputYear)
    palLeaflet <- makePalette(world)
    world$label <- makeLabels(world)
    map <- makeMap(world, palLeaflet)
    return(map)
}

# make data table
makeTableShiny <- function(happinessData, inputYear){
    happinessYear <- getHappinessYear(happinessData, inputYear)
    dt <- datatable(happinessYear, rownames = FALSE)
    return(dt)
}

## UI Body
body <- function(){
    fluidRow(
        column(width = 4,
               
               box(width = NULL, status = "primary",            
                   selectInput("year",
                               "Year",
                               choices = choices_Year,
                               selected = max(choices_Year)
                               )
                   ),
               box(
                   width = NULL, status = "primary",
                   DT::dataTableOutput("table_countriesYear")
               ),
        ),
        column(width = 8,
               
               box(width = NULL, status = "primary",
                   leafletOutput("map_World", height = 500)
               )
        )
        
        
    )
}

##############
# UI
###
ui <- dashboardPage(
    dashboardHeader(title="World Happiness Report"),
    dashboardSidebar(disable = TRUE),
    dashboardBody(body())
)


##############
# Server
###
server <- function(input, output) {
    
    # leaflet map plot
    output$map_World <- renderLeaflet({
        makeMapShiny(world, happinessData, input$year)
        })
    
    # tale of top countries
    output$table_countriesYear <- DT::renderDataTable({
        makeTableShiny(happinessData, input$year)
        })
    
}



##############
# Run the application 
###
shinyApp(ui = ui, server = server)
