library(leaflet)
library(rnaturalearth)
library(tidyverse)
library(wesanderson)


makeLabels <- function(spatialDF){
  labels <- paste("<b>", spatialDF$Country, "</b>", 
                  "</br>",
                  "Rank: ", spatialDF$Rank, 
                  "</br>", 
                  "Ladder Score: ", 
                  spatialDF$LadderScore)
  
  htmlLabels <- lapply(labels, htmltools::HTML)
  return(htmlLabels)
}

makePalette <- function(spatialDF, westheme="Zissou1"){
  pal_wes <- wes_palette(westheme, 10, type = "continuous")
  pal_wes <- rev(as.vector(pal_wes))
  
  # leaflet obj
  pal <- colorNumeric(palette = pal_wes,
                      domain = spatialDF$LadderScore)
  
  return(pal)
}

makeMap <- function(spatialDF, colPalette){
  
  map <- leaflet(spatialDF) %>%
    setView(lng = -0, lat = 0, zoom = 1) %>%
    addPolygons(color = ~colPalette(LadderScore), 
                weight = 1, 
                smoothFactor = 0.5,
                opacity = 1.0, 
                fillOpacity = 0.5, 
                label = ~label, 
                highlightOptions = highlightOptions(color = "white", 
                                                    weight = 1,
                                                    bringToFront = TRUE)) %>%
    addLegend("bottomright", 
              pal = colPalette, 
              values = ~LadderScore, 
              opacity = 2,
              title = "Happiness Score"
    )
  
  
  return(map)
}


# world <- rnaturalearth::countries110
# happinessData <- read.csv("data/cleaned/happinessData.csv")
# year <- "2019"
# world@data <- dataForYear(world, happinessData, year)
# palLeaflet <- makePalette(world)
# world$label <- makeLabels(world)
# makeMap(world, palLeaflet)
