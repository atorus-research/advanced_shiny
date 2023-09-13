#' Run the bdasap application
#'
#' @param runApp should the app be run on completion, defaults to TRUE
#'
#' @import shiny
#'
#' @export
bdasap_app <- function(runApp = TRUE){
   
   addResourcePath("www", system.file("www", package = "bdasap"))
   # build app object
   app <- shiny::shinyApp(
      ui = shiny::tagList(
         bslib::page_navbar(
            title = shiny::tags$div(
               shiny::img(
                  src = "www/logo-shiny.png",
                  height = 50,
                  width = 45,
                  style = "margin:10px 10px"
               ),
               "bdasap"
            ),
            theme = bslib::bs_theme(
               "navbar-bg" = "white",
               "bs-navbar-active-color" = "#044ed7",
               base_font = sass::font_google("Red Hat Display"),
               heading_font = sass::font_google("Red Hat Display")
            ),
            sidebar = NULL,
            plotUI('plot'),
            tableUI('table')
         ),
         shiny::code("bdasap_app.R"),
         shiny::verbatimTextOutput("debug"),
         shiny::includeCSS(system.file("www/styles.css", package = "bdasap"))
      ),
      server = function(input, output, session){
         
         data <- shiny::reactive(read_data())
         
         # reactiveValues
         all_inputs <- shiny::reactiveValues(trta = NULL, param = NULL)
         
         ############### TABLE ##########################
         
         # reactives get passed to modules as functions!
         # we _call_ the reactive INSIDE the module
         plotServer("plot", data)
         tableServer("table", data)
         
         ################ Exercise ##################
         
         # set up a listener to update all_values
         # from NULL to the currently selected inputs
         # for param and trta
         # output$debug <- shiny::renderPrint({
         #    all_vals <- shiny::reactiveValuesToList(x = input, all.names = TRUE)
         #    vals <- grep(pattern = "-controls-", x = names(all_vals), value = TRUE)
         #    print(all_vals[vals])
         # })
         # we'll eventually use this object
         # to store selections in a database!
         shiny::onStop(function(){
            write_inputs(all_inputs)
         })
         
      }
   )
   
   # run build app
   if (runApp)
      shiny::runApp(app, test.mode = TRUE)
   else
      app
}
