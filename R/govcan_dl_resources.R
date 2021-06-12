#' Download the resources attached to a specific record or (i.e. a CKAN package)
#' or to a stack of packages
#'
#' @description Download resources attached to a specific record or (i.e. a CKAN
#' package) or to a stack of packages.
#'
#' @param resources An object of class `ckan_package_stack` or `ckan_package`,
#' or a specific resource id, or (i.e. a CKAN package), or an object of type
#' `ckan_resource` or `ckan_resource_stack`.
#' @param excluded (vector of characters) Files of this format(s) will *not* be
#'     downloaded (`NULL` ignores this filter and is the default value).
#' @param included (vector of characters) Only the files of this format(s) will
#'     be downloaded (`NULL` ignores this filter and is the default value).
#' @param path (character) name indicating where to store the data (default is
#'     the current working directory).
#' @param id_as_filename (logical) Use the resource identifier as file name.
#'     This is particularly useful when two different resources have the same filename.
#' @param ... Curl arguments passed on to crul::verb-GET (see [ckanr::ckan_fetch()]).
#'
#' @details
#' File names are handled internally.
#'
#' @return
#' A tibble of the download metadata (file id, package id, url, download path,
#' format, storage location, associated data).
#'
#' @examples
#' \dontrun{
#' id <- "b7ca71fa-6265-46e7-a73c-344ded9212b0"
#' dir <- tempdir(check = TRUE)
#' res <- govcan_dl_resources(id, path = dir)
#' }
#'
#' @export
govcan_dl_resources <- function(resources,
                                excluded,
                                included,
                                path,
                                id_as_filename,
                                ...) {
  UseMethod("govcan_dl_resources")
}

#' @describeIn govcan_dl_resources Method for ckan_resource objects.
#' @export
govcan_dl_resources.ckan_resource <- function(resources,
                                              excluded = NULL,
                                              included = NULL,
                                              path = ".",
                                              id_as_filename = FALSE,
                                              ...) {
  fmt <- tolower(resources$format)
  url <- resources$url
  msgDownload(url, fmt, resources$name)

  if (grepl("^ftp://", url)) {
    out <- empty_entry()
    msgWarning("skipped (ftp not supported yet).")
  } else {
    # select type of files to be downloaded
    tmp <- TRUE
    if (!is.null(excluded))
      tmp <- !(fmt %in% tolower(excluded))
    if (!is.null(included))
      tmp <- fmt %in% tolower(included)

    if (tmp) {
      # extract filename from url
      fl <- extract_filename(url)
      if (!is.null(fl)) {
        if (id_as_filename) {
          fl <- paste0(resources$id, ".", extract_extension(fl))
          flp <- normalizePath(file.path(path, fl), mustWork = FALSE)
        } else {
          flp <- normalizePath(file.path(path, fl), mustWork = FALSE)
        }
        if (file.exists(flp)) {
          # prevents from downloading the same file several times
          msgWarning("skipped (already downloaded).")
          out <- empty_entry("disk", fmt = fmt, path = flp)
        } else {
          out <- suppressWarnings(ckanr::ckan_fetch(url, format = fmt,
              store = "disk", path = flp))
          msgSuccess()
        }
      } else {
        out <- empty_entry(fmt = fmt)
        msgWarning("skipped (not supported).")
      }
    } else {
      out <- empty_entry(fmt = fmt)
      msgWarning("skipped (format not selected).")
    }
  }

  out$url <- url
  out$package_id <- resources$package_id
  out$id <- resources$id
  out <- null_to_na(out)
  out <- structure(as.data.frame(out), class = c("tbl_df", "tbl", "data.frame"))
  ord <- c("id", "package_id", "url", "path", "fmt")
  out[, c(ord, setdiff(names(out), ord))]
}

#' @describeIn govcan_dl_resources Method for `ckan_resource_stack` objects.
#' @export
govcan_dl_resources.ckan_resource_stack <- function(resources, ...) {
  out <- lapply(resources, govcan_dl_resources, ...)
  do.call(rbind, out)
}

#' @describeIn govcan_dl_resources Method for `character` objects.
#' @export
govcan_dl_resources.character <- function(resources, ...) {
  govcan_dl_resources(govcan_get_resources(resources), ...)
}

#' @describeIn govcan_dl_resources Method for `ckan_package` objects.
#' @export
govcan_dl_resources.ckan_package <- function(resources, ...) {
    govcan_dl_resources(resources$id, ...)
}

#' @describeIn govcan_dl_resources Method for `ckan_package_stack` objects.
#' @export
govcan_dl_resources.ckan_package_stack <- function(resources, ...) {
    out <- lapply(lapply(resources, `[[`, "id"), govcan_dl_resources, ...)
    do.call(rbind, out)
}


# HELPERS

empty_entry <- function(store = NA_character_,
                        fmt = NA_character_,
                        data = NULL,
                        path = NA_character_) {
  list(
    store = store,
    fmt = fmt,
    data = data,
    path = path
  )
}

extract_filename <- function(x, sep = "/") {
  # extract the last part of the path or url
  pat <- paste0(".*", sep, "(.+)$")
  tmp <- sub(pat, "\\1", x)
  # check whether it contains file basename + file extension
  # the regex below should cover 99% of common file extensions
  if (grepl('[[:graph:]]+\\.[[:alnum:]\\+-\\!]+$', tmp)) {
    tmp
  } else NULL
}

extract_extension <- function(x) {
  sub('[[:graph:]]+\\.([[:alnum:]\\+-\\!]+)$', "\\1", x)
}
