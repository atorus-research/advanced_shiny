data <- read_data()$adlb

test_that("make_table generates no table without param data", {
   expect_null(make_table(data, unique(data$TRTA), NULL))
})


test_that("make_plot generates no table without trta data", {
   expect_null(make_table(data, NULL, unique(data$PARAM)))
})

test_that("make_plot generates a plotly object", {
   table <- make_table(data, unique(data$TRTA), unique(data$PARAM))
   expect_true("data.frame" %in% class(table))
})

test_that("make_table generates a data.frame with 5 columns", {
   table <- make_table(data, unique(data$TRTA), unique(data$PARAM))
   expect_equal(length(colnames(table)), 5)
})


test_that("make_table generates a data.frame with 216 rows", {
   table <- make_table(data, unique(data$TRTA), unique(data$PARAM))
   expect_equal(nrow(table), 216)
})

