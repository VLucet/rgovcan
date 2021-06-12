
test_that("print as expected", {

  skip_on_cran()

  expect_output(print(pkg),
                "<CKAN Package> b7ca71fa-6265-46e7-a73c-344ded9212b0")
  expect_output(print(search_default),
                "<CKAN Package Stack with")
  expect_output(print(search_small),
                "<CKAN Package Stack with")
  expect_output(print(id_resources[[1]]),
                "<CKAN Resource Stack with")
  expect_output(print(id_resources[[1]][[1]]),
                "<CKAN Resource>")
})

