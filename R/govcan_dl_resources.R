#' Download the resources attached to a specific record or (i.e. a CKAN package)
#' or to a stack of packages,
#'
#' @description Download resources attached to a specific record or (i.e. a CKAN package)
#' or to a stack of packages
#'
#' @param resources An object of the class ckan_package_stack or ckan_package, or an id of
#' a specific record or (i.e. a CKAN package), or an object of type ckan_resource or
#' ckan_resource_stack
#' @param file_formats (character vector) A character vector with file formats to be
#' donwloaded, any of :
#' \enumerate{
#'   \item CSV
#'   \item JSON
#'   \item SHP
#' }
#' @param where (string) One of "session" is files have to be charged in the session
#' or a path to the folder in which to download the files
#'
#' @export
govcan_dl_resources <- function(resources,
                                ...) {
  UseMethod("govcan_dl_resources")
}

#' @export
govcan_dl_resources.ckan_resource <- function(resource,
                                              file_formats = c("CSV"),
                                              where = getwd()){
  all_formats <- unlist(resource$format)
  wanted_indices <- (all_formats %in% file_formats)

  if (wanted_indices == TRUE){
    if (where == "session"){

      message("Warning: the session option is currently not working well due to issues in ckanr")
      ckanr::fetch(resource$url, store = "session")
      write_import_messgae(resource)

    } else if (where != "session"){

      resource_name <- get_resource_name(resource)
      path <- create_storing_path(where, resource_name)

      ckanr::fetch(resource$url, store = "disk", path = path)
      write_dl_messgae(resource, path)

    }
  } else {
    message("Nothing matching, no download")
  }
}

#' @export
govcan_dl_resources.ckan_resource_stack <- function(resources,
                                                    file_formats = c("CSV"),
                                                    where = getwd()){

  all_formats <- unlist(purrr::map(resources, ~.x$format))
  wanted_indices <- which(all_formats %in% file_formats)

  if (length(wanted_indices) > 0 ){
    if (where == "session"){

      message("Warning: the session option is currently not working well due to issues in ckanr")

      for (resource in wanted_indices){
        resource_tmp <-  resources[[resource]]

        ckanr::fetch(resource_tmp$url, store = "session")
        write_import_messgae(resource_tmp)
      }

    } else if (where != "session"){

      for (resource in wanted_indices){

        resource_tmp <-  resources[[resource]]

        resource_name <- get_resource_name(resource_tmp)
        path <- create_storing_path(where, resource_name)

        ckanr::fetch(resource_tmp$url, store = "disk", path = path)
        write_dl_messgae(resource_tmp, path)

      }
    }
  }
}


# Helpers function for govcan_dl_resources

get_resource_name <- function(resource_tmp){
  name_extracted <- unlist(stringr::str_extract_all(resource_tmp$name,
                                                    stringr::boundary("word")))
  extension <- resource_tmp$format

  if (extension == "SHP"){
    extension <- "zip"
  }

  resource_name <- paste0(c(name_extracted, ".", extension),collapse = "")
}

create_storing_path <- function(where, resource_name){
  if (where == "wd"){
    path <- paste0(getwd(),"/", resource_name)
  } else {
    path <- paste0(where, resource_name)
  }
  path
}

write_import_messgae <- function(resource_tmp){
  cat("Dataset ", resource_tmp$name, " imported successfully to session")
}

write_dl_messgae <- function(resource_tmp, path){
  cat(" ---------------------------------------------------------------- \n")
  cat("",resource_tmp$format, "file named", resource_tmp$name, "downloaded successfully \n")
  cat(" path to file is:", path, "\n")
  cat(" ---------------------------------------------------------------- \n")
}
