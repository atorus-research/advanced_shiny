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
#' @importFrom dplyr filter group_by summarise
#' @importFrom ggplot2 ggplot aes geom_point geom_line facet_wrap
#'
#' @return a ggplot2 object to be used inside the app
#' @export
make_plot <- function(data, trta, param) {

      if (!is.null(data) & !is.null(trta) & !is.null(param)) {
         data <- data |>
            dplyr::filter(TRTA %in% trta) |>
            dplyr::filter(PARAM %in% param) |>
            dplyr::group_by(TRTA, PARAM, AVISITN) |>
            dplyr::summarise(AVAL = mean(AVAL), .groups = 'keep')

         plot <- ggplot2::ggplot(data, 
                        ggplot2::aes(
                           x = AVISITN, 
                           y = AVAL, 
                           group = TRTA, 
                           color = TRTA)) +
            ggplot2::geom_point() +
            ggplot2::geom_line() +
            ggplot2::facet_wrap(.~PARAM, scales = "free_y")

         plotly::ggplotly(plot)

      }

}
