#' Plot Module UI
#'
#' @param id unique namespace of the plotting module
#'
#' @return a plot module with a title, subtitle, and plot
#' 
#' @export
plotUI <- function(id) {
   ns <- shiny::NS(id)
   bslib::nav_panel("Plot",
             shiny::tags$div(class = "left-margin",
                      shiny::tags$div(
                         class = "custom-flexbox",
                         controlsUI(ns("controls")),
                         shiny::actionButton("print", "Print Plot")
                      ),
                      shiny::h1("Plot of Labs"),
                      shiny::uiOutput(ns('subtitle'))
             ),
             plotly::plotlyOutput(ns("disp_plot"))
   )
}

#' Plot module server
#' 
#' controls subset the plot and change the subtitle of the module
#'
#' @param id matching unique namespace ID of the UI module
#' @param data data used for plotting and controls
#' 
#' @export
plotServer <- function(id, data) {
   shiny::moduleServer(
      id,
      function(input, output, session) {
         
         ns <- session$ns
         
         controls <- controlsServer("controls", data)
         
         output$subtitle <- shiny::renderUI({
            shiny::tags$div(
               class = "subtitle",
               paste0(
                  "Averaged measurements of selected parameters by treatments: ",
                  paste(controls$trta(), collapse = ", "),
                  " over the course of the study."
               )
            )
         })
         
         shiny::observe({
            output$disp_plot <- plotly::renderPlotly({
               make_plot(data()$adlb, controls$trta(), controls$param())
            })
         }) |> shiny::bindEvent(
            data()
         )
         
    }
         
)}