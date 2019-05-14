#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
 
  
  # Rentrer le jeu de données dans un tableau
  output$table <- renderTable({
    dataset <- read.csv("JEU_3.csv",header=TRUE, sep=";", dec=",")
    selection <- dataset[c(1:20),]
    
  })
  
  # Télécharger le fichier
#  output$downloadData <- downloadHandler(
 #   filename = function() {
  #    paste('my-report2', sep = ';', ".csv") 
      #switch(
        #Sert à déterminer le format de sortie
       # input$format, PDF = 'pdf', HTML = 'html', Word = 'docx'
     # ))
  #  },
    
  # content = function(file) {
  #   write.csv(selection, file, row.names = FALSE)
  # }
  # )
  
  output$downloadColonnes <- downloadHandler(
    filename = function() {
      #Set working directory 
      setwd("/Users/mathilde/Desktop/APPLI11/")  #("C:/Cours/4A/S8/Numérique/Maquette/OPEN-chicken")
    # install.packages("questionr")
     # install.packages("purr")
      library(knitr)
      library(rmarkdown)
      library(questionr)
      library(rlang)
      library(purrr)
      
      #import des données 
      data_base2<-read.table("/Users/mathilde/Desktop/APPLI11/JEU_3.csv", header = TRUE, sep = ";", dec=",",na.strings="NA")  #("C:/Cours/4A/S8/Numérique/Maquette/JEU_2.csv"
      data_base<- data_base2[c(1:70),c(1:4)]
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
            #render("Maquette_colonne_quali.Rmd", output_format = "html_document", output_file = outputFile, encoding = "UTF-8", output_dir = "res")
            knit("Maquette_colonne_quali.Rmd", output = outputFile, encoding = "UTF-8" )
            render(outputFile, encoding = "UTF-8")
          }else{
            
          }
        }
      }
    },
    
   content = function(file) {
   }
  )

  
  
  output$downloadLignes <- downloadHandler(
    filename = function() {
      #Set working directory 
      setwd("/Users/mathilde/Desktop/APPLI11/")  #("C:/Cours/4A/S8/Numérique/Maquette/OPEN-chicken")
      # install.packages("questionr")
      #install.packages("purr")
      library(knitr)
      library(rmarkdown)
      library(questionr)
      library(rlang)
      library(purrr)
      
      #import des données 
      data_base3<-read.table("/Users/mathilde/Desktop/APPLI11/JEU_1.csv", header = TRUE, sep = ";", dec=",",na.strings="NA")  #("C:/Cours/4A/S8/Numérique/Maquette/JEU_2.csv"
      data_base<- data_base3[c(1:10),c(1:3)]
      n<-nrow(data_base)
      p<-ncol(data_base)
      
      for (i in 1:p){
        
          test_id<-freq(data_base[i])
          if (nrow(test_id) != nrow(data_base[i])){
            envoi<-data_base[i]
            write.csv(envoi, file = "envoi2.csv")
            outputFile <- paste("Maquette_Lignes", names(data_base)[i], ".Rmd", sep="")
            #render("Maquette_colonne_quali.Rmd", output_format = "html_document", output_file = outputFile, encoding = "UTF-8", output_dir = "res")
            knit("Maquette_Lignes.Rmd", output = outputFile, encoding = "UTF-8" )
            render(outputFile, encoding = "UTF-8")
          }else{
            
          }
        }
      },
      
    content = function(file) {
    }
  )  
})
