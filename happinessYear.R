getHappinessYear <- function(happinessDF, year){
  df <- happinessDF[happinessDF$Year == year, ]
  df_sort <- df[order(df$Rank),]
  return(df_sort)
}



