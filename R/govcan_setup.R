#' Set or reset the ckanr URL to the Open Canada portal URl "https://open.canada.ca/data/en"
#'
#' @description Set or reset the ckanr URL to the Open Canada portal URl
#' "https://open.canada.ca/data/en"
#'
#' @export
govcan_setup <- function(){
  message("ckanr url set to https://open.canada.ca/data/en")
  ckanr::ckanr_setup(url = "https://open.canada.ca/data/en")
}
