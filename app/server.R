###############################################################################
# App server logic entrypoint
#
# Author: Stefan Schliebs
# Created: 2019-06-25 10:29:35 UTC
###############################################################################


server <- function(input, output, session) {
  
  d_parks_geocoded <- reactive(readr::read_csv("data/parks_geocoded.csv"))
  
  output$playground_map <- renderLeaflet({
    req(d_parks_geocoded())
    
    leaflet(data = d_parks_geocoded()) %>%
      addProviderTiles(
        providers$OpenStreetMap,
        options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(lng = ~long, lat = ~lat, popup = ~name, clusterOptions = markerClusterOptions()) %>% 
      fitBounds(
        min(d_parks_geocoded()$long), 
        min(d_parks_geocoded()$lat), 
        max(d_parks_geocoded()$long), 
        max(d_parks_geocoded()$lat)
      )
  })
}