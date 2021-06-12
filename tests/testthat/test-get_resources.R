
test_that("getting resources work", {

  skip_on_cran()

  expect_equal(class(id_resources), "list")
  expect_equal(length(id_resources), 10)
  expect_equal(class(id_resources[[1]]), "ckan_resource_stack")

  expect_equal(class(id_resources_character), "ckan_resource_stack")
  expect_equal(length(id_resources_character), 6)

})
