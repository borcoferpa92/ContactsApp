#' @title preProcesarDatos
#'
#' @param datos 
#' @param config 
#'
#' @return
#' @import logging
preProcesarDatos <- function(datos, config){
  
  columnasUtilizadas <- c(config$columnas$ID, config$columnas$predictorasNumericas, 
                          config$columnas$fuenteOriginal,config$columnas$dominio_mail, 
                          config$columnas$fechas$creacion, config$columnas$fechas$ultima_mod,
                          config$columnas$fechas$apertura_ultimo, config$columnas$fechas$envio_primero,
                          config$columnas$fechas$apertura_primero, config$columnas$fechas$envio_primero,
                          config$columnas$fechas$visita_primero, config$columnas$fechas$visita_ultimo,
                          config$columnas$mails$mailsDl, config$columnas$mails$mailsCl,
                          config$columnas$mails$mailsOp, config$columnas$target,
                          config$columnas$llamada)
  
  checkColumnas <- columnasUtilizadas %in% colnames(datos)
  
  check <- all(checkColumnas)
  
  if(!check){
    
    columnasMalas <- names(columnasMalas)[!checkColumnas]
    logerror(paste0('Las columnas: ', paste(columnasMalas, collapse = ', '), 
                    ' no se encuentran en el dataset.', logger = 'log'))
    stop()
  
  }

  datos <- datos[, columnasUtilizadas]
  
  datos[is.na(datos[, config$columnas$mails$mailsOp]), config$columnas$mails$mailsOp] <- 0
  datos[is.na(datos[, config$columnas$mails$mailsDl]), config$columnas$mails$mailsDl] <- 0
  datos[is.na(datos[, config$columnas$mails$mailsCl]), config$columnas$mails$mailsCl] <- 0
  
  if(config$columnas$mails$ratios){
    datos <- createRatios(datos, config)
  }
  
  return(datos)
  
}



#' @title createRatios
#'
#' @param datos 
#' @param config 
#'
#'
createRatios <- function(datos, config){
  
  datos$mails_A_E <- datos[, config$columnas$mails$mailsOp] / datos[, config$columnas$mails$mailsDl]
  datos$mails_C_E <- datos[, config$columnas$mails$mailsCl] / datos[, config$columnas$mails$mailsDl]
  datos$mails_C_A <- datos[, config$columnas$mails$mailsCl] / datos[, config$columnas$mails$mailsOp]
  
  datos$mails_A_E[is.na(datos$mails_A_E)] <- 0
  datos$mails_C_E[is.na(datos$mails_C_E)] <- 0
  datos$mails_C_A[is.na(datos$mails_C_A)] <- 0
  
  return(datos)
  
}
