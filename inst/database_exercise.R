
# store credentials -------------------------------------------------------
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


# create connection -------------------------------------------------------
con <- DBI::dbConnect(odbc::odbc(),
                      Driver = "mysql",
                      Server = options()$mysql$Server,
                      database = options()$mysql$database,
                      UID = options()$mysql$UID,
                      PWD = options()$mysql$PWD,
                      port = options()$mysql$port,
                      Trusted_Connection = options()$mysql$Trusted_Connection)


# view available tables ---------------------------------------------------
DBI::dbListTables(con)



# write dplyr code to query databases -------------------------------------
# -- write a query using dplyr + any available table
dplyr::tbl(con, "TABLE_NAME")



# -- write a SQL query using a string ----------------------------------------
query <- "SELECT * FROM ..."


DBI::dbGetQuery(con, query)
