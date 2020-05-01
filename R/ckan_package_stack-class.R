#' ckan_package_stack class and helpers
#'
#' @param x a list
#' @keywords internal

new_ckan_package_stack <- function(x = list()){
  structure(x,
            class = "ckan_package_stack",
            dim = length(x))
}

#' @export
print.ckan_package_stack <- function(x, ...) {
  cli::cat_rule(paste("<CKAN Package Stack with", dim(x), "Packages>"))
  cli::cat_line()
  if (dim(x) > 5) {
    cat("  First 5 packages:  \n")
    cli::cat_line()
    purrr::map(x[seq_len(5)], print_ckan_package_custom)
  } else {
    cat("  Packages:  \n")
    cli::cat_line()
    purrr::map(x[1:dim(x)], print_ckan_package_custom)
  }
}

# Custom printing function for packages inside a stack
print_ckan_package_custom <- function(x, ...) {
  cat(paste0("<CKAN Package> ", x$id), "\n")
  cat("  Title: ", x$title, "\n", sep = "")
}
