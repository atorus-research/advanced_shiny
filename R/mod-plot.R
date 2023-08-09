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
  moduleServer(
    id,
    function(input, output, session) {
       
       ns <- session$ns

       controls <- controlsServer("controls", data)

       output$subtitle <- renderUI({
          logger::log_info(sprintf("[%s] plot subtitle triggered", id))
          tags$div(
             class="subtitle",
             paste0(
                "Averaged measurements of selected parameters by treatments: ",
                paste(controls$trta(), collapse = ", "),
                " over the course of the study."
             )
          )
       })

       output$plot <- renderPlot({
          logger::log_info(sprintf("[%s] plot ggplot2 triggered", id))
          make_plot(data()$adlb, controls$trta(), controls$param())
       })

    }
  )
}
