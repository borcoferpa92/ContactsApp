

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
  
  library(logging)
  
  tryCatch(expr = { 
  
  #Generar el manejador de log.
    
  # path <- "~/Desktop/DATA_BOOTCAMP/WEEK7/clasificarContactos/"
  
  addHandler(writeToFile, logger = 'log', file = paste0(path, "/log/logfile.log"))
  loginfo('Empezamos la app...', logger = 'log')
  
  loginfo('Leyendo el config...', logger = 'log')
  config <- leerConfig(path)
  loginfo('Config leido.', logger = 'log')
  
  loginfo('Leyendo los datos', logger = 'log')
  datos <- leerDatos(config, path)
  loginfo('Datos leidos.', logger = 'log')
  
  loginfo('Procesando los datos...', logger = 'log')
  splitDatos <- preProceso(datos, config)
  loginfo('Datos procesados.', logger = 'log')
  
  loginfo('Generando el modelo...', logger = 'log')
  output <- generarModelo(splitDatos, config)
  loginfo('Modelo Generado', logger = 'log')
  
  loginfo('Generando output...', logger = 'log')
  generarOutput(output, config, path)
  loginfo('Output generado.', logger = 'log')

  
  loginfo('Ejecucion finalizada con exito! Felicidades! =)', logger = 'log')
  
  
   },error = function(e){
    logerror('La aplicacion ha petado.',
             logger = 'log')
    stop()
    
  },finally = {
    loginfo("Fin de la ejecucion.", logger = 'log')
    removeHandler(writeToFile, logger = 'log')
    })
}
