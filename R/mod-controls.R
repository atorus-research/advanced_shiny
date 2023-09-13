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
  tagList(
     tags$div(
        class="custom-flexbox",
        selectInput(ns("trta"), "Treatments", NULL, multiple = TRUE),
        selectInput(ns("param"), "Parameters", NULL, multiple = TRUE, width = '900px')
     ),
     tags$div(
        class="custom-flexbox",
        shiny::code("mod-controls"),
        shiny::verbatimTextOutput(ns("debug"))
     )
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
       
       # output$debug <- shiny::renderPrint({
       #    all_vals <- shiny::reactiveValuesToList(x = input, all.names = TRUE)
       #    vals <- grep(pattern = "trta|param", x = names(all_vals), value = TRUE)
       #    print(all_vals[vals])
       # })
       

       return(
          list(
             trta = reactive(input$trta),
             param = reactive(input$param)
          )
       )

    }
  )
}
