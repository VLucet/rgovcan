#' Display resources attached to a specific record or (i.e. a CKAN package) or to a
#' stack of packages
#'
#' @description Display resources attached to a specific record or (i.e. a CKAN package) or to a
#' stack of packages
#'
#' @param x An object of the class ckan_package_stack or ckan_package
#'
#' @return If format is TRUE, will return a tibble of available file formats for a
#' given datset or query, else it will return an equivalent list (default).
#'
#' @export
govcan_show_resources <- function(x){
  UseMethod("govcan_show_resources")
}

#' @export
govcan_show_resources.ckan_package_stack <- function(x){
  purrr::map(x, govcan_show_resources)
}

#' @export
govcan_show_resources.ckan_package <- function(x){
  resource_list <-  x$resources
  resource_stack <- map(resource_list, ckanr::as.ckan_resource)
  new_ckan_resource_stack(resource_stack)
}
