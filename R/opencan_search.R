#' Query OpenCan portal for datasets matching keywords
#'
#' @param keywords A set of keywords to query
#' @param domain Domain name for the OpenCan API being querried
#' @param format Whether the function should return a formatted output
#' @param row_size The number of row to return from the json query
#'
#' @return If format is TRUE, will return a formatted dataframe, else it will return
#' the unformatted json R object from jsonlite::fromJSON
#'
#' @export

opencan_search <- function(keywords,
                           domain = "https://open.canada.ca/data/en/api/3/",
                           format = TRUE,
                           row_size = 10000000) {

  keywords_collated <- paste0(keywords,"+")
  search_url <- paste0(domain, keywords_collated)

  output_json <- purrr::map(search_url, jsonlite::fromJSON)

  if (format == TRUE) {
    output_json
  } else {
    query_out <- output_json
  }
  query_out
}
