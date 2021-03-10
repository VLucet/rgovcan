
test_that("print as expected", {
  expect_output(print(pkg), "<CKAN Package> b7ca71fa-6265-46e7-a73c-344ded9212b0")
  expect_output(print(search_default), "<CKAN Package Stack with 10 Packages>")
  expect_output(print(id_resources), "<CKAN Resource Stack with 5 Resource>")
  expect_output(print(id_resources[[1]]), "<CKAN Resource> 0c1b2697-4ba6-4b66-b70f-72445d00443b")
})

