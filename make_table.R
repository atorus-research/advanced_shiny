library(Tplyr)
library(dplyr)

make_table <- function(data, trta, paramcd) {
   
   if (!is.null(data) & !is.null(trta) & !is.null(param)) {
      data <- data |>
         filter(TRTA %in% trta) |>
         filter(PARAM %in% param) |>
         group_by(TRTA, PARAM, AVISITN) |>
         summarise(AVAL = mean(AVAL), .groups = 'keep')
      
      tplyr_table(data$adlb, TRTA) |>
         add_layer(
            group_count(PARAMCD)
         ) |>
         build()
   }
   
}