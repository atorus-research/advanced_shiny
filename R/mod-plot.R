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
#' 
#' @export
plotServer <- function(id, data) {
  moduleServer(
    id,
    function(input, output, session) {
       
       # browser()
       
       # you need to be inside a shiny context 
       # (something that can listen)
       # ie - observe | reactive
       # observe({
       #    browser()
       # })
       
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

      # observe({
          
      output$disp_plot <- plotly::renderPlotly({
          
          # browser( )
         
          print("--- START PLOTTING! --- ")
          print(Sys.time())
          
          logger::log_info(sprintf("[%s] disp_plot ggplot2 triggered", id))
          p <- make_plot(data()$adlb, controls$trta(), controls$param())
          
          
          print("--- STOP PLOTTING! --- ")
          print(Sys.time())
          
          p
          
      }) # %>% bindCache(data(), controls$trta(), controls$param())
          
      # }) %>% 
      #   bindEvent(data(), controls$trta(), controls$param())
      
    })

}
