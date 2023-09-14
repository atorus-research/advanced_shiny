res <- testthat::test_package(package = "bdasap") %>% 
   dplyr::as_tibble()

# check if any tests were skipped
# -- we want this to all be FALSE, so we negate with ! to expect a TRUE condition
tests_skipped <- !any(res$skipped)

# check if any errors
# -- we want this to all be FALSE, so we negate with ! to expect a TRUE condition
tests_errors <- !any(res$error)

# check that all tests passed
# -- we want all tests to pass, so this should be true
tests_passed <- all(as.logical(res$passed))


if (tests_skipped && tests_errors && tests_passed) {
   rsconnect::deployApp(appDir = here::here())
} else {
   print("Test errors found...")
}
