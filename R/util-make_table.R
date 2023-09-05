#' Make Lab Table
#' 
#' A table of laboratory values
#'
#' @param data data.frame to use for the table
#' @param trta treatments to include in the table as columns
#' @param param parameters to include in the table as rows
#'
#' @return a data.frame summary to be used in the app
#' @export
make_table <- function(data, trta, param) {
   
   if (!is.null(data) & !is.null(trta) & !is.null(param)) {
      data <- data |>
         dplyr::filter(TRTA %in% trta) |>
         dplyr::filter(PARAM %in% param)
      
      Tplyr::tplyr_table(data, TRTA) |>
         Tplyr::add_layer(
            Tplyr::group_count(AVISIT, PARAM)
         ) |>
         Tplyr::build() |>
         dplyr::select(-c(
            tidyselect::starts_with('ord'))) |>
         dplyr::rename(
            Parameter = row_label1,
            Week = row_label2,
         ) |>
         dplyr::rename_at(
            dplyr::vars(
               dplyr::starts_with('var1_')), list(~sub('var1_', '', .)))
   }
   
}