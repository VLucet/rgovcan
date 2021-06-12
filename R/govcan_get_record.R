#' Query OpenCan portal for a specific record (i.e. a CKAN package)
#'
#' @description This function wraps [ckanr::package_show()] to access a specific record
#' (or package, in CKAN terms) given its unique id
#'
#' @param record_id (character) The id of the wanted dataset, which can be found with a
#' search using govcan_search, or on <https://open.canada.ca/en>. The id is of the form
#' "4a2929ce-d6b1-49b0-b520-63be0859c552"
#' @param format_resources (logical) Whether the function should return a formatted output
#' of the resources as a tibble or an unformatted list of resources (default is `FALSE`)
#' @param only_resources (logical) Whether the function should return only the resources
#' from the record (list of files available for download). Resources can also be accessed
#' with govcan_show_ressources
#' @param ... More arguments to be passed on to [ckanr::package_show()]
#'
#' @return If only_resources is `TRUE`, will return only the list of data files (resources)
#' associated with the record queried else it will return all the output of the CKAN query.
#' If format_resources is `TRUE`, the resources are formatted to a tibble.
#'
#' @examples
#' \dontrun{
#' pid <- "b7ca71fa-6265-46e7-a73c-344ded9212b0"
#' pkg <- govcan_get_record(pid)
#' }
#'
#' @export
govcan_get_record <- function(record_id,
                              format_resources = FALSE,
                              only_resources = FALSE,
                              ... = NULL){
  # Search message
  msgInfo("Searching for dataset with id: ", record_id)

  # Perform the query
  if (format_resources) {
    as = "table"
  } else {
    as = "list"
  }
  query_results <- suppressWarnings(ckanr::package_show(id = record_id,
                                       as = as,
                                       ... = NULL))

  # Message the title of the record
  msgInfo(paste0("Record found: \"", query_results$title, "\""))

  # Only output resources if required
  if (only_resources) {
    if (format_resources) {
      query_out <- tibble::as_tibble(query_results$resources)
    } else  {
      query_out <- query_results$resources
    }
  } else {
    if (format_resources) {
      query_results$resources <- tibble::as_tibble(query_results$resources)
      query_out <- query_results
    } else {
      query_out <- query_results
    }
  }
  query_out
}
