#' Display or Query resources attached to a specific record or (i.e. a CKAN
#' package) or to a stack of packages
#'
#' @description Display resources attached to a specific record or (i.e. a CKAN package)
#' or to a stack of packages
#'
#' @param x An object of the class `ckan_package_stack` or `ckan_package`, or an
#' id of a specific record or (i.e. a CKAN package).
#'
#' @return A object of class `ckan_resource_stack` or list of ckan_resource_stack objects.
#'
#' @examples
#' \dontrun{
#' search <- govcan_search("dfo", 10)
#' id_resources <- govcan_get_resources(search)
#' }
#'
#' @export
govcan_get_resources <- function(x){
  UseMethod("govcan_get_resources")
}

#' @export
govcan_get_resources.ckan_package_stack <- function(x){
  Map(govcan_get_resources, x)
}

#' @export
govcan_get_resources.ckan_package <- function(x){
  resource_list <- x$resources
  resource_stack <- Map(ckanr::as.ckan_resource, resource_list)
  new_ckan_resource_stack(resource_stack)
}

#' @export
govcan_get_resources.character <- function(x){
  resource_list <- govcan_get_record(record_id = x, only_resources = TRUE,
                                     format_resources = FALSE)
  resource_stack <- Map(ckanr::as.ckan_resource, resource_list)
  new_ckan_resource_stack(resource_stack)
}
