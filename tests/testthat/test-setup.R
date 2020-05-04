context("Setup")

test_that("check default behavior", {
  govcan_setup("https://open.canada.ca/data/fr")
  expect_equal("https://open.canada.ca", ckanr::ckan_info()$site_url)
  govcan_setup()
  expect_equal("https://open.canada.ca", ckanr::ckan_info()$site_url)
})