rm(list = ls())

library(tidyverse)

# recalculate some of the missing data
dataOG <- read.csv("data/cleaned/merged.csv")


# filter the unwanted variables
filteredDF <- dataOG %>% 
              dplyr::select(-Region, -OverallRank)



# update ranking per year
filteredDF["Rank"] <- NA
years <- unique(filteredDF$Year)

rankedDF <- data.frame()
for(yr in years){
    yearDF <- filter(filteredDF, Year == yr)
    yearDF <- yearDF[order(-yearDF$LadderScore),]
    ranks <- seq(1,nrow(yearDF), 1)
    yearDF$Rank <- ranks
    
    rankedDF <- bind_rows(rankedDF, yearDF)
    
    
}


#write.csv(filteredDF, "data/cleaned/happinessData.csv", row.names = FALSE)


scoreYearDF <- rankedDF %>% 
  dplyr::select(Country, Year, Rank, LadderScore, )

write.csv(scoreYearDF, "data/cleaned/happinessData.csv", row.names = FALSE)
