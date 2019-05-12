#' Query OpenCan portal for datasets matching keywords
#'
#' @param keywords A set of keywords to query
#' @param domain Domain name for the OpenCan API being querried
#' @param format Whether the function should return a formatted output
#'
#' @export

opencan_search <- function(keywords,
                           domain = "https://open.canada.ca/data/en/api/3/",
                           format = TRUE) {

  keywords_collated <- paste0(keywords,"+")
  search_url <- paste0(domain, keywords_collated)

  output_json <- purrr::map(search_url, jsonlite::fromJSON)

  if (format == TRUE) {

    NULL

  }

}
