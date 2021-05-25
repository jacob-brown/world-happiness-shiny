library(ggplot2)
library(tidyverse)
library(plotly)

df <- read.csv("data/cleaned/happinessData.csv")


df$Country <- factor(df$Country)
df$LadderScore <- as.numeric(df$LadderScore)
df$Year <- as.numeric(df$Year)
df$Rank <- as.numeric(df$Rank)

df_filter <- df %>% 
  filter(Rank <= 10) 

years <- unique(df_filter$Year)

plot <- ggplot(df_filter, aes(Year, LadderScore))+
          geom_point(aes(color=Country))+
          geom_path(aes(colour = Country))+
          scale_x_continuous(breaks=years, labels=years)+
          theme_classic()#+
          #theme(legend.position='none')

interactive_plot <- ggplotly(plot)
interactive_plot
  