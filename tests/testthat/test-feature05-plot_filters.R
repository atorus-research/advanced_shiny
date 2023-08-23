app <- here::here("app.R")
driver_app <- shinytest2::AppDriver$new(app, timeout = 10000)

testthat::describe("Feature 01: Dashboard connects to data", {
   
   plotly_obj <- jsonlite::fromJSON(driver_app$get_values()$output[['plot-plot']])
   
   it("a plot is drawn with treatments lines of 
      [Placebo Xanomeline High Dose Xanomeline Low Dose] 
      with 18 facets", {
      
      facets <- plotly_obj$x$layout$annotations$text[-c(1,2)]
      expect_equal(length(facets), 18)
      
      treatments <- unique(plotly_obj$x$data$name)
      expected <- c("Placebo", "Xanomeline High Dose", "Xanomeline Low Dose")
      expect_equal(expected, treatments)
   })
   
   it("remove Placebo from the treatment dropdown,
      plots now have two lines and the placebo line is removed from the legend", {
      
      driver_app$set_inputs(
         'plot-controls-trta' = c("Xanomeline High Dose", "Xanomeline Low Dose")
      )
         
      driver_app$click("plot-controls-trta")
      
      new_plotly_obj <- jsonlite::fromJSON(driver_app$get_values()$output[['plot-plot']])
      treatments <- unique(new_plotly_obj$x$data$name)
      
      expected <- c("Xanomeline High Dose", "Xanomeline Low Dose")
      expect_equal(expected, treatments)
      
   })
   
   it("remove Sodium (mmol/L) from the parameter list,
      there are now 17 facets in the plot", {
         
         driver_app$set_inputs(
            'plot-controls-param' = c(
               "Alanine Aminotransferase (U/L)",
               "Albumin (g/L)",               
               "Alkaline Phosphatase (U/L)",
               "Aspartate Aminotransferase (U/L)",
               "Bilirubin (umol/L)",
               "Blood Urea Nitrogen (mmol/L)" ,   
               "Calcium (mmol/L)",
               "Chloride (mmol/L)",              
               "Cholesterol (mmol/L)",
               "Creatine Kinase (U/L)",
               "Creatinine (umol/L)",
               "Gamma Glutamyl Transferase (U/L)",
               "Glucose (mmol/L)","Phosphate (mmol/L)",            
               "Potassium (mmol/L)","Protein (g/L)"
            )
         )
         
         driver_app$click("plot-controls-trta")
      
      facets <- plotly_obj$x$layout$annotations$text[-c(1,2)]
      expect_equal(length(facets), 17)
   })
   
})

driver_app$stop()