#' Read Data
#' 
#' Function to read in data needed for application
#' 
#'
#' @return a list of data.frames for use in the application
#' @export
#'
#' @examples read_data()
read_data <- function() {
   return(
      list(
         adsl = haven::read_xpt(url("https://github.com/phuse-org/TestDataFactory/raw/main/Updated/TDF_ADaM/adsl.xpt")),
         adae = haven::read_xpt(url("https://github.com/phuse-org/TestDataFactory/raw/main/Updated/TDF_ADaM/adae.xpt")),
         adlb = haven::read_xpt(url("https://github.com/phuse-org/TestDataFactory/raw/main/Updated/TDF_ADaM/adlbc.xpt")),
         advs = haven::read_xpt(url("https://github.com/phuse-org/TestDataFactory/raw/main/Updated/TDF_ADaM/advs.xpt"))
      )
   )
}
