
test_that("test format", {

  skip_on_cran()

  expect_equal(length(search_default), 10)
  expect_equal(NROW(search_format), 10)

  expect_equal(class(search_list), "list")
  expect_equal(class(search_list$results), "list")
  expect_equal(length(search_list), 6)

  expect_equal(class(search_list_format), "list")
  expect_equal(class(search_list_format$results)[1], "tbl_df")
  expect_equal(NROW(search_list_format$results), 10)

})
