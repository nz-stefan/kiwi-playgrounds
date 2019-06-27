###############################################################################
# App UI entrypoint
#
# Author: Stefan Schliebs
# Created: 2019-06-25 10:29:35 UTC
###############################################################################


material_page(
  title = "Kiwi Playgrounds",
  nav_bar_color =  "grey darken-4",
  material_side_nav(
    fixed = FALSE,
    tags$h3("Some more content here")
  ),
  tags$style(type = "text/css", "#playground_map {height: calc(100vh - 64px) !important;}"),
  leafletOutput("playground_map")
)

# fluidPage(
#   # add CSS customizations
#   tags$head(
#     tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css")
#   ),
#   
#   div(
#     class = "card",
#     tags$style(type = "text/css", "#playground_map {height: calc(100vh - 20px) !important;}"),
#     leafletOutput("playground_map")
#   )
# )
