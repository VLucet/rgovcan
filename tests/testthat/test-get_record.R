context("Get records")
pid <- "b7ca71fa-6265-46e7-a73c-344ded9212b0"
res <- govcan_get_record(pid)

test_that("test format", {
  expect_equal(class(res), "ckan_package")
  expect_equal(res$id, pid)
})