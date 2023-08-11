data <- make_data()

test_that("make_plot generates no plot without param data", {
   expect_null(make_plot(data$adlb, unique(data$trta), NULL))
})

test_that("make_plot generates no plot without trta data", {
   expect_null(make_plot(data$adlb, NULL, unique(data$param)))
})

test_that("make_plot generates a plot when supplied with trta and param data", {
   plotObj <- make_plot(data$adlb, unique(data$trta), unique(data$param))
})


