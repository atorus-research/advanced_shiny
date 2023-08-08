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

plotServer <- function(id, data) {
  moduleServer(
    id,
    function(input, output, session) {

       controls <- controlsServer("controls", data)

       output$subtitle <- renderUI({
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
          make_plot(data()$adlb, controls$trta(), controls$param())
       })

    }
  )
}
