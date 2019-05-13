#' Query OpenCan portal for a specific dataset (i.e. a specific)
#'
#' @description Query for a given dataset with an ID. Th ID can be found at the Open
#' Canada website
#'
#' @param record_id Id of the wanated dataset, of the form
#' "4a2929ce-d6b1-49b0-b520-63be0859c552"
#' @param domain Domain name for the OpenCan API being querried
#' @param format Whether the function should return a formatted output
#'
#' @return If format is TRUE, will return a list of the results, else it will return
#' the unformatted json R object from jsonlite::fromJSON
#'
#' @export

govcan_get_dataset <- function(record_id,
                                domain = "https://open.canada.ca/data/en/api/3/",
                                format = TRUE){
  # Search message
  message("Searching for dataset woth id: ", record_id)

  # Construct the search url, with the package_search API function
  search_url <- paste0(domain,
                       "action/package_show?id=", record_id)

  # Extract query
  output_json <- purrr::map(search_url, jsonlite::fromJSON)[[1]]

  if (format == TRUE) {

    # Extract dataframe
    query_results <- output_json$result
    ## Curently outputs a list
    query_out <- query_results

  } else {

    query_out <- output_json

  }
  query_out
}
