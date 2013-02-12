##' Install a package just for the current session
##'
##' Install a package just for the current session
##' @param pack package name
##' @param path path to install

tmp.install.package <- function(pack, path="/tmp") {
  print("totototititatatutu")
  firstpath <- .libPaths()[1]
  .libPaths(c(firstpath, path))
  install.packages(pack, dependencies=TRUE, lib=path)
}

##' Copy a device to a temp png file
##'
##' @param path path to the png file

dev2png <- function(path="/tmp/temp.png") {
  dev <- dev.copy(png, file=path, width=480, height=480)
  dev.off(dev)
}
