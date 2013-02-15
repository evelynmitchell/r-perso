##' Install a package and its dependencies just for the current session
##' 
##' @param pack package name
##' @param dependencies dependencies argument passed to install.packages
##' @param ... further arguments passed to install.packages()
##' @export
tmp.install.packages <- function(pack, dependencies=TRUE, ...) {
  ## Add 'path' to .libPaths, and be sure that it is not
  ## at the first position, otherwise any package during
  ## this session would be installed into 'path'
  path <- tempdir()
  firstpath <- .libPaths()[1]
  .libPaths(c(firstpath, path))
  install.packages(pack, dependencies=dependencies, lib=path, ...)
}

##' Copy a device to a temp png file
##'
##' @param path path to the png file
##' @export
dev2png <- function(path="/tmp/temp.png") {
  dev <- dev.copy(png, file=path, width=480, height=480)
  dev.off(dev)
}

##' Read table data directly from a string
##' 
##' @param text text string
##' @param ... arguments passed to read.table
##' @export
read.tc <- function(text, ...) {
  read.table(textConnection(text), header=TRUE, ...)
}

##' Read CSV data directly from a string
##' 
##' @param text text string
##' @param ... arguments passed to read.table
##' @export
readcsv.tc <- function(text, ...) {
  read.csv(textConnection(text), header=TRUE, ...)
}

##' Get code block from a SO question
##' 
##' @param id question id 
##' @param index index of the code block to return (one number only)
##' @param cat.output cat the content of the code blocks
##' @import XML
##' @export
get.so <- function (id, index=NULL, cat.output=FALSE) { 
  doc <- htmlParse(paste("http://stackoverflow.com/questions/",id,sep=""))
  pre.index <- ifelse(is.null(index), "", paste("[",as.character(index),"]",sep=""))
  xpath <- paste("//div[@id=\"question\"]//div[@class=\"post-text\"]//pre",pre.index,"/code",sep="")
  code <- getNodeSet(doc, xpath)
  code <- lapply(code, getChildrenStrings)
  if (cat.output) return(invisible(lapply(code, cat)))
  if (length(code)==1) return(unlist(code))
  code
}

##' Cat code block content from a SO question
##' 
##' @param id question id 
##' @param index index of the code block to cat (one number only)
##' @export
cat.so <- function (id, index=NULL) { 
  get.so(id=id, index=index, cat.output=TRUE)
}
