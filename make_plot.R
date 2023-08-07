library(ggplot2)
library(dplyr)

make_plot <- function(data, trta, param) {

      if (!is.null(data) & !is.null(trta) & !is.null(param)) {
         data <- data |>
            filter(TRTA %in% trta) |>
            filter(PARAM %in% param) |>
            group_by(TRTA, PARAM, AVISITN) |>
            summarise(AVAL = mean(AVAL), .groups = 'keep')

         plot <- ggplot(data, aes(x = AVISITN, y = AVAL, group = TRTA, color = TRTA)) +
            geom_point() +
            geom_line() +
            facet_wrap(.~PARAM, scales = "free_y")

         suppressWarnings(print(plot))

      }

}
