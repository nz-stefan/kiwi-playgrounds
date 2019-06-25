###############################################################################
# UI utility functions
#
# Author: Stefan Schliebs
# Created: 2019-06-25 10:46:23 UTC
###############################################################################


material_card <- function(..., header = NULL, bgcolor = "white") {
  div(
    class = "card",
    header, 
    div(class = "card-content", ..., style = sprintf("background-color: %s", bgcolor))
  )
}