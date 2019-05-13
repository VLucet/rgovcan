#' Query OpenCan portal for a specific dataset
#'
#' @description Return
#'
#' One of @param record_id or @param query_results
#' @param record_id Id of the wanated dataset, of the form
#' "4a2929ce-d6b1-49b0-b520-63be0859c552"
#' @param query_results The results of a call to `opencan_search`
#' @param domain Domain name for the OpenCan API being querried
#'
#' @return If format is TRUE, will return a dataframe of available file formats for a
#' given datset or query, else it will return the unformatted json R object from
#' jsonlite::fromJSON
#'
#' @export

opencan_get_ressources <- function(record_id = NULL,
                                   query_results = NULL,
                                   domain = "https://open.canada.ca/data/en/api/3/") {

  if (!is.null(record_id)){

    results <- opencan_get_dataset(id = record_id)
    resources_output <- dplyr::as_tibble(results$resources)

  } else if (!is.null(query_results)){

    if (inherits(query_results, "list")){

      resources_output <- dplyr::as_tibble(query_results$resources)

    } else if(inherits(query_results, "data.frame")){

      resources_output <- query_results$resources

    }


  }

  resources_output
}
