#' Download the resources attached to a specific record or (i.e. a CKAN package)
#' or to a stack of packages,
#'
#' @description Download resources attached to a specific record or (i.e. a CKAN package)
#' or to a stack of packages
#'
#' @param resources An object of the class ckan_package_stack or ckan_package, or an id of
#' a specific record or (i.e. a CKAN package), or an object of type ckan_resource or
#' ckan_resource_stack
#' @param file_formats (character vector) A character vector with file formats to be
#' donwloaded, any of :
#' \enumerate{
#'   \item CSV
#'   \item JSON
#'   \item SHP
#' }
#' @param where (string) One of "session" is files have to be charged in the session
#' or a path to the folder in which to download the files
#'
#' @export
govcan_dl_resources <- function(resources,
                                ...) {
  UseMethod("govcan_dl_resources")
}

#' @export
govcan_dl_resources.ckan_resource <- function(resources,
                                              file_formats = c("CSV"),
                                              where = getwd()){
  all_formats <- unlist(resources$format)
  wanted_indices <- (all_formats %in% file_formats)
  if (wanted_indices == TRUE){
    if (where == "session"){
      ckanr::fetch(resources$url, store = "session")
    } else if (where != "session"){
      ckanr::fetch(resources$url, store = "disk", path = where)
    }
  } else {
    message("Nothing matching, no download")
  }
}

#' @export
govcan_dl_resources.ckan_resource_stack <- function(resources,
                                                    file_formats = c("CSV"),
                                                    where = getwd()){
  all_formats <- unlist(map(resources, ~.x$format))
  wanted_indices <- which(all_formats %in% file_formats)

  if (length(wanted_indices) > 0 ){
    if (where == "session"){
      map(resources, ~ckanr::fetch(.x$url, store = "session"))
    } else if (where != "session"){
      map(resources, ~ckanr::fetch(.x$url, store = "disk", path = where))
    }
  }
}
