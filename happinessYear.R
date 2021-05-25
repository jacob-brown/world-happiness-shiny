library(rnaturalearth)
library(tidyverse)

dataForYear <- function(spatialDF, happinessDF, countryNamesRefTable, year){
  
  happinessDFYear <- happinessDF[happinessDF$Year == year,]
  replaceData <- data.frame(spatialDF@data$name)
  colnames(replaceData) <- "Country"
  replaceData <- correctCountryNamesToMatch(replaceData, countryNamesRefTable)
  replaceData <- left_join(replaceData, happinessDFYear, by="Country")
  replaceData["Year"] <- year
  
  return(replaceData)
  
}

correctCountryNamesToMatch <- function(replaceData, countryNamesRefTable){
  
  for(i in 1:nrow(replaceData)){
    countryGeo <- replaceData[i,1]
    
    if(countryGeo %in% countryNamesRefTable$inGeoNotInHappy){
      rowSelect <- countryNamesRefTable[countryNamesRefTable$inGeoNotInHappy == countryGeo,]
      if(rowSelect$happyName != "" & !is.na(rowSelect$happyName)){
        replaceData[i,1] <- rowSelect$happyName
      }
    }
  }
  
  return(replaceData)
  
}

getHappinessYear <- function(happinessDF, year){
  df <- happinessDF[happinessDF$Year == year, ]
  df_sort <- df[order(df$Rank),]
  return(df_sort)
}





