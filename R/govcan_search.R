#' Query OpenCan portal for datasets (CKAN packages) matching keywords
#'
#' @description This function wraps ckanr::package_search() to search for any records
#' matching a given set of keywords within the Open Canada Portal
#'
#' @param keywords (character vector) A set of keywords to query
#' @param records (numeric) The number of matching records to return from the CKAN query
#' (number of rows in the JSON output), default to 10
#' @param only_results (logical) Whether the function should return only the results
#' without the query metadata (default is TRUE)
#' @param format_results (logical) Whether the function should return a formatted output
#' of the results as a tibble or an unformatted version under the form of a list of
#' CKAN packages (default is FALSE)
#' @param ... More arguments to be passed on to ckanr::package_search()
#'
#' @return If only_results is TRUE and format_results is FALSE (recommended), will return
#' only the results of the search as a CKAN_package_stack. If only_results is FALSE,
#' will return a list including also the query metadata. If format_results is TRUE, the
#' function formats the output as a data.frame (not CKAN packages)
#'
#' @export
govcan_search <- function(keywords,
                          records = 10,
                          only_results = TRUE,
                          format_results = FALSE,
                          ... = NULL) {

  # Search message
  message("Searching the Open Portal for records matching: ",
          paste(keywords, collapse = ", "))

  # Collate all keywords
  keywords_collated <- paste0(keywords, "+", collapse = "")
  keywords_collated <- substr(keywords_collated, 1, nchar(keywords_collated)-1)

  # Perform query
  if (format_results == TRUE) {
    as = "table"
  } else if (format_results == FALSE){
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
    if (as == "list"){
      query_out <- new_ckan_package_stack(query_results$results)
    } else {
      query_out <- query_results$results
    }
  } else {
    if (as == "list"){
      query_out <- query_results
    } else if (as == "table"){
      query_out <- query_results
    }
  }

  query_out
}
