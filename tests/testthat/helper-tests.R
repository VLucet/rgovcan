library(testthat)
library(rgovcan)

# PID and Pkg
pid <- "b7ca71fa-6265-46e7-a73c-344ded9212b0"
pkg <- govcan_get_record(pid)
pkg_list_format <- govcan_get_record(pid, format_resources = TRUE)
pkg_list_res <- govcan_get_record(pid, only_resources = TRUE)
pkg_list_res_format <- govcan_get_record(pid, format_resources = TRUE,
                                         only_resources = TRUE)

# Search
search_default <- govcan_search("dfo", 10)
search_small <- govcan_search("dfo", 2)
search_format <- govcan_search("dfo", 10, format_results = TRUE)
search_list <- govcan_search("dfo", 10, only_results = FALSE)
search_list_format <- govcan_search("dfo", 10, format_results = TRUE,
                                    only_results = FALSE)

# Resources
id_resources <- govcan_get_resources(search_default)
id_resources_character <- govcan_get_resources("b7ca71fa-6265-46e7-a73c-344ded9212b0")
