tableUI <- function(id) {
  ns <- NS(id)
  nav_panel("Table", NULL)
}

tableServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {

    }
  )
}
