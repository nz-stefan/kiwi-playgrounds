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
    
    leaflet(data = d_parks_geocoded(), options = leafletOptions(zoomControl = FALSE)) %>%
      addProviderTiles(
        providers$OpenStreetMap,
        options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addEasyButton(
        easyButton(
          icon = "fa-crosshairs", 
          title = "Locate Me",
          position = "topright",
          onClick = JS("function(btn, map){ map.locate({setView: true}); }")
        )
      ) %>% 
      addEasyButton(
        easyButton(
          icon = "fa-globe", 
          title = "world",
          position = "topright",
          onClick = JS("function(btn, map){ console.log(btn); if(btn.button.title == 'world') {btn.button.title = 'map'; map.addLayer(L.tileLayer.provider('Esri.WorldImagery')); } else {btn.button.title = 'world'; map.addLayer(L.tileLayer.provider('OpenStreetMap'));} }")
        )
      ) %>% 
      htmlwidgets::onRender("function(el, x) {L.control.zoom({ position: 'bottomright' }).addTo(this)}") %>%
      addMarkers(lng = ~long, lat = ~lat, popup = ~name, clusterOptions = markerClusterOptions()) %>% 
      fitBounds(
        min(d_parks_geocoded()$long), 
        min(d_parks_geocoded()$lat), 
        max(d_parks_geocoded()$long), 
        max(d_parks_geocoded()$lat)
      )
  })
}