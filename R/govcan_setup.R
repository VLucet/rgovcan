#' Set or reset the ckanr URL
#'
#' @description Set or reset the ckanr URL to the Open Canada portal URL
#' <https://open.canada.ca/data/en>
#'
#' @param url Open Canada portal URL.
#'
#' @return This function invisibly returns the URL sent as input.
#'
#' @examples
#' \dontrun{
#' govcan_setup("https://open.canada.ca/data/en")
#' }
#'
#' @export

govcan_setup <- function(url = "https://open.canada.ca/data/en") {
  tryCatch({
    ckanr::ckanr_setup(url = url)
    msgInfo("ckanr url set to", suppressWarnings(ckanr::ckan_info()$site_url))
    invisible(url)
  },
  warning = function(e){
    cli::cli_alert_warning("govcan_setup failed, please set ckanr url manually")
  },
  error = function(e){
    cli::cli_alert_warning("govcan_setup failed, please set ckanr url manually")
  })
}
