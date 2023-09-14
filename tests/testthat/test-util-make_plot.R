if (Sys.getenv("GITHUB_ACTIONS") != "") {
   source(testthat::test_path("testdata/data.R"))
} else {
   data <- read_data()$adlb
}


test_that("make_plot generates no plot without param data", {
   expect_null(make_plot(data, unique(data$TRTA), NULL))
})

test_that("make_plot generates no plot without trta data", {
   expect_null(make_plot(data, NULL, unique(data$PARAM)))
})

test_that("make_plot generates a plotly object", {
   plotObj <- make_plot(data, unique(data$TRTA), unique(data$PARAM))
   expect_equal(class(plotObj), c("plotly", "htmlwidget"))
})


test_that("make_plot generates a plotly of param N facets", {
   plotObj <- make_plot(data, unique(data$TRTA), unique(data$PARAM))
   expect_equal(
      # remove x-axis and y-axis from annotations
      length(unlist(purrr::map(plotObj$x$layout$annotations, `[`, 'text'))[-c(1,2)]),
      length(unique(data$PARAM))
   )
})

