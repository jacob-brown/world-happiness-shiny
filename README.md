
## To Do
Some countries are 
1. named differently between years
2. do not appear in the geospatial data - eg. Hong Kong, palastine 

```R
unique_world <- unique(happinessData$Country)

nontFoundCountries <- c()
for(country in unique_world){
  if(!(country %in% world$name)){
    nontFoundCountries <- append(nontFoundCountries, country)
  }
}
```