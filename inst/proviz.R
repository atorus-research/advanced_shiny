library(shiny)
library(profvis)

app <- normalizePath("app.R")
profvis({
   runApp(app)
})
