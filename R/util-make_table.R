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
#' @return a data.frame summary to be used in the app
#' @export
make_table <- function(data, trta, param) {
   
   if (!is.null(data) & !is.null(trta) & !is.null(param)) {
      data <- data |>
         filter(TRTA %in% trta) |>
         filter(PARAM %in% param)
      
      tplyr_table(data, TRTA) |>
         add_layer(
            group_count(AVISIT, PARAM)
         ) |>
         build()
   }
   
}