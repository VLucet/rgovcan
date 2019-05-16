#' Query OpenCan portal for resources matching a specific record (i.e. a CKAN package)
#'
#' @description To sue this function, it isimportant to have retrieved records with the
#' default options of the otehr functions in this package. This function returns either a
#' formatted tibble (default) or a list of all available data files (resources) for a
#' given record (package)
#'
#' @param record_id (character) Id of the wanated dataset, of the form
#' "4a2929ce-d6b1-49b0-b520-63be0859c552"
#' @param query_results (list or data.frame) The results of a call to opencan_search()
#'
#' @return If format is TRUE, will return a tibble of available file formats for a
#' given datset or query, else it will return an equivalent list (default).
#'
#' @export

govcan_get_resources <- function(record_id = NULL,
                                 query_results = NULL) {

  # If a record ID is directly given to the function
  if (!is.null(record_id)){
    resources_output <- govcan_get_record(record_id = record_id,
                                          only_resources = TRUE)
  } else if (!is.null(query_results)){
    if ("results" %in% names(query_results)) {
      resources_output <- query_results$results$resources
    } else if  ("resources" %in% names(query_results)){
      resources_output <- query_results$resources
    } else {
      if (inherits(query_results, "list")){
        resources_output <- purrr::map(query_results, .f = ~.x[["resources"]])
      } else if (inherits(query_results, "data.frame")){
        resources_output <- query_results
        message("The query results are already a list of resources")
      }

    }
  }
  resources_output
}
