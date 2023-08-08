controlsUI <- function(id) {
  ns <- NS(id)
  tags$div(
     class="custom-flexbox",
     selectInput(ns("trta"), "Treatments", NULL, multiple = TRUE),
     selectInput(ns("param"), "Parameters", NULL, multiple = TRUE, width = '900px')
  )
}

controlsServer <- function(id, data) {
  moduleServer(
    id,
    function(input, output, session) {

       ns <- session$ns

       observeEvent(data(), {
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
       })

       return(
          list(
             trta = reactive(input$trta),
             param = reactive(input$param)
          )
       )

    }
  )
}
