library(ggplot2)
library(dplyr)
library(plotly)

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
