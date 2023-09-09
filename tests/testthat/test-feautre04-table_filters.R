app <- here::here("app.R")
driver_app <- shinytest2::AppDriver$new(app, timeout = 100000)

testthat::describe("Feature 04: Table can be filtered by treatment and parameter", {
   
   # we need to wait for the plotly object to exists
   init_values <- driver_app$get_values()
   
   # simulate clicking the table tab
   driver_app$run_js("document.querySelectorAll('[data-value=\"Table\"]')[0].click()")
   
   # get the table object
   table_obj <- jsonlite::fromJSON(driver_app$get_values()$output[['table-disp_table']])
   
   it("a table is drawn with 5 columns and 18 grouped rows", {
      # CODE HERE
   })
   
   it("remove Placebo from the Treatments dropdown the table has 4 columns", {
      # CODE HERE
   })
   
   it("remove Sodium (mmol/L) from the Parameters dropdown,
      the table now has 17 grouped rows, 
      and no rowname with the text Sodium (mmol/L)", {
      # CODE HERE
   })
   
   
})

driver_app$stop()