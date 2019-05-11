library(jsonlite)
library(tidyverse)
library(curl)

rm(list=ls())

url <- "https://open.canada.ca/data/en/api/3/action/package_list"
parse_url(url)

url <- "https://open.canada.ca/data/api/3/action/package_search?q=dfo"
dfo_search = fromJSON(url)
dfo_search$result$results$id

url <- paste0(
  "https://open.canada.ca/data/en/api/3/action/package_show?id=",
  dfo_search$result$results$id[5])
first_set <- fromJSON(url)

pel_id <- "4a2929ce-d6b1-49b0-b520-63be0859c552"
url_pel <- paste0(
  "https://open.canada.ca/data/en/api/3/action/package_show?id=",
  pel_id)
pel <- purrr::map(url_pel, jsonlite::fromJSON)
pel_df <- tibble(pel[[1]]$result$resources)

id <- which(pel_df$`pel[[1]]$result$resources`$format == "CSV")
pel_df[id,]
