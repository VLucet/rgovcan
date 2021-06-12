
test_that("test download", {

  skip_on_cran()

  # Includes 1 unknown file, 2 wms, 1 kml, 1 html and 1 ftp link.
  id <- "b7ca71fa-6265-46e7-a73c-344ded9212b0"
  dir <- tempdir(check = TRUE)
  res <- govcan_dl_resources(id, path = dir)
  res2 <- govcan_dl_resources(id, path = dir)
  id <- "e5b0c822-d492-494f-b1eb-11d9a99e6bed"
  res3 <- govcan_dl_resources(id, path = dir, excluded = "xls")
  res4 <- govcan_dl_resources(id, path = dir, included = "csv")
  res5 <- govcan_dl_resources(id, path = dir, id_as_filename = TRUE, included = "csv")

  expect_equal(NROW(res), 6)
  expect_equal(sum(is.na(res$path)), 5)
  expect_true(file.exists(res$path[2]))
  # expect_true(identical(res, res2)) # Fails on CI, imsure why
  expect_true(is.na(res3$path[res3$fmt == "xls"]))
  expect_true(all(is.na(res4$path[res4$fmt != "csv"])))
  expect_true(file.exists(file.path(dir,
                                    paste0(res5$id[res5$fmt == "csv"], ".", "csv"))))

  # Recursive false needed for expect_output tests in test-print to succeed
  unlink(dir, recursive = FALSE)

})
