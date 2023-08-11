#' Write Inputs
#' 
#' Function to write the user session info 
#' 
#' @param lst list of reactive values from the application
#'
#' @export
#' 
#' @examples 
#' all_inputs <- utils::sessionInfo()
#' write_inputs(all_inputs)
write_inputs <- function(lst) {
   print(lst)
}
