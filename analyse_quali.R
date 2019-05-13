#Set working directory 
setwd("C:/Cours/4A/S8/Numérique/Maquette/OPEN-chicken")
#library(knitr)
#library(rmarkdown)
#library(questionr)
#library(rlang)
#library(purrr)

#import des données 
data_base<-read.table("C:/Cours/4A/S8/Numérique/Maquette/JEU_2.csv", header = TRUE, sep = ";", dec=",",na.strings="NA")
n<-nrow(data_base)
p<-ncol(data_base)

for (i in 1:p){
  if (is.numeric(data_base[i])) {
    
  }else{
    test_id<-freq(data_base[i])
    if (nrow(test_id) != nrow(data_base[i])){
    envoi<-data_base[i]
    write.csv(envoi, file = "envoi.csv")
    outputFile <- paste("Maquette_colonne_quali_", names(data_base)[i], ".Rmd", sep="")
    render("Maquette_colonne_quali.Rmd", output_format = "html_document", output_file = outputFile, encoding = "UTF-8", output_dir = "res")
    #knit("Maquette_colonne_quali.Rmd", output = outputFile, encoding = "UTF-8" )
    #render("Maquette_colonne_quali.Rmd",outputFile, encoding = "UTF-8")
    }else{
      
    }
  }
}

