
# Version 1: One Mega App


Files:
- app.R
- `read_data.R` used in app.R via `source`
- `make_plot.R` used in app.R via `source`
- `make_table.R` used in app.R via `source`
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


# version 6

### Files:
```
---
# created tree with:
fs::dir_tree()
---
├── DESCRIPTION
├── NAMESPACE
├── R
│   ├── bdasap_app.R
│   ├── mod-controls.R
│   ├── mod-plot.R
│   ├── mod-table.R
│   ├── util-make_plot.R
│   ├── util-make_table.R
│   ├── util-read_data.R
│   └── util-write_inputs.R
├── README.md
├── app.R
├── git-advanced_shiny.Rproj
├── inst
│   ├── proviz.R
│   ├── reactlog.R
│   └── www
│       └── styles.css
└── man
    ├── bdasap_app.Rd
    ├── controlsServer.Rd
    ├── controlsUI.Rd
    ├── make_plot.Rd
    ├── make_table.Rd
    ├── plotServer.Rd
    ├── plotUI.Rd
    ├── read_data.Rd
    └── write_inputs.Rd
```

### References
- [Engineering Production-Grade Shiny Apps](https://engineering-shiny.org/version-control.html#automated-testing)
- [](https://github.com/rstudio/shiny-workflows)

### Step-by-Step
1. Cleaned up package structure and all flags that were thrown by running `devtools::check()`.
2. Created a file called `.github` at the root directory.
3. Created a file called `R-CMD-check.yaml` in the `.github` directory.
4. Copy/pasted code from [here](https://github.com/rstudio/shiny-workflows#usage)
5. Pushed code to test.
  - After GitHub Action didn't run, commented out the line `# branches: [main, rc-**]` so the action will run on any push.
  - After the above didn't work, changed to `on: push`.
  - After the above didn't work, ran `usethis::use_github_action()` and chose the `check-standard` option. Then realized that step 2 should have included making a `.github/workflows/R-CMD-check.yaml` path. I was missing the `workflows` folder.
  
 The above is the troubleshooting workflow, and here is the better way to implement.
1. Cleaned up package structure and all flags that were thrown by running `devtools::check()`.
2. Run `usethis::use_github_action()`.
3. TODO: evaluate if the checks from [here](https://github.com/rstudio/shiny-workflows#usage) are overkill/suggest a good first CI implementation for testing.
```
.github
└── workflows
    └── R-CMD-check.yaml
```
