make_table <- function(data) {
   tplyr_table(data$adlb, TRTA) %>%
      add_layer(
         group_count(PARAMCD)
      ) %>%
      build()
}
