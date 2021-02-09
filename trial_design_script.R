# /*=================================================*/
#' # Preparation
# /*=================================================*/

# you only need to run these lines once 
# then you add a # before the line to prevent it from running again
# to run a line, you can highlight it and then press the Run button on the right corner
# OR you can put your cursor on the line you want to run and press Control Enter or command enter on a mac

install.packages(here)
install.packages(tmap)
install.packages(sp)
install.packages(sf)
install.packages(agricolae)
install.packages(lwgeom)
install.packages(measurements)
install.packages(raster)
install.packages(data.table)
install.packages(tidyverse)

library(here)
library(tmap)
library(sp)
library(sf)
library(agricolae)
library(lwgeom)
library(measurements)
library(raster)
library(data.table)
library(tidyverse)

#--- github ---#
source("https://raw.githubusercontent.com/brittanikedge/Precision-Agriculture-Producer-Materials/main/functions.R")
source("https://raw.githubusercontent.com/brittanikedge/DIFM/main/Functions.R")

# we need to bring in the boundary and guidance lines for your field
# you will need to change "boundary_new.gpkg" and "abline.gpkg" to the names of your files
# make sure those files are in the same folder as this script
boundary <- file.path(here("boundary_new.gpkg")) %>%
  st_read() %>%
  st_make_valid() %>%
  st_transform_utm()

ab_line <- file.path(here("abline.gpkg")) %>%
  st_read() %>%
  st_make_valid() %>%
  st_transform_utm()

# this code both saves the shapefile as "file_test.shp" 
# and saves the object "trial" for us to make a map with later
trial <- trial_design(boundary,
             ab_line, 
             width = conv_unit(60, "ft", "m"), 
             length = 200, 
             rates = seq(80, 240, by = 40), 
             file_name = "file_test.shp")

# now make a plot of the resulting trial
ggplot() +
  geom_sf(data = trial, mapping = aes(fill = factor(rate)), lwd = 0) +
  scale_fill_viridis_d() +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())
