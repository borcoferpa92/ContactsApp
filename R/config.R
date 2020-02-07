
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
  
  #loginfo('Config leído.', logger = 'log')
  
  validateConfigNodes(config)
  
  config$columnas$predictorasNumericas <- trimws(strsplit(config$columnas$predictorasNumericas, ',')[[1]])
  
  config$columnas$mails$ratios <- as.logical(config$columnas$mails$ratios)
  
  
  separadoresAceptados <- config$input$sep %in% c(',', ';')
  
  if(!separadoresAceptados){
    
    logerror('Sep solo puede valer "," o ";" .', logger = 'log')
    
  }
  
  return(config)
}





#' @title ValidateConfigNodes
#'
#' @param config 
#'
#' 
#'
#' @import logging
validateConfigNodes <- function(config){
  
  nodoPrincipal <- identical(names(config), c("input", "columnas"))
  nodoInput <- identical(names(config$input), c("name", "sep"))
  nodoColumnas <- identical(names(config$columnas), c("ID", "predictorasNumericas",
                                                      "fuenteOriginal", "dominio_mail",
                                                      "fechas", "mails", "target", "llamada"))
  nodoFechas <- identical(names(config$columnas$fechas), c("creacion", "ultima_mod",
                                                           "apertura_ultimo", "envio_ultimo",
                                                           "apertura_primero", "envio_primero",
                                                           "visita_primero", "visita_ultimo",
                                                           "tiempos"))
  nodoMails <- identical(names(config$columnas$mails), c("mailsDl", "mailsCl", "mailsOp", "ratios"))
  nodos <- c("nodoPrincipal" = nodoPrincipal, "nodoInput" = nodoInput,
             "nodoColumnas" = nodoColumnas, "nodoFechas" = nodoFechas,
             "nodoMails" = nodoMails)
  check <- all(nodos)
  
  if(!check){
    
    nodosMalos <- names(nodos)[!nodos]
    logerror(paste0('Los nodos: ', paste(nodosMalos, collapse = ', '), 
                    ' están mal estructurados', logger = 'log'))
    stop()
  }
  
}
