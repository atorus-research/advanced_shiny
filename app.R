if (!interactive()) {
   sink(stderr(), type = "output")
   tryCatch({
      library(bdasap)
   }, error = function(e) {
      devtools::load_all()
   })
} else {
   devtools::load_all()
}

# Launch the app
bdasap::bdasap_app(runApp = interactive())
