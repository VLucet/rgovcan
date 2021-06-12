#' ckan_resource_stack class
#'
#' The ckan_resource_stack class is a wrapper around the [ckan_resource][ckanr::as.ckan_resource]
#' class from [ckanr][ckanr], which allows to stack multiple resources together. It
#' comes with a custom print function.
#'
#' @param x A list of [ckan_resources][ckanr::as.ckan_resource].
#' @param ... ignored.
#' @keywords internal
#'
#' @return
#' An object of class ckan_resource_stack
#'
#' @examples
#' \dontrun{
#' query_results <- suppressWarnings(ckanr::package_search(q = "dfo",
#'                                                         rows = 3,
#'                                                         as = "list"))
#' query_out <- rgovcan:::new_ckan_package_stack(query_results$results)
#' Map(govcan_get_resources, query_out)[[1]]
#' }

new_ckan_resource_stack <- function(x = list()){
  structure(x,
            class = "ckan_resource_stack",
            dim = length(x))
}

#' @export
print.ckan_resource_stack <- function(x, ...) {
  cat("<CKAN Resource Stack with", dim(x), "Resource> \n")
  cat_line()
  cat("  Resources:  \n")
  cat_line()
  Map(print_ckan_resource_custom, x[seq_len(dim(x))])
}

# Custom printing function for packages inside a stack
print_ckan_resource_custom <- function(x, ...) {
  cat(paste0("<CKAN Resource> ", x$id), "\n")
  cat("  Name: ", x$name, "\n", sep = "")
  cat("  Format: ", x$format, "\n", sep = "")
}
