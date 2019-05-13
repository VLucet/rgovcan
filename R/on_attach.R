.onAttach <- function(libname, pkgname) {
  packageStartupMessage("rgovcan package attached, ckanr url set to https://open.canada.ca/data/en")
  ckanr::ckanr_setup(url = "https://open.canada.ca/data/en")
}
