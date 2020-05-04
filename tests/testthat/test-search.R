context("Search")

out1 <- govcan_search("dfo", 10)
out2 <- govcan_search("dfo", 10, format_results = TRUE)

test_that("test format", {
  expect_equal(length(out1), 10)
  expect_equal(NROW(out1), 10)
})