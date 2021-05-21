catch = file.remove(list.files("data/cleaned/", full.names = TRUE))
rm(list = ls())

library(tools)
library(tidyverse)

stripPathAndExtension <- function(filename){
  basenameYear <- file_path_sans_ext(basename(filename))
  return(basenameYear)
}


removePeriods <- function(stringList){
  storeStrings = c()
  for(elem in stringList){
    removedDot <- str_remove_all(elem, "\\.")
    storeStrings <- append(storeStrings, removedDot)
    
  }
  
  return(storeStrings)
}

correctHeader <- function(fileHeader){
  
  storeHeader <- c()
  for(elem in fileHeader){
    correctedElem <- headerCorrectionRef$corrected[elem == headerCorrectionRef$original]
    storeHeader <- append(storeHeader, correctedElem)
  }
  
  return(storeHeader) 
}

dropUnwantedContent <- function(fileContent, wantedColNames){
  
  newDF <- fileContent %>%
    dplyr::select(one_of(wantedColNames))
  
  return(newDF)
  
  
}


# reference df for correcting headers
headerCorrectionRef <- read.csv("data/headersToName_corrected.csv")
headerCorrectionRef <- filter(headerCorrectionRef, corrected != "")
#headerCorrectionRef <- headerCorrectionOriginal
#headerCorrectionRef$corrected[headerCorrectionRef$corrected == ""] <- "REMOVE"

# files to iterate over
dataFiles = list.files("data/raw/", full.names = TRUE)

# create empty df
headers <- headerCorrectionRef$corrected
dataStore <- data.frame()



for(file in dataFiles){
  
  basenameYear <- stripPathAndExtension(file)
  
  # read in as character initially and assign later
  fileContent <- read.csv(file, colClasses = "character")
  colnames(fileContent) <- removePeriods(colnames(fileContent))

  # drop unwanted columns
  fileContent <- dropUnwantedContent(fileContent, headerCorrectionRef$original)
    
  # some of the headers are spelled wrong and need correcting
  colnames(fileContent) <- correctHeader(colnames(fileContent))

  
  fileContent["Year"] <- basenameYear
  
  # write new files for each original one
  nameString = paste0("data/cleaned/", basenameYear, ".csv")
  write.csv(fileContent, nameString, row.names = FALSE)
  
  dataStore <- bind_rows(dataStore, fileContent)
}



write.csv(dataStore, "data/cleaned/merged.csv", row.names = FALSE)
