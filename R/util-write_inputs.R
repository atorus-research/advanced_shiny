#' Write Inputs
#' 
#' Function to write the user session info 
#' 
#' @param lst list of reactive values from the application
#'
#' @export
#' @examples write_inputs(all_inputs)
write_inputs <- function(lst) {
   
# get user info -----------------------------------------------------------
# -- again, this could come from Active Directory or another more accurate source
   user <- list(Sys.info()) |> 
      dplyr::bind_rows() |> 
      dplyr::pull(user)
   

# convert selection list to table -----------------------------------------
# -- add user
# -- add time
   user_selection_cache <- purrr::imap(lst, function(selected, control_name) {
      dplyr::tibble(
         user = user,
         control_name = control_name,
         selected = selected,
         time = as.character(Sys.time())
         )
   }) %>% 
      purrr::list_rbind()
   

# connect to database -----------------------------------------------------
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
   
   con <- DBI::dbConnect(odbc::odbc(),
                         Driver = options()$mysql$Driver,
                         Server = options()$mysql$Server,
                         database = options()$mysql$database,
                         UID = options()$mysql$UID,
                         PWD = options()$mysql$PWD,
                         port = options()$mysql$port,
                         Trusted_Connection = options()$mysql$Trusted_Connection)
   
# append user selections to table -----------------------------------------
   DBI::dbAppendTable(conn = con, name = "user_selections", value = user_selection_cache)

# disconnect from DB ------------------------------------------------------
   DBI::dbDisconnect(conn = con)

# create a new table for user selections ----------------------------------
# - only need to do this once!
#   DBI::dbCreateTable(conn = con, name = "user_selections", fields = user_selection_cache)
   
   if (nrow(user_selection_cache) > 0) {
      logger::log_info(sprintf("[ %s ] rows added to [ `user_selections` ] table for user [ %s ]", nrow(user_selection_cache), user))
   }

}
