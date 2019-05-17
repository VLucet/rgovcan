#' Set or reset the ckanr URL to the Open Canada portal URl "https://open.canada.ca/data/en"
#'
#' @description Set or reset the ckanr URL to the Open Canada portal URl
#' "https://open.canada.ca/data/en"
#'
#' @export
govcan_setup <- function(url = "https://open.canada.ca/data/en"){
  message(paste0("ckanr url set to ", url))
  ckanr::ckanr_setup(url = url)
}
