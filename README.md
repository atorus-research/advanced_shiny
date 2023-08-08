# Version 1 

Files:
- app.R
- make_data.R used in app.R via `source`
- make_plot.R used in app.R via `source`
- `www/styles.R` for custom styling

*`R` files are in our root directory and we have library calls within them.*

Dependencies: 
- `bslib` for dashboard layout
- `dplyr` for data manipulation
- `ggplot2` for plotting
- `haven` for grabbing data from URL

# Version 2 - Now We're a Package

### Files:
* app.R
* DESCRIPTION
* inst
* man
* NAMESPACE
* R
  * make_plot.R
  * make_table.R
  * read_data.R
  * write_inputs.R
* README.md
* www

# Version 3 - Modules

### Files: 

* app.R
* DESCRIPTION
* inst
* man
* NAMESPACE
* R
  * bdasap_app.R
  * mod-controls.R
  * mod-plot.R
  * mod-table.R
  * mod-make_plot.R
  * util-make_plot.R
  * util--make_table.R
  * util-read_data.R
  * util-write_inputs.R
* README.md
* www
