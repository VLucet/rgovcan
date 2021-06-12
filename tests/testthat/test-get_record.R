
test_that("test format", {

  skip_on_cran()

  expect_equal(class(pkg), "ckan_package")
  expect_equal(pkg$id, pid)

  expect_equal(class(pkg_list_format), "list")
  expect_equal(pkg_list_format$id, pid)
  expect_equal(class(pkg_list_format$resources)[1], "tbl_df")

  expect_equal(class(pkg_list_res), "list")
  expect_equal(length(pkg_list_res), 6)
  expect_equal(length(pkg_list_res[[1]]), 22)

  expect_equal(class(pkg_list_res_format)[1], "tbl_df")
  expect_equal(dim(pkg_list_res_format), c(6, 22))

})
