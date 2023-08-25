#' Controls UI module
#' 
#' two multiselect controls
#' one for treatment and the other for parameters
#'
#' @param id unique identifier of the module
#'
#' @export
controlsUI <- function(id) {
  ns <- shiny::NS(id)
  shiny::tags$div(
     class="custom-flexbox",
     shiny::selectInput(ns("trta"), "Treatments", NULL, multiple = TRUE),
     shiny::selectInput(ns("param"), "Parameters", NULL, multiple = TRUE, width = '900px')
  )
}

#' control server
#'
#' @param id unique identifier to match the controls UI
#' @param data data to use for populating the choices 
#' and selections of the pickers
#'
#' @export
controlsServer <- function(id, data) {
   shiny::moduleServer(
    id,
    function(input, output, session) {

       ns <- session$ns

       shiny::observeEvent(data(), {
          shiny::updateSelectInput(
             session,
             "trta",
             choices = unique(data()$adlb$TRTA),
             selected = unique(data()$adlb$TRTA)
          )
          shiny::updateSelectInput(
             session,
             "param",
             choices = unique(data()$adlb$PARAM),
             selected = unique(data()$adlb$PARAM)
          )
       })

       return(
          list(
             trta = shiny::reactive(input$trta),
             param = shiny::reactive(input$param)
          )
       )

    }
  )
}
