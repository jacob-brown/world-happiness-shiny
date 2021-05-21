library(shiny)
library(ggplot2)
library(plotly)
library(tidyverse)
library(shinydashboard)

##############
# functions
###
prepData <- function(){
    df <- read.csv("data/cleaned/happinessData.csv")
    
    df$Country <- factor(df$Country)
    df$LadderScore <- as.numeric(df$LadderScore)
    df$Year <- as.numeric(df$Year)
    df$Rank <- as.numeric(df$Rank)
    
    return(df)
}

# plot top contries
plotTopContries <- function(data, nCountries){
    
    df_filter <- df %>% 
        filter(Rank <= nCountries) 
    
    years <- unique(df_filter$Year)
    
    plot <- ggplot(df_filter, aes(Year, LadderScore))+
        geom_point(aes(color=Country))+
        geom_path(aes(colour = Country))+
        scale_x_continuous(breaks=years, labels=years)+
        theme_classic()
    
    interactive_plot <- ggplotly(plot)
    return(interactive_plot)
    
}

##############
# UI
###
ui <- dashboardPage(
    
    # Application title
    dashboardHeader(title="World Happiness Report"),
    
    # Sidebar with a slider input for number of bins
    dashboardSidebar(
            sliderInput("nCountries",
                        "Top n countries:",
                        min = 1,
                        max = 50,
                        value = 10)
        ),
        
        # Show a plot of the generated distribution
        dashboardBody(
            plotlyOutput("lineGraph"),)
)


##############
# Server
###
server <- function(input, output) {
    
    # setup the env
    df <- prepData()
    
    # top countries plot
    output$lineGraph <- renderPlotly({
        plotTopContries(df, input$nCountries)
    })
}




##############
# Run the application 
###
shinyApp(ui = ui, server = server)
