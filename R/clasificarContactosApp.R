

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
  
  loginfo('Leyendo el config...', logger = 'log')
  config <- leerConfig(path)
  loginfo('Config leído.', logger = 'log')
  
  loginfo('Leyendo los datos', logger = 'log')
  datos <- leerDatos(config, path)
  loginfo('Datos leídos.', logger = 'log')
  
  loginfo('Procesando los datos...', logger = 'log')
  datos <- preProcesarDatos(datos, config)
  loginfo('Datos procesados.', logger = 'log')
  browser()
  
  loginfo('Ejecucion finalizada! Felicidades! =)', logger = 'log')
  
  
   },error = function(e){
    logerror('La aplicación ha petado.',
             logger = 'log')
    stop()
    
  },finally = {
    loginfo("Fin de la ejecucion.", logger = 'log')
    removeHandler(writeToFile, logger = 'log')
    })
}

