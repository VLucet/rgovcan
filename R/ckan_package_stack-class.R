#' ckan_package_stack class
#'
#' The ckan_package_stack class is a wrapper around the [ckan_package][ckanr::as.ckan_package]
#' class from [ckanr][ckanr], which allows to stack multiple packages together. It
#' comes with a custom print function.
#'
#' @param x A list of [ckan_packages][ckanr::as.ckan_package].
#' @keywords internal
#'
#' @return
#' An object of class ckan_package_class.
#'
#' @examples
#' \dontrun{
#' query_results <- suppressWarnings(ckanr::package_search(q = "dfo",
#'                                                         rows = 3,
#'                                                         as = "list"))
#' query_out <- rgovcan:::new_ckan_package_stack(query_results$results)
#' }

new_ckan_package_stack <- function(x = list()){
  structure(x,
            class = "ckan_package_stack",
            dim = length(x))
}

#' @export
print.ckan_package_stack <- function(x, ...) {
  cat_rule(paste("<CKAN Package Stack with", dim(x), "Packages>"))
  cat_line()
  if (dim(x) > 5) {
    cat("  First 5 packages:  \n")
    cat_line()
    Map(print_ckan_package_custom, x[seq_len(5)])
  } else {
    cat("  Packages: ")
    cat_line()
    Map(print_ckan_package_custom, x[seq_len(dim(x))])
  }
}

# Custom printing function for packages inside a stack
print_ckan_package_custom <- function(x, ...) {
  cat_bullet(paste0("<CKAN Package> ", x$id), bullet = "arrow_right")
  cat("  Title: ", x$title, "\n", sep = "")
}
