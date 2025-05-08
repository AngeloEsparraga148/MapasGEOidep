


install.packages('pak')
library(pak)
pak::pkg_install('ambarja/geoidep')

install.packages("ggspatial")
install.packages("ggplot2")
install.packages("dplyr")


# Cargar las librerías necesarias
library(geoidep)
library(ggplot2)
library(ggspatial)
library(dplyr)

# Automatización
mapa_ubicacion <- function(departamento_nombre, provincia_nombre, distrito_nombre) {
  
  # Descarga de límites politicos
  departamentos <- get_departaments()
  provincias <- get_provinces()
  distritos <- get_districts()
  
  # Filtracion los datos
  departamento <- departamentos %>% filter(nombdep == departamento_nombre)
  provincia <- provincias %>% filter(nombdep == departamento_nombre)
  distrito <- distritos %>% filter(nombdist == distrito_nombre)
  
  # Gráfico
  ggplot() + 
    geom_sf(data = departamento, 
            fill = "#8B8989", 
            color = "black", 
            alpha = 0.5) + 
    geom_sf(data = provincia, 
            fill = NA, 
            color = "black", 
            alpha = 0.5) +
    geom_sf(data = distrito, 
            fill = "red", 
            color = NA, 
            alpha = 0.5) +
    geom_sf_text(data = provincia, aes(label = nombprov), size = 3, color = "black") +
    geom_sf_text(data = distrito, aes(label = nombdist), size = 4, color = "black") + 
    theme_minimal() +
    annotation_north_arrow(location = "tl") + 
    annotation_scale() +  
    ggtitle(paste("Mapa de Ubicación"), subtitle = paste(departamento_nombre, "-", provincia_nombre, ", ", distrito_nombre)) + 
    labs(caption = "Fuente: Elaboración propia")  
}

# Los nombres se copian tal cual de las columnas nombdep, nombprov y nombdist
# puedes visualizar esto con el siguiente codigo
View(distritos)

# Ejecución de la función con los valores deseados

mapa_ubicacion("CUSCO", "PARURO", "ACCHA") 


