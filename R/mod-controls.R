#' Controls UI module
#' 
#' two multiselect controls
#' one for treatment and the other for parameters
#'
#' @param id unique identifier of the module
#'
#' @export
controlsUI <- function(id) {
  ns <- NS(id)
  tags$div(
     class="custom-flexbox",
     selectInput(ns("trta"), "Treatments", NULL, multiple = TRUE),
     selectInput(ns("param"), "Parameters", NULL, multiple = TRUE, width = '900px')
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
  moduleServer(
    id,
    function(input, output, session) {

       ns <- session$ns

       observeEvent(data(), {
          logger::log_info(sprintf("[%s] controls triggered", id))
          updateSelectInput(
             session,
             "trta",
             choices = unique(data()$adlb$TRTA),
             selected = unique(data()$adlb$TRTA)
          )
          updateSelectInput(
             session,
             "param",
             choices = unique(data()$adlb$PARAM),
             selected = unique(data()$adlb$PARAM)
          )
       })

       return(
          list(
             trta = reactive(input$trta),
             param = reactive(input$param)
          )
       )

    }
  )
}
