#' Query OpenCan portal for datasets matching keywords
#'
#' @param keywords A set of keywords to query
#' @param domain Domain name for the OpenCan API being querried
#' @param format Whether the function should return a formatted output
#' @param row_size The number of row in the JSON object to return from the solr query
#'
#' @return If format is TRUE, will return a formatted dataframe, else it will return
#' the unformatted json R object from jsonlite::fromJSON
#'
#' @export

opencan_search <- function(keywords,
                           domain = "https://open.canada.ca/data/en/api/3/",
                           format = TRUE,
                           row_size = 10000) {

  # Collates all keywords
  keywords_collated <- paste0(keywords,"+")
  keywords_collated <- substr(keywords_collated,1, nchar(keywords_collated)-1)

  # Construct the search url, with the package_search API function
  search_url <- paste0(domain,
                       "action/package_search?q=", keywords_collated,
                       "&rows=", row_size)

  # Extract query
  output_json <- purrr::map(search_url, jsonlite::fromJSON)[[1]]

  # Tell the user how many records were found
  message("OpenCan Query: ", output_json$result$count,
          " records found for keywords: ",keywords)

  if (format == TRUE) {

    # Extract dataframe
    query_results <- output_json$result$results
    #
    # More formtting of the results needed, for now outputs dataframe
    #
    query_out <- query_results

  } else {
    query_out <- output_json
  }
  query_out
}
