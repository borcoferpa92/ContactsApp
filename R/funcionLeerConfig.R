
#' Leer config
#'
#' @param path 
#'
#' 
#' @import XML
#'
#' @examples
leerConfig <- function(path){
  library(XML)
  library(methods)
  configPath <- paste0(path, 'config.xml')
  result <- xmlParse(file = configPath)
  
  
}