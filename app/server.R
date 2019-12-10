###############################################################################
# App server logic entrypoint
#
# Author: Stefan Schliebs
# Created: 2019-06-25 10:29:35 UTC
###############################################################################


server <- function(input, output, session) {
  
  d_parks_geocoded <- reactive({
    # load data from file and create the HTML for the popup label
    readr::read_csv("data/parks_geocoded.csv") %>% 
      mutate(
        button = sprintf("<button onclick='Shiny.onInputChange(\"popup_click\",  %d)' id='popup_click' type='button' class='waves-effect waves-light btn shiny-material-button z-depth-2 light-blue lighten-1'><i class='material-icons left'>info_outline</i>Info</button>", id),
        html_name = sprintf("<p style='font-weight: bold; font-size: 1.5em'>%s</p><p>%s</p>%s", name, address, button)
      )
  })
  
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
      addMarkers(lng = ~long, lat = ~lat, popup = ~html_name, layerId = ~id, clusterOptions = markerClusterOptions()) %>% 
      fitBounds(
        min(d_parks_geocoded()$long), 
        min(d_parks_geocoded()$lat), 
        max(d_parks_geocoded()$long), 
        max(d_parks_geocoded()$lat)
      )
  })
  

  # Capture marker click events ---------------------------------------------
  
  observeEvent(input$playground_map_marker_click, {
    req(d_parks_geocoded())
    
    # Map events are captured in input variable input$MAPID_OBJCATEGORY_EVENTNAME.
    # The object category for markers is "marker", the event name is "click".
    event <- input$playground_map_marker_click
    
    print(d_parks_geocoded() %>% filter(id == event$id))
    
  })
  
  observeEvent(input$popup_click, {
    # identify playground record linked to clicked popup
    clicked_playground <- 
      d_parks_geocoded() %>% 
      filter(id == input$popup_click)
    
    print(input$popup_click)
    
    # showModal(
    #   modalDialog(
    #     title = clicked_playground$name,
    #     tags$p(clicked_playground$equipment)
    #   )
    # )
  })
}