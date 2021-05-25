# World Happiness Report Data

## Process data
1. run `tmp_getAllHeaders.R` to generate a unique list of the headers used for each year's data (in raw) 
  * only run once
  * copy `headersToName.csv` to `headersToName_corrected.csv` and correct the headers manually
  * will act as a reference panel
2. run `proc_RenameAndMerge.R` to generate `cleaned/merged.csv`, a merged dataset and cleaned headers for each year
3. run `proc_FilterAndReCalculate.R` to generate the usable dataset `cleaned/happinessData.csv`
4. run `tmp_CorrectCountries.R` to generate a mismatch list of the countries between geospatial and happiness data
  * only run once
  * copy `inGeoNotInHappy.csv` to `inGeoNotInHappy_corrected.csv` and correct manually

## Shiny 
**Files:**
* `app.R` - main app
* `plot_Map.R` - plots the leaflet map
* `happinessYear.R` - get data for a specifi year
