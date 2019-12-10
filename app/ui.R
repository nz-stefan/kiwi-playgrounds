###############################################################################
# App UI entrypoint
#
# Author: Stefan Schliebs
# Created: 2019-06-25 10:29:35 UTC
###############################################################################


material_page(
  title = "Kiwi Playgrounds",
  nav_bar_color =  "grey darken-4",

  # add CSS customizations
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css")
  ),
  
  # add side navigation
  material_side_nav(
    fixed = FALSE,
    tags$h3("Some more content here")
  ),
  
  # add map
  # we let the browser compute the window height to dynamically fill the entire screen with the map
  tags$style(type = "text/css", "#playground_map {height: calc(100vh - 64px) !important;}"),
  leafletOutput("playground_map")
)
