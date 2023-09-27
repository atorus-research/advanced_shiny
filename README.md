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

---

# CI/CD For Testing

### Setup

Check out branch: `Version06-cicd_for_testing`

```
git checkout Version06-cicd_for_testing
```

### Exercises

Exercise 1 (5 mins):

- Use the function `usethis::use_github_action()` to create a "check-release" YAML workflow file.
- At some point in the YAML file, add a step that runs the R code: `Sys.getenv()` to see what the GitHub Actions system environment looks like.


### Solutions

1.) 
```
usethis::use_github_action("check-release")
```

2.)

Modify YAML file (after the `r-lib/actions/setup-r@v2` line) to add:

```

# Need help debugging build failures? Start at https://github.com/r-lib/actions#where-to-find-help
on:
  push:
    branches: [main, master]
  pull_request:
    branches: [main, master]

name: R-CMD-check

jobs:
  R-CMD-check:
    runs-on: ubuntu-latest
    env:
      GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
      R_KEEP_PKG_SOURCE: yes
    steps:
      - uses: actions/checkout@v3

      - uses: r-lib/actions/setup-r@v2
        with:
          use-public-rspm: true

      - uses: r-lib/actions/setup-r-dependencies@v2
        with:
          extra-packages: any::rcmdcheck
          needs: check

      - uses: r-lib/actions/check-r-package@v2

      - name: any name you would like
        run: print("This training session is so much fun!")
        shell: Rscript {0}

```

Notes:

Conditional testing: 

```
if (Sys.getenv("GITHUB_ACTIONS") != "") {
   source(testthat::test_path("testdata/data.R"))
} else {
   data <- read_data()$adlb
}
```
- Unit testing probably shouldn't involve querying a production database.
- Create a small subset of data to unit test with.


# Version08-deploying_to_connect_git

1. Create a manifest file and commit to the branch that should be tracked.
2. Link Posit Connect to the Git repository.

Notes:
- Recommended as step 2! Manually deploy first and make sure everything is working, then take a shot at git-backed deployment.
- Have a `dev` version that is run on CI/CD, and then merge into `prod` to deploy.
  - Create a pull request that runs your CI/CD
  - Once everything passes, you have a good amount of confidence that everything will work when deployed.
  
  

