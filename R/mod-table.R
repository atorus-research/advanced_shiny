#' Table UI
#'
#' @param id namespace of the table modules
#'
#' @return table UI
#' 
#' @importFrom reactable reactableOutput
#' 
#' @export
tableUI <- function(id) {
   ns <- NS(id)
   bslib::nav_panel("Table",
             tags$div(class="left-margin",
                      shiny::tags$div(
                         class="custom-flexbox",
                         controlsUI(ns("controls"))
                      ),
                      h1("Table of Labs")
             ),
             reactable::reactableOutput(ns("disp_table"))
   )
}

#' Table Server code
#'
#' @param id matching namespace of UI function
#' @param data data to display in the table, passed to make_table
#' 
#' @importFrom reactable reactable
#'
#' @export
tableServer <- function(id, data) {
   moduleServer(
      id,
      function(input, output, session) {
         
         ns <- session$ns
         controls <- controlsServer("controls", data)
         
         observe({
            output$disp_table <- reactable::renderReactable({
               logger::log_info(sprintf("[%s] reacttable triggered", id))
               reactable::reactable(
                  make_table(data()$adlb, controls$trta(), controls$param()),
                  groupBy = "Parameter",
                  defaultPageSize = 20
               )
            })
         }) |> bindEvent(
            data()
         )
      }
   )
}