#' ckan_package_stack class and helpers
#'
#' @param x a list

new_ckan_package_stack <- function(x = list()){
  structure(x,
            class = "ckan_package_stack",
            dim = length(x))}

#' @export
print.ckan_package_stack <- function(x, ...) {
  cat("<CKAN Package Stack with", dim(x), "Packages> \n")
  cat(" \n")
  if (dim(x)> 5) {
    cat("  First 5 packages:  \n")
    cat(" \n")
    purrr::map(x[1:5], print_ckan_package_custom)
  } else {
    cat("  Packages:  \n")
    cat(" \n")
    purrr::map(x[1:dim(x)], print_ckan_package_custom)
  }
}

# Custom printing function for packages inside a stack
print_ckan_package_custom <- function(x, ...) {
  cat(paste0("<CKAN Package> ", x$id), "\n")
  cat("  Title: ", x$title, "\n", sep = "")
}
