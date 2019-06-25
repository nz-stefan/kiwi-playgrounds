###############################################################################
# App UI entrypoint
#
# Author: Stefan Schliebs
# Created: 2019-06-25 10:29:35 UTC
###############################################################################


fluidPage(
  # add CSS customizations
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css")
  ),
  
  # material_card(
  #   tags$style(type = "text/css", "#playground_map {height: calc(100vh - 50px) !important;}"),
  #   leafletOutput("playground_map")
  # )
  div(
    class = "card",
    tags$style(type = "text/css", "#playground_map {height: calc(100vh - 20px) !important;}"),
    leafletOutput("playground_map")
  )
)
