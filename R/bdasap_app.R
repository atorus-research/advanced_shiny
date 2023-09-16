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
         shiny::verbatimTextOutput("debug"),
         shiny::includeCSS(system.file("www/styles.css", package = "bdasap"))
      ),
      server = function(input, output, session){
         
         data <- shiny::reactive(read_data())
         
         # swap when developing
         # data <- shiny::reactive(
         #    list(adlb = arrow::read_feather(system.file("data", "adlb.arrow", package = "bdasap")))
         #    )
         
         logger::log_info("data object created")
         
         # reactiveValues
         # all_inputs <- shiny::reactiveValues(trta = NULL, param = NULL, session = session)
         vals <- reactive(reactiveValuesToList(x = input, all.names = TRUE))
         ############### TABLE ##########################
         
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
            # add shiny session info to the list
            full_list <- isolate(vals())
            # there's some artifacts in the list we don't need
            # lets just return user controls for both the plot and table
            write_inputs(full_list[grep("-controls-", names(full_list))])
         })
         
      }
   )
   
   # run build app
   if (runApp)
      shiny::runApp(app, test.mode = TRUE)
   else
      app
}
