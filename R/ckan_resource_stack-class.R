#' ckan_resource_stack class and helpers
#'
#' @param x a list

new_ckan_resource_stack <- function(x = list()){
  structure(x,
            class = "ckan_resource_stack",
            dim = length(x))}

#' @export
print.ckan_resource_stack <- function(x, ...) {
  cat("<CKAN Resource Stack with", dim(x), "Resource> \n")
  cat(" \n")
  if (dim(x)> 5) {
    cat("  First 5 resource:  \n")
    cat(" \n")
    purrr::map(x[1:5], print_ckan_resource_custom)
  } else {
    cat("  Resources:  \n")
    cat(" \n")
    purrr::map(x[1:dim(x)], print_ckan_resource_custom)
  }
}

# Custom printing function for packages inside a stack
print_ckan_resource_custom <- function(x, ...) {
  cat(paste0("<CKAN Resource> ", x$id), "\n")
  cat("  Name: ", x$name, "\n", sep = "")
  cat("  Format: ", x$format, "\n", sep = "")
}
