library(Tplyr)
library(dplyr)

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