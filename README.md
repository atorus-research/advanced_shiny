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


# Using CI/CD Solution

### Exercise 1:

Start with the `version05-cicd` branch, and create a new GitHub Action by using the `{usethis}` R package.
- Use the `check-release` template only, as this is the simplest action that is best for a first pass at configuring your workflow.
- *Optional:* add a few other workflows that you are interested in checking out. Read through them and compare with the `check-release` workflow. 

### Solution 1:

Run the following:

```
usethis::use_github_action(name = "check-release")
```

Note that you will now have the following structure at the top-level of your project:

```
.github
└── workflows
    └── R-CMD-check.yaml
```

Other options include:

```
usethis::use_github_action(name = "test-coverage")
usethis::use_github_action(name = "pkgdown")
usethis::use_github_action(name = "pr-commands")
```


