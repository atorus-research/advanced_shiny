app <- here::here("app.R")

driver_app <- shinytest2::AppDriver$new(app, load_timeout = 30000, timeout = 100000)
# this function also has the arguments:
# -- load_timeout: if init takes a long time 
# -- timeout: default value is to wait for updated, this can be hardset
data <- read_data()$adlb

testthat::describe("Feature 01: Dashboard connects to data", {
   
   # headless browser was created 
   # but now we need to
   # wait for these inputs to be populated
   driver_app$wait_for_value(input = 'plot-controls-trta')
   driver_app$wait_for_value(input = 'plot-controls-param')
   
   
   it("Treatments prepopulated with all options", {
     actual <- driver_app$get_value(input = 'plot-controls-trta')
     expected <- unique(data$TRTA)
     expect_equal(actual, expected)
   })
   
   it("Parameters prepopulated with all options", {
      actual <- driver_app$get_value(input = 'plot-controls-param')
      expected <- unique(data$PARAM)
      expect_equal(actual, expected)
   })
                   
})

driver_app$stop()