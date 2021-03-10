
test_that("test format", {
  expect_equal(class(pkg), "ckan_package")
  expect_equal(pkg$id, pid)
})
