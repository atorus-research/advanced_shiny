app <- here::here("app.R")
driver_app <- shinytest2::AppDriver$new(app, timeout = 100000)

testthat::describe("Feature 04: Table can be filtered by treatment and parameter", {
   
   # we need to wait for the plotly object to exists
   init_values <- driver_app$get_values()
   
   # simulate clicking the table tab
   driver_app$run_js("document.querySelectorAll('[data-value=\"Table\"]')[0].click()")
   
   # get the table object
   table_obj <- jsonlite::fromJSON(driver_app$get_values()$output[['table-table']])
   
   it("a table is drawn with 5 columns and 18 grouped rows", {
      expect_equal(length(table_obj$x$tag$attribs$columns$id), 5)
      grouping <- table_obj$x$tag$attribs$groupBy
      expect_equal(
         length(unique(table_obj$x$tag$attribs$data[[grouping]])),
         18
      )
   })
   
   it("remove Placebo from the Treatments dropdown the table has 4 columns", {
      
      driver_app$set_inputs(
         'table-controls-trta' = c("Xanomeline High Dose", "Xanomeline Low Dose")
      )
      
      new_table_obj <- jsonlite::fromJSON(driver_app$get_values()$output[['table-table']])
      
      expect_equal(length(new_table_obj$x$tag$attribs$columns$id), 4)
      
   })
   
   it("remove Sodium (mmol/L) from the Parameters dropdown,
      the table now has 17 grouped rows, 
      and no rowname with the text Sodium (mmol/L)", {
         
         driver_app$set_inputs(
            'table-controls-param' = c(
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
               "Urate (umol/L)"
            )
         )
         
         new_table_obj <- jsonlite::fromJSON(driver_app$get_values()$output[['table-table']])
         grouping <- new_table_obj$x$tag$attribs$groupBy
         
         expect_equal(
            length(unique(new_table_obj$x$tag$attribs$data[[grouping]])),
            17
         )
         
         expect_true(!"Sodium (mmol/L)" %in% new_table_obj$x$tag$attribs$data[[grouping]])
      
   })
   
   
})

driver_app$stop()