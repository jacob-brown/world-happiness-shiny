

world <- rnaturalearth::countries110
happinessData <- read.csv("data/cleaned/happinessData.csv")

unique_happy <- unique(happinessData$Country)

inGeoNotInHappy <- c()
for(country in world$name){
  if(!(country %in% unique_happy)){
    inGeoNotInHappy <- append(inGeoNotInHappy, country)
  }
}


write.csv(data.frame(inGeoNotInHappy), "data/inGeoNotInHappy.csv", row.names = FALSE)
write.csv(world$name, "data/inGeo.csv", row.names = FALSE)
write.csv(unique_happy, "data/inHappy.csv", row.names = FALSE)
