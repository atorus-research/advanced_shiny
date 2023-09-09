app <- here::here("app.R")
driver_app <- shinytest2::AppDriver$new(app, timeout = 150000)

testthat::describe("Feature 03: Table created using data from ADLB", {
   
   # we need to wait for the plotly object to exists
   init_values <- driver_app$get_values()
   
   # simulate clicking the table tab
   driver_app$run_js("document.querySelectorAll('[data-value=\"Table\"]')[0].click()")
   
   # get the table object
   table_obj <- jsonlite::fromJSON(driver_app$get_values()$output[['table-disp_table']])
   
   it("a table is drawn with 5 columns", {
      expect_equal(length(table_obj$x$tag$attribs$columns$id), 5)
   })
   
   it("the table is grouped by Parameter", {
      expect_equal(table_obj$x$tag$attribs$groupBy, 'Parameter')
   })
   
   it("the table has 18 rows (one for each group)", {
      grouping <- table_obj$x$tag$attribs$groupBy
      expect_equal(
         length(unique(table_obj$x$tag$attribs$data[[grouping]])),
         18
      )
   })
   
   
})

driver_app$stop()