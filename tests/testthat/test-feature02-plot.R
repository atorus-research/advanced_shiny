app <- here::here("app.R")
driver_app <- shinytest2::AppDriver$new(app, timeout = 100000)

testthat::describe("Feature 02: Plot created using data from ADLB", {
   
   # we need to wait for the plotly object to exists
   init_values <- driver_app$get_values()
   plotly_obj <- jsonlite::fromJSON(driver_app$get_values()$output[['plot-disp_plot']])
   
   it("a plotly chart is drawn on the page", {
      expect_true("plotly-main" %in% plotly_obj$deps$name)
   })
   
   it("the chart is faceted by parameter", {
      annotations <- plotly_obj$x$layout$annotations$text
      actual <- annotations[-c(1:2)]
      
      expected <- c(
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
         "Potassium (mmol/L)","Protein (g/L)",
         "Sodium (mmol/L)",
         "Urate (umol/L)"
      )
      
      expect_equal(actual, expected)
   })
   
   it("the chart has AVISITN on the x-axis", {
      annotations <- plotly_obj$x$layout$annotations$text
      actual <- annotations[1]
      
      expected <- "AVISITN"
      
      expect_equal(actual, expected)
   })
   
   it("the chart has AVAL on the y-axis", {
      annotations <- plotly_obj$x$layout$annotations$text
      actual <- annotations[2]
      
      expected <- "AVAL"
      
      expect_equal(actual, expected)
   })
   
   
})

driver_app$stop()