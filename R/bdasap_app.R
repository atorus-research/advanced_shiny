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
            title = tags$div(
               shiny::img(
                  src = "www/logo-shiny.png",
                  height = 50,
                  width = 45,
                  style = "margin:10px 10px"
               ),
               "bdasap"
            ),
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
         shiny::includeCSS(path = "www/styles.css", package = "bdasap")
      ),
      server = function(input, output, session){
         
         # reactiveValues
         all_inputs <- shiny::reactiveValues(
            trta = NULL, 
            param = NULL
         )

         data <- reactive(read_data())
         
         logger::log_info("data object created")
         
         # reactives get passed to modules as functions!
         # we _call_ the reactive INSIDE the module
         plotServer("plot", data)
         tableServer("table", data)
         
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
