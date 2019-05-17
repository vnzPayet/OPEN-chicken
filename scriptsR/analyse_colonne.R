#Set working directory 
library(rmarkdown)


#import des données 
data_base<-read.table("JEU_1.csv", header = TRUE, sep = ";", dec=",",na.strings="NA","-","VIDE")
n<-nrow(data_base)
p<-ncol(data_base)

for (i in 1:p){
  if (is.numeric(data_base[,i])==TRUE) {
    test_id<-freq(data_base[i])
    if (nrow(test_id) != nrow(data_base[i])){
    envoi<-data_base[i]
    write.csv(envoi, file = "envoi.csv")
    outputFile <- paste("Maquette_colonne-quanti_", names(data_base)[i], ".Rmd", sep="")
    #render("Maquette_colonne-quanti.Rmd", output_format = "html_document", output_file = outputFile, encoding = "UTF-8", output_dir = "res")
    knit("Maquette_colonne-quanti.Rmd", output = outputFile, encoding = "UTF-8")
    render(outputFile, encoding = "UTF-8", output_dir = "res")
    }else{
      
    }
    
  }else{
    test_id<-freq(data_base[i])
    if (nrow(test_id) != nrow(data_base[i])){
    envoi<-data_base[i]
    write.csv(envoi, file = "envoi.csv")
    outputFile <- paste("Maquette_colonne_quali_", names(data_base)[i], ".Rmd", sep="")
    #render("Maquette_colonne_quali.Rmd", output_format = "html_document", output_file = outputFile, encoding = "UTF-8", output_dir = "res")
    knit("Maquette_colonne_quali.Rmd", output = outputFile, encoding = "UTF-8" )
    render(outputFile, encoding = "UTF-8", output_dir = "res")
    }else{
      
    }
  }
}

?knit
?render
