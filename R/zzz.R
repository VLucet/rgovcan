#' @importFrom crayon blue red green yellow
#' @importFrom cli style_bold

msgInfo <- function(...) {
  txt <- paste(cli::symbol$info, ...)
  message(blue(txt))
  invisible(txt)
}
msgError <- function(...) {
  txt <- paste(cli::symbol$cross, ...)
  message(red(txt))
  invisible(txt)
}
msgSuccess <- function(...) {
  txt <- paste(cli::symbol$tick, ...)
  message(green(txt))
  invisible(txt)
}
msgWarning <- function(...) {
  txt <- paste(cli::symbol$warning, ...)
  message(yellow(txt))
  invisible(txt)
}

