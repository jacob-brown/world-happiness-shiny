#https://r-spatial.org/r/2018/10/25/ggplot2-sf.html

library(ggplot2)
library(leaflet)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

world <- ne_countries(scale = "medium", returnclass = "sf")

world$name <- factor(world$name)

plot_ggplot <- ggplot(data = world) + 
          geom_sf(aes(fill =name)) +
          theme_classic() +
          theme(legend.position='none')



### leaflet 

map_leaflet <- leaflet() %>%
                  addTiles()

map_leaflet

