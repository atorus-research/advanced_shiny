#' Make Lab Plot 
#' 
#' A faceted parameter plot 
#' with an averaged line for each treatment 
#' across the course of a study
#'
#' @param data data.frame to use for the plot
#' @param trta treatments to average for each line over time
#' @param param parameters to facet the plot by
#' 
#' @import ggplot2
#' @importFrom dplyr filter group_by summarise
#'
#' @return a ggplot2 object to be used inside the app
#' @export
make_plot <- function(data, trta, param) {

      if (!is.null(data) & !is.null(trta) & !is.null(param)) {
         data <- data |>
            filter(.data$TRTA %in% trta) |>
            filter(.data$PARAM %in% param) |>
            group_by(.data$TRTA, .data$PARAM, .data$AVISITN) |>
            summarise(AVAL = mean(.data$AVAL), .groups = 'keep')

         plot <- ggplot(data, aes(x = .data$AVISITN, y = .data$AVAL, group = .data$TRTA, color = .data$TRTA)) +
            geom_point() +
            geom_line() +
            facet_wrap(.~PARAM, scales = "free_y")

         suppressWarnings(print(plot))

      }

}
