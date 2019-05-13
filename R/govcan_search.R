#' Query OpenCan portal for datasets matching keywords
#'
#' @description This function wraps ckanr::package_search() to search for any records
#' matching a given set of jeywords within the open Canada portal
#'
#' @param keywords (character) A set of keywords to query
#' @param records (numeric) The number of matching records to return from the CKAn query
#' (number of rows in the JSON output)
#' @param only_results (logical) Whether the function should return only the results
#' @param format_results (logical) Whether the function should return a formatted output
#' of the results as a tibble or an unformatted list (default) of CKAN packages
#' @param ... More arguments to be passed on to ckanr::package_search()
#'
#' @return If only_results is TRUE, will return only the results of the search, else it
#' will return all the output of the CKAN query. If format_results is true, the results
#' are formatted to a tibble when possible.
#'
#' @export

govcan_search <- function(keywords,
                          records = 10,
                          only_results = FALSE,
                          format_results = FALSE,
                          ... = NULL) {

  # Search message
  message("Searching the Open Portal for records matching: ",
          paste(keywords, collapse = ", "))

  # Collate all keywords
  keywords_collated <- paste0(keywords,"+", collapse = "")
  keywords_collated <- substr(keywords_collated,1, nchar(keywords_collated)-1)

  # Perform query
  if (format_results == TRUE) {
    as = "table"
  } else {
    as = "list"
  }
  query_results <- ckanr::package_search(q = keywords_collated,
                                         rows = records,
                                         as = as,
                                         ... = NULL)
  if (format_results == TRUE) {
    query_results$results <- dplyr::as_tibble(query_results$results)
  }

  # Message how many records were found
  message("CKAN query: ", query_results$count,
          " records found for keywords: ", paste(keywords, collapse = ", "))

  # Message if more records than can be get were found
  if (query_results$count > records){
    message(paste0(query_results$count), " matching records were found, ",
            records, " records were returned")
  }

  # Only output results if required
  if (only_results == TRUE) {
    query_out <- query_results$results
  } else {
    query_out <- query_results
  }
  query_out
}
