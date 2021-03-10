library(testthat)
library(rgovcan)

# PID and Pkg
pid <- "b7ca71fa-6265-46e7-a73c-344ded9212b0"
pkg <- govcan_get_record(pid)

# Search
search_default <- govcan_search("dfo", 10)
search_format <- govcan_search("dfo", 10, format_results = TRUE)

# Resources
id_resources <- govcan_get_resources(search_default)