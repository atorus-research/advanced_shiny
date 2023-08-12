data <- read_data()$adlb

test_that("make_plot generates no plot without param data", {
   expect_null(make_plot(data, unique(data$TRTA), NULL))
})

test_that("make_plot generates no plot without trta data", {
   expect_null(make_plot(data, NULL, unique(data$PARAM)))
})

test_that("make_plot generates a plot when supplied with trta and param data", {
   plotObj <- make_plot(data, unique(data$TRTA), unique(data$PARAM))
   expect_equal(class(plotObj), c("gg", "ggplot"))
})


