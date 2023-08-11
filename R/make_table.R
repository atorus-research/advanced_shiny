#' Make Lab Table
#' 
#' A table of laboratory values
#'
#' @param data data.frame to use for the table
#' @param trta treatments to include in the table as columns
#' @param param parameters to include in the table as rows
#' 
#' @importFrom dplyr filter group_by summarise
#' @importFrom Tplyr tplyr_table add_layer group_count build
#'
#' @return a ggplot2 object to be used inside the app
#' @export
make_table <- function(data, trta, paramcd) {
   
   if (!is.null(data) & !is.null(trta) & !is.null(param)) {
      data <- data |>
         dplyr::filter(TRTA %in% trta) |>
         dplyr::filter(PARAM %in% param) |>
         dplyr::group_by(TRTA, PARAM, AVISITN) |>
         dplyr::summarise(AVAL = mean(AVAL), .groups = 'keep')
      
      Tplyr::tplyr_table(data$adlb, TRTA) |>
         Tplyr::add_layer(
            Tplyr::group_count(PARAMCD)
         ) |>
         Tplyr::build()
   }

}
