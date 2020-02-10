lapply(c("logging", "xgboost", "XML", "bit64"), require, character.only = T)

directorio <- path <- "~/Desktop/DATA_BOOTCAMP/WEEK7/clasificarContactos/"

#' PASTE0 concatena sin espacios y PASTE concatena seleccionando separador.
#' Poniendo collapse = ', ' concatena si tenemos un vector y lo pone junto
#' si no escribe una linea para cada elemento del vector.

setwd(directorio)

# LAPPLY aplica una función a todo lo que hay dentro.
lapply(paste0('R/', list.files(path = 'R/', recursive = TRUE)), source)


debug(clasificarContactosApp)
clasificarContactosApp(directorio)
undebug(clasificarContactosApp)
