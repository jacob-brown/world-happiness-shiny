#https://r-spatial.org/r/2018/10/25/ggplot2-sf.html

library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

world <- ne_countries(scale = "medium", returnclass = "sf")

world$name <- factor(world$name)

plot <- ggplot(data = world) + 
          geom_sf(aes(fill =name)) +
          theme_classic() +
          theme(legend.position='none')

plot

