#' @title leerDatos
#'
#' @param config 
#' @param path 
#'
#' @import data.table
#' @import logging
#' 
#' 
leerDatos <- function(config, path){
  
  pathDatos <- paste0(path, 'data/', config$input$name)
  
  tryCatch(expr = {
  
  # Lee los datos y los asigna a una variable..
  datos <- data.table::fread(pathDatos, sep = config$input$sep, 
                             encoding = 'UTF-8', data.table = FALSE)
  }, error = function(e){
    logerror('Datos no encontrados. Verifica config o directorio de datos', 
             logger = 'log')
    stop()
  })
  
  if(nrow(datos) == 0 | ncol(datos) == 0){
    logerror('Datos mal leidos, verifica que tengan un buen formato.',
             logger = 'log')
  }
  
  return(datos)
}

