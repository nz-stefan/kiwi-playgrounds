###############################################################################
# Prepare playground data
#
# Author: Stefan Schliebs
# Created: 2019-06-25 10:29:56 UTC
###############################################################################


library(dplyr)
library(purrr)



# Setup -------------------------------------------------------------------

# url to kiwi-playground data
URL_PLAYGROUND_GEOJSON <- "https://raw.githubusercontent.com/nz-stefan/tumbleweedgovhack/master/app/src/main/assets/parks_geocoded.json"

# export file name
F_EXPORT_PLAYGROUND <- "app/data/parks_geocoded.csv"


# Get data ----------------------------------------------------------------

# get the json file from the URL and convert to list
playground_json <- jsonlite::read_json(URL_PLAYGROUND_GEOJSON)

# convert the list into a dataframe
d_playground <- map_df(playground_json, as_tibble)


# Clean up data -----------------------------------------------------------

d_playground_clean <- 
  d_playground %>% 

  # convert lat/long into doubles
  mutate_at(vars(long, lat), as.numeric) %>% 
  
  # leading and trailing spaces
  mutate(address = stringr::str_trim(address))


# Export ------------------------------------------------------------------

d_playground_clean %>% 
  readr::write_csv(path = F_EXPORT_PLAYGROUND)
