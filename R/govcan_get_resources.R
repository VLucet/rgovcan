#' Obtain the list of accessible data files (resources) for a given record (package)
#'
#' @description Return either a list or a formatted tibble listing all available data
#' files (resources) for a given record (package)
#'
#' @param record_id (character) Id of the wanated dataset, of the form
#' "4a2929ce-d6b1-49b0-b520-63be0859c552"
#' @param query_results (list or data.frame) The results of a call to opencan_search()
#' @param format_resources (logical) Whether the function should return a formatted output
#' of the resources as a tibble or an unformatted list (default) of CKAN packages
#'
#' @return If format is TRUE, will return a tibble of available file formats for a
#' given datset or query, else it will return an equivalent list (default).
#'
#' @export

govcan_get_resources <- function(record_id = NULL,
                                 query_results = NULL,
                                 format_resources = FALSE) {


  # if a record ID is directly given to the function
  if (!is.null(record_id)){
    resources_output <- govcan_get_record(record_id = record_id,
                                  format_resources = format_resources,
                                  only_resources = TRUE)
    # Multipel cases ou query
    } else if (!is.null(query_results)){
    if (inherits(query_results, "list")){
      resources_output <- dplyr::as_tibble(query_results$resources)
      } else if(inherits(query_results, "data.frame")){
      resources_output <- query_results$resources
    }
  }
  resources_output
}
