#' Run the bdasap application
#'
#' @param runApp should the app be run on completion, defaults to TRUE
#'
#' @import shiny
#' @import bslib
#'
#' @export
bdasap_app <- function(runApp = TRUE){
   
   # build app object
   app <- shiny::shinyApp(
      ui = tagList(
         page_navbar(
            title = "Laboratory Value Explorer",
            theme = bs_theme(
               "navbar-bg" = "white",
               "bs-navbar-active-color" = "#044ed7",
               base_font = font_google("Red Hat Display"),
               heading_font = font_google("Red Hat Display")
            ),
            sidebar = NULL,
            plotUI('plot'),
            tableUI('table')
         ),
         shiny::verbatimTextOutput("debug"),
         shiny::includeCSS("inst/www/styles.css")
      ),
      server = function(input, output, session){
         
         data <- reactive(read_data())
         logger::log_info("data object created")
         
         # reactiveValues
         all_inputs <- shiny::reactiveValues(trta = NULL, param = NULL)
         
         # reactives get passed to modules as functions!
         # we _call_ the reactive INSIDE the module
         plotServer("plot", data)
         tableServer("table")
         
         ################ Exercise ##################
         
         # set up a listener to update all_values
         # from NULL to the currently selected inputs
         # for param and trta
         #
         #
         # we'll eventually use this object
         # to store selections in a database!
         shiny::onStop(function(){
            write_inputs(all_inputs)
         })
         
      }
   )
   
   # run build app
   if (runApp)
      runApp(app, test.mode = TRUE)
   else
      app
}
