

#' @title clasificarContactosApp
#' @description funcion principal del paquete de clasificarContactos
#'
#' @param path, string
#'
#' 
#' @export
#' @import logging
#' 
#'
#' @author Borja Cobos
clasificarContactosApp <- function(path){
  
  #Generar el manejador de log.
  path <- "~/Desktop/DATA_BOOTCAMP/WEEK7/clasificarContactos/config/"
  addHandler(writeToFile, logger = 'log', file = paste0(path, "/log/logfile.log"))
  loginfo('Empezamos la app...', logger = 'log')
  
  config <- leerConfig(path)
  
  
}