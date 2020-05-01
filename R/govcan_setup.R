# ' Set or reset the ckanr URL to the Open Canada portal URL
# <https://open.canada.ca/data/en>
#'
#' @description Set or reset the ckanr URL to the Open Canada portal URL
#' <https://open.canada.ca/data/en>
#'
#' @param url Open Canada portal URL.
#'
#' @export
govcan_setup <- function(url = "https://open.canada.ca/data/en"){
  msgInfo("ckanr url set to", url)
  ckanr::ckanr_setup(url = url)
  invisible(NULL)
}
