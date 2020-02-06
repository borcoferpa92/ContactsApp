
#' @title leerConfig
#'
#' @param path 
#'
#' 
#' @import XML
#' @import logging
#' @import methods
#' 
#'
#' @examples
leerConfig <- function(path){
  library(XML)
  library(methods)
  library(logging)
  configPath <- paste0(path, 'config/config.xml')
  
  tryCatch(expr = {
    
    # Leer el xml y convertirlo a lista.
    config <- XML::xmlToList(xmlParse(file = configPath))
    
  }, error = function(e){
    logerror('Config no encontrado en su ruta. Verifica que se llama config.xml',
             logger = 'log')
    stop()
  })
  
  loginfo('Config leído.', logger = 'log')
  
  validateConfigNodes(config)
  
  config$predictorasNumericas <- trimws(strsplit(config$columnas$predictorasnumericas, ',')[[1]])
  loginfo('Llegas aquí', logger = 'log')
  
  return(config)
}





#' @title ValidateConfigNodes
#'
#' @param config 
#'
#' 
#'
#' @import logging
validateCongifNodes <- function(config){
  
  nodoPrincipal <- identical(names(config), c('input', 'columnas'))
  nodoInput <- identical(names(config$input), c('name', 'sep'))
  nodoColumnas <- identical(names(config$columnas), c('PredictorasNumericas', 
                                                      'FuenteOriginal', 
                                                      'DominioMail', 
                                                      'Fechas', 
                                                      'Target', 
                                                      'Llamada'))
  nodoFechas <- identical(names(config$columnas$Fechas), c('creacion', 'ultima_mod', 
                                                           'apertura_ultimo', 'envio_ultimo', 
                                                           'apertura_primero', 'envio_primero', 
                                                           'visita_primero', 'visita_ultimo', 
                                                           'tiempo'))
  nodos <- c(nodoPrincipal = nodoPrincipal, nodoInput = nodoInput, nodoColumnas = nodoColumnas, nodoFechas = nodoFechas)
  check <- all(nodos)
  
  if(!check){
    
    nodosMalos <- names(nodos)[!nodos]
    logerror(paste0('Los nodos: ', paste(nodosMalos, collapse = ', '), 
                    ' están mal estructurados', logger = 'log'))
    stop()
  }
  
}
