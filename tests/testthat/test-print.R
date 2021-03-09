context("Printing")
pid <- "b7ca71fa-6265-46e7-a73c-344ded9212b0"
res <- govcan_get_record(pid)

test_that("print as expected", {
  expect_output(print(res), "<CKAN Package> b7ca71fa-6265-46e7-a73c-344ded9212b0")
})
