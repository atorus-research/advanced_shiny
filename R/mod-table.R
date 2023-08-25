tableUI <- function(id) {
  ns <- shiny::NS(id)
  bslib::nav_panel("Table", NULL)
}

tableServer <- function(id) {
  shiny::moduleServer(
    id,
    function(input, output, session) {

    }
  )
}
