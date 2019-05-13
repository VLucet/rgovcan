.onAttach <- function(libname, pkgname) {
  # to show a startup message
  packageStartupMessage("rgovcan package attached")
  ckanr::ckanr_setup(url = "http://open.canada.ca/data/en")
}
