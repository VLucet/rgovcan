#' @importFrom crayon blue red green yellow
#' @importFrom cli style_bold style_underline

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
  class(tmp) <- "object_size"
  format(tmp, "auto", standard = "SI")
}