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

readcsv.tc <- function(text, ...) {
  read.csv(textConnection(text), header=TRUE, ...)
}

##' Get code block from a SO question
##' 
##' @param id question id 
##' @param index index of the code block to return (one number only)
##' @param cat.output cat the content of the code blocks
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
cat.so <- function (id, index=NULL) { 
  get.so.code(id=id, index=index, cat.output=TRUE)
}


##' Copy and paste from Stack Overflow into R session
##'
##' By Ananda Mahto : http://chat.stackoverflow.com/transcript/message/8028201#8028201

read.so <- function(sep = "", header = TRUE) {
  suppressWarnings(
    read.table(text = gsub("^#", "", readLines("clipboard")),
               header = header, stringsAsFactors = FALSE,
               sep = sep))
}