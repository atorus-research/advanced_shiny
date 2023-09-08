#' Plot Module UI
#'
#' @param id unique namespace of the plotting module
#' 
#'
#' @return a plot module with a title, subtitle, and plot
#' @export
plotUI <- function(id) {
  ns <- NS(id)
  bslib::nav_panel("Plot",
            tags$div(class="left-margin",
              shiny::tags$div(
               class="custom-flexbox",
                  controlsUI(ns("controls")),
                  shiny::actionButton("print", "Print Plot")
               ),
               h1("Plot of Labs"),
               uiOutput(ns('subtitle'))
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
  moduleServer(
    id,
    function(input, output, session) {
       
       ns <- session$ns

       controls <- controlsServer("controls", data)

       output$subtitle <- renderUI({
          logger::log_info(sprintf("[%s] disp_plot subtitle triggered", id))
          tags$div(
             class="subtitle",
             paste0(
                "Averaged measurements of selected parameters by treatments: ",
                paste(controls$trta(), collapse = ", "),
                " over the course of the study."
             )
          )
       })

      output$disp_plot <- renderPlotly({
         
          print("--- START PLOTTING! --- ")
          print(Sys.time())
          logger::log_info(sprintf("[%s] disp_plot ggplot2 triggered", id))
          p <- make_plot(data()$adlb, controls$trta(), controls$param())
          
          
          print("--- STOP PLOTTING! --- ")
          print(Sys.time())
          
          p
          
      }) %>%
             # think of this as a temp DB 
             # the arguments we put here uniquely define plots
             # the first time the plot generates it maps the original data
             # the original trta
             # the original param
             # change stuff - new plot
             # now change back, the second redraw is way faster than the first!
             # you can do it per session: when you close you start over
             # per app: you can store it on the shiny server!! 
             # in memory caching (just stored in your server until it restarts)
             # bindCache(data(), controls$trta(), controls$param())
          bindCache(data(), controls$trta(), controls$param())
          
      })

}
