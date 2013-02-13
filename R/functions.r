##' Install a package just for the current session
##' 
##' @param pack package name
##' @param path path to install

tmp.install.package <- function(pack, path="/tmp") {
  ## Add 'path' to .libPaths, and be sure that it is not
  ## at the first position, otherwise any package during
  ## this session would be installed into 'path'
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

##' Read table data directly from a string
##' 
##' @title 
##' @param text text string
##' @param ... arguments passed to read.table

read.tc <- function(text, ...) {
  read.table(textConnection(text), header=TRUE, ...)
}

##' Read CSV data directly from a string
##' 
##' @title 
##' @param text text string
##' @param ... arguments passed to read.table

readcsv.tc <- function(text) {
  read.csv(textConnection(text), header=TRUE, ...)
}
