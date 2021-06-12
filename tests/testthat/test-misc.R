
test_that("Misc functions work as expected", {

  skip_on_cran()

  expect_message(rgovcan:::msgError("Error"), "Error")
  expect_message(rgovcan:::msgSuccess("Success"), "Success")
  expect_message(rgovcan:::msgWarning("Warning"), "Warning")

  expect_true(is.na(rgovcan:::null_to_na(NULL)))
  expect_identical(rgovcan:::null_to_na(list(NULL, NULL)), list(NA, NA))

})
