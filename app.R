library(shiny)
library(bslib)
source('read_data.R')
source('make_plot.R')
source('make_table.R')
source('write_inputs.R')

ui <- tagList(
   bslib::page_navbar(
      title = "Laboratory Value Explorer",
      theme = bslib::bs_theme(
         "navbar-bg" = "white",
         "bs-navbar-active-color" = "#044ed7",
         base_font = font_google("Red Hat Display"),
         heading_font = font_google("Red Hat Display")
      ),
      sidebar = NULL,
      nav_panel("Plot",
                tags$div(class="left-margin",
                   tags$div(
                      class="custom-flexbox",
                      selectInput("trta", "Treatments", NULL, multiple = TRUE),
                      selectInput("param", "Parameters", NULL, multiple = TRUE, width = '900px'),
                      actionButton("print", "Print Plot")
                   ),
                   h1("Plot of Labs"),
                   uiOutput('subtitle')
                ),
                plotOutput("plot")
      ),
      nav_panel("Table", NULL)
   ),
   shiny::includeCSS("www/styles.css")
)

server <- function(input, output, session) {

   # a reactive value monitors input dependencies
   data <- reactive(read_data())

   # reactiveValues
   all_inputs <- reactiveValues(trta = NULL, param = NULL)

   ################### PLOT #####################

   # observeEvent can be refactored using bindEvent
   # to an observe + bindEvent()
   observe({

      # this is a little contrived but pretend we need this value
      # and all inputs have a listener attached
      input$print

      updateSelectInput(
         session,
         "trta",
         choices = unique(data()$adlb$TRTA),
         selected = unique(data()$adlb$TRTA)
      )
      updateSelectInput(
         session,
         "param",
         choices = unique(data()$adlb$PARAM),
         selected = unique(data()$adlb$PARAM)
      )
   }) %>%
      bindEvent(data())

   output$subtitle <- renderUI({
      tags$div(
         class="subtitle",
         paste0(
            "Averaged measurements of selected parameters by treatments: ",
            paste(input$trta, collapse = ", "),
            " over the course of the study."
         )
      )
   })

   output$plot <- renderPlot({
      make_plot(data()$adlb, input$trta, input$param)
   })

   ############### TABLE ##########################

   # this can be refactored using bindEvent
   manipulated_data <- reactive(make_table(data()$adlb)) %>%
      bindEvent(data())

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
   onStop(function(){
      write_inputs(all_inputs)
   })

}

shinyApp(ui, server)
