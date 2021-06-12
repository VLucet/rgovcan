#' @importFrom crayon blue red green yellow
#' @importFrom cli style_bold style_underline cat_rule cat_line cat_bullet
#' @import utils

msgInfo <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$info, ...)
  message(blue(txt), appendLF = appendLF)
  invisible(txt)
}

msgError <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$cross, ...)
  message(red(txt), appendLF = appendLF)
  invisible(txt)
}

msgSuccess <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$tick, ...)
  message(green(txt), appendLF = appendLF)
  invisible(txt)
}

# x is a resource 
msgDownload <- function(url, fmt, name) {
  sz <- ifelse(fmt != "other", get_remote_file_size(url), "unknown")
  msgInfo(name, paste0("(format: ", fmt, " - size: ", sz, ") "), 
    appendLF = FALSE)
}

msgWarning <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$warning, ...)
  message(yellow(txt), appendLF = appendLF)
  invisible(txt)
}

# convert null to na recursively
null_to_na <- function(x) {
    if (is.list(x)) {
        return(lapply(x, null_to_na))
    } else {
        return(ifelse(is.null(x), NA, x))
    }
}

#
get_remote_file_size <- function(url) {
  hdr <- curlGetHeaders(url)
  tmp <- as.numeric(
    gsub("\\D", "", hdr[grepl("^Content-Length:", hdr)])
  )
  if (length(tmp)) {
    format(structure(tmp, class = "object_size"), units = "auto")
  } else "unknown"
}
