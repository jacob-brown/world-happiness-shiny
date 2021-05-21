# run once and then manually rename headers
# will act as a reference table

removePeriods <- function(stringList){
  storeStrings = c()
  for(elem in stringList){
    removedDot <- str_remove_all(elem, "\\.")
    storeStrings <- append(storeStrings, removedDot)
    
  }
  return(storeStrings)
}


dataFiles = list.files("data/raw/", full.names = TRUE)

store <- c()

for(file in dataFiles){
  header <- colnames(read.csv(file))
  headerNoPeriods <- removePeriods(header)
  store <- append(store, headerNoPeriods)
}

store <- data.frame(unique(store))
colnames(store) <- c("original")
store["corrected"] <- NA
write.csv(store, "data/headersToName.csv", row.names = FALSE)
