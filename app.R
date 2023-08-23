library(shiny)
library(bslib)

ui <- shiny::tagList(
   bslib::page_navbar(
      title = tags$div(
         shiny::img(
            src = "logo-shiny.png",
            height = 50,
            width = 45,
            style = "margin:10px 10px"
         ),
         "bdasap"
      ),
      theme = bslib::bs_theme(
         "navbar-bg" = "white",
         "bs-navbar-active-color" = "#044ed7",
         base_font = font_google("Red Hat Display"),
         heading_font = font_google("Red Hat Display")
      ),
      sidebar = NULL,
      bslib::nav_panel("Plot",
            shiny::tags$div(class = "left-margin",
                  shiny::tags$div(
                      class = "custom-flexbox",
                      shiny::selectInput("trta", "Treatments", NULL, multiple = TRUE),
                      shiny::selectInput("param", "Parameters", NULL, multiple = TRUE, width = '900px'),
                      shiny::actionButton("print", "Print Plot")
                   ),
                   shiny::h1("Plot of Labs"),
                   shiny::uiOutput('subtitle')
                ),
                plotly::plotlyOutput("plot")
      ),
      bslib::nav_panel("Table", NULL)
   ),
   shiny::includeCSS("www/styles.css")
)

server <- function(input, output, session) {

   # a reactive value monitors input dependencies
   data <- shiny::reactive(read_data())

   # reactiveValues
   all_inputs <- shiny::reactiveValues(trta = NULL, param = NULL)

   ################### PLOT #####################

   # observeEvent can be refactored using bindEvent
   # to an observe + bindEvent()
   shiny::observe({

      # this is a little contrived but pretend we need this value
      # and all inputs have a listener attached
      input$print

      shiny::updateSelectInput(
         session,
         "trta",
         choices = unique(data()$adlb$TRTA),
         selected = unique(data()$adlb$TRTA)
      )
      shiny::updateSelectInput(
         session,
         "param",
         choices = unique(data()$adlb$PARAM),
         selected = unique(data()$adlb$PARAM)
      )
   }) |>
      shiny::bindEvent(data())

   output$subtitle <- shiny::renderUI({
      shiny::tags$div(
         class = "subtitle",
         paste0(
            "Averaged measurements of selected parameters by treatments: ",
            paste(input$trta, collapse = ", "),
            " over the course of the study."
         )
      )
   })

   output$plot <- plotly::renderPlotly({
      make_plot(data()$adlb, input$trta, input$param)
   })

   ############### TABLE ##########################

   # this can be refactored using bindEvent
   manipulated_data <- shiny::reactive(make_table(data()$adlb)) |>
      shiny::bindEvent(data())

   # we'll use this table
   # in our table tab next session!


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

shiny::shinyApp(ui = ui, server = server)
