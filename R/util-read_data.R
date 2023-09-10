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


# provide DB options ------------------------------------------------------
   # options can be configured:
   # - at a user level, by the user
   # - at a user level, by an administrator
   # - at a usergroup level, by an administrator
   # - in a variety of different ways
   # - this is just an example of specifying options and using in a connection string
   options(
      mysql = list(
         Driver = "/opt/rstudio-drivers/mysql/bin/lib/libmysqlodbc_sb64.so",
         Server = "bd-dev-db.mysql.database.azure.com",
         database = "bd",
         UID = "atorusadmin",
         PWD = "job3l=efREDov!zopH*9",
         port = 3306,
         Trusted_Connection = "True"
      )
   )
   
# create connection to DB -------------------------------------------------
   con <- DBI::dbConnect(odbc::odbc(),
                         Driver = options()$mysql$Driver,
                         Server = options()$mysql$Server,
                         database = options()$mysql$database,
                         UID = options()$mysql$UID,
                         PWD = options()$mysql$PWD,
                         port = options()$mysql$port,
                         Trusted_Connection = options()$mysql$Trusted_Connection)
   
# create query ------------------------------------------------------------
   
   # investigate datasets and columns that are actually used in the application
   # - the smaller the better!
   # - be specific!
   query_adlb <- "SELECT TRTA, PARAM, AVAL, AVISIT, AVISITN FROM phuse_original_adlb"
   

# execute query -----------------------------------------------------------
   adlb <- list(adlb = DBI::dbGetQuery(conn = con, query_adlb))
   

# disconnect from DB ------------------------------------------------------
   DBI::dbDisconnect(conn = con)
   

# return data -------------------------------------------------------------
   return(adlb)
   
}