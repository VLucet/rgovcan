.onAttach <- function(libname, pkgname) {
  packageStartupMessage("rgovcan package - alpha release - attached")
  govcan_setup()
}
