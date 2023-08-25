#' Plot Module UI
#'
#' @param id unique namespace of the plotting module
#'
#' @return a plot module with a title, subtitle, and plot
#' @export
plotUI <- function(id) {
  ns <- NS(id)
  nav_panel("Plot",
            tags$div(class="left-margin",
              shiny::tags$div(
               class="custom-flexbox",
                  controlsUI(ns("controls")),
                  shiny::actionButton("print", "Print Plot")
               ),
               h1("Plot of Labs"),
               uiOutput(ns('subtitle'))
            ),
            plotOutput(ns("plot"))
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

       output$plot <- shiny::renderPlot({
          make_plot(data()$adlb, controls$trta(), controls$param())
       })

    }
  )
}
#' Plot Module UI
#'
#' @param id unique namespace of the plotting module
#' 
#'
#' @return a plot module with a title, subtitle, and plot
#' @export
plotUI <- function(id) {
   ns <- shiny::NS(id)
   bslib::nav_panel("Plot",
             shiny::tags$div(class="left-margin",
                      shiny::tags$div(
                         class="custom-flexbox",
                         controlsUI(ns("controls")),
                         shiny::actionButton("print", "Print Plot")
                      ),
                      shiny::h1("Plot of Labs"),
                      shiny::uiOutput(ns('subtitle'))
             ),
             plotly::plotlyOutput(ns("plot"))
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
            logger::log_info(sprintf("[%s] plot subtitle triggered", id))
            shiny::tags$div(
               class="subtitle",
               paste0(
                  "Averaged measurements of selected parameters by treatments: ",
                  paste(controls$trta(), collapse = ", "),
                  " over the course of the study."
               )
            )
         })
         
         shiny::observe({
            output$plot <- plotly::renderPlotly({
               logger::log_info(sprintf("[%s] plot ggplot2 triggered", id))
               make_plot(data()$adlb, controls$trta(), controls$param())
            })
         }) |> shiny::bindEvent(
            data()
         )
         
      }
   )
}