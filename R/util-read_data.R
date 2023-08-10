#' Read Data
#' 
#' Function to read in data needed for application
#' 
#' @importFrom odbc odbc
#' @importFrom DBI dbConnect dbDisconnect dbReadTable 
#'
#' @return a list of data.frames for use in the application
#' @export
#'
#' @examples read_data()
read_data <- function() {
   
   # hardcode connection string ----------------------------------------------
   # -- this should probably be its own function
   # -- user should be prompted for UID/PWD, or it should be inherited by Active Directory/etc.
   con <- DBI::dbConnect(odbc::odbc(),
                         Driver = "/opt/rstudio-drivers/mysql/bin/lib/libmysqlodbc_sb64.so",
                         Server = "bd-dev-db.mysql.database.azure.com",
                         database = "bd",
                         UID = "atorusadmin",
                         PWD = "job3l=efREDov!zopH*9",
                         port = 3306,
                         Trusted_Connection = "True")
   return(
      list(
         adsl = DBI::dbReadTable(conn = con, name = "phuse_original_adsl"),
         adae = DBI::dbReadTable(conn = con, name = "phuse_original_adae"),
         adlb = DBI::dbReadTable(conn = con, name = "phuse_original_adlb"),
         advs = DBI::dbReadTable(conn = con, name = "phuse_original_advs")
      )
   )
   
   DBI::dbDisconnect(conn = con)
   
}