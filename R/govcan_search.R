#' Query OpenCan portal for datasets (CKAN packages) matching keywords
#'
#' @description This function wraps [ckanr::package_search()] to search for any
#' records matching a given set of keywords within the Open Canada Portal.
#'
#' @param keywords (character vector) A set of keywords to query.
#' @param records (numeric) The number of matching records to return from the
#' CKAN query (number of rows in the JSON output), default to 10.
#' @param only_results (logical) Whether the function should return only the
#' results without the query metadata (default is `TRUE`).
#' @param format_results (logical) Whether the function should return a
#' formatted output of the results as a `tibble` or an unformatted version under
#' the form of a list of CKAN packages (default is `FALSE`).
#' @param ... More arguments to be passed on to [ckanr::package_search()].
#'
#' @return If `only_results` is `TRUE` and `format_results` is `FALSE`
#' (recommended), will return only the results of the search as a
#' `CKAN_package_stack`. If `only_results` is `FALSE`, will return a list
#' including also the query metadata. If `format_results` is `TRUE`, the
#' function formats the output as a data frame (not CKAN packages).
#'
#' @examples
#' \dontrun{
#' search <- govcan_search("dfo", 10)
#' search_format <- govcan_search("dfo", 10, format_results = TRUE)
#' search_list <- govcan_search("dfo", 10, only_results = FALSE)
#' search_list_format <- govcan_search("dfo", 10, format_results = TRUE,
#'                                    only_results = FALSE)
#' }
#'
#' @export
govcan_search <- function(keywords,
                          records = 10,
                          only_results = TRUE,
                          format_results = FALSE,
                          ...) {

  # Search message
  kwds <- paste(keywords, collapse = ", ")
  msgInfo("Searching the Open Portal for records matching:", kwds)

  # Collate all keywords
  keywords_collated <- paste(keywords, collapse = "+")

  # Perform query
  as <- ifelse(format_results, "table", "list")
  query_results <- suppressWarnings(ckanr::package_search(q = keywords_collated,
                                         rows = records,
                                         as = as,
                                         ...))

  if (format_results) {
    query_results$results <- tibble::as_tibble(query_results$results)
  }

  # Message how many records were found
  msgInfo("CKAN query:", style_bold(query_results$count),
    "records found for keywords:", kwds)

  # Message if more records than can be get were found
  if (query_results$count > records) {
    msgInfo(style_bold(query_results$count), "matching records were found,",
            style_bold(records), "records were returned")
  }

  # Only output results if required
  if (only_results) {
    if (as == "list") {
      query_out <- new_ckan_package_stack(query_results$results)
    } else {
      query_out <- query_results$results
    }
  } else {
    if (as == "list") {
      query_out <- query_results
    } else if (as == "table") {
      query_out <- query_results
    }
  }

  query_out
}
