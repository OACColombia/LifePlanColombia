#Escoger aleatoriamente dos autores de seis para articulo de datos sonidos

#Autores "fijos"
autores.1 <- c("Yurani", "Angela", "Fernando")

#Total otros autores
total <- c("Paola", "Mailyn", "Zuania", "Angelica", "Kevin", "Orlando")

b <- 10000

#repetir siempre la misma muestra (puede variar de computador a computador)
#set.seed(12345)

# Para guardar las frecuencias
autor_freq <- data.frame(Autor1 = character(), 
                         Autor2 = character(), 
                         Frequencia = numeric(), 
                         stringsAsFactors = FALSE)

# Un "bootstrapping"
for (i in 1:b) {
  # Muestrear dos nombres
  muestra_autores <- sample(total, 2, replace = FALSE)
  
  # Revisar si estos dos nombres ya están en el dataset
  indice_pareja <- which(autor_freq$Autor1 == muestra_autores[1] & 
                           autor_freq$Autor2 == muestra_autores[2] |
                        autor_freq$Autor1 == muestra_autores[2] & 
                          autor_freq$Autor2 == muestra_autores[1])
  
  if (length(indice_pareja) == 0) {
    # Si esta pareja no existe, adicionarla al dataframe con la frecuencia de 1
    autor_freq <- rbind(autor_freq, data.frame(Autor1 = muestra_autores[1], 
                                               Autor2 = muestra_autores[2], 
                                               Frequencia = 1))
  } else {
    # Si la pareja ya existe, aumentar su frecuencia por 1
    autor_freq$Frequencia[indice_pareja] <- autor_freq$Frequencia[indice_pareja] + 1
  }
}

# Ordenar por la frecuencia, de mayor a menor
autor_freq <- autor_freq[order(-autor_freq$Frequencia), ]

# Ver las primeras parejas
head(autor_freq)
