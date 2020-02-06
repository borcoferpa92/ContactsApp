

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
  
  tryCatch(expr = { 
  #Generar el manejador de log.
    
  # path <- "~/Desktop/DATA_BOOTCAMP/WEEK7/clasificarContactos/"
  
  addHandler(writeToFile, logger = 'log', file = paste0(path, "/log/logfile.log"))
  
  
  loginfo('Empezamos la app...', logger = 'log')
  
  config <- leerConfig(path)
  
  loginfo('Ejecucion finalizada! Felicidades! =)', logger = 'log')
  
  
   },error = function(e){
    logerror('Config no encontrado en su ruta. Verifica que se llama config.xml',
             logger = 'log')
    stop()
    
  },finally = {
    loginfo("Fin de la ejecucion.", logger = 'log')
    removeHandler(writeToFile, logger = 'log')
    })
}
