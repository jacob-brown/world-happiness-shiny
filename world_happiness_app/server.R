library(shiny)
library(ggplot2)
library(tidyverse)

### Prep data

prepData <- function(){
    df <- read.csv("../data/cleaned/happinessData.csv")

    df$Country <- factor(df$Country)
    df$LadderScore <- as.numeric(df$LadderScore)
    df$Year <- as.numeric(df$Year)
    df$Rank <- as.numeric(df$Rank)
    
    return(df)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # prepare the environment
    df <- prepData()

    output$distPlot <- renderPlot({
        
        df_filter <- df %>% 
            filter(Rank <= input$nCountries) 
        
        years <- unique(df_filter$Year)
        
        ggplot(df_filter, aes(Year, LadderScore))+
            geom_point(aes(color=Country))+
            geom_path(aes(colour = Country))+
            scale_x_continuous(breaks=years, labels=years)+
            theme_classic()
        

    })

})
