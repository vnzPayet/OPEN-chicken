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
 
  output$table <- renderTable({
    myligne<- input$ligne1
    dataset <- read.csv("../data/JEU_1.csv",header=TRUE, sep=";", dec=",")
    
    write.csv(dataset[myligne,],file = "myligne.csv")
    dataset[myligne,]
  })
  
  
  observeEvent(input$do, {
    data_base<-read.table("../data/JEU_1.csv", header = TRUE, sep = ";", dec=",",na.strings="NA")
    i<-8
    #for (i in 1:p){
      if (is.numeric(data_base[,i])==TRUE) {
        test_id<-freq(data_base[,i])
        if (nrow(test_id) != nrow(data_base[i])){
          envoi<-data_base[i]
          write.csv(envoi, file = "../tmp/envoi.csv")
          outputFile <- paste("Maquette_colonne-quanti_", names(data_base)[i], ".Rmd", sep="")
          knit("../scriptsRapports_Rmd/Maquette_colonne-quanti.Rmd", output = outputFile, encoding = "UTF-8")
          render(outputFile, encoding = "UTF-8", output_dir = "res")
        }else {
            
          }
      }else{
        test_id<-freq(data_base[,i])
        if (nrow(test_id) != nrow(data_base[i])){
          envoi<-data_base[i]
          write.csv(envoi, file = "envoi.csv")
          outputFile <- paste("Maquette_colonne_quali_", names(data_base)[i], ".Rmd", sep="")
          knit("../scriptsRapports_Rmd/Maquette_colonne_quali.Rmd", output = outputFile, encoding = "UTF-8" )
          render(outputFile, encoding = "UTF-8", output_dir = "res")
        }else{
          
        }
      }
    #}
  })
  
  
  output$downloadLignes <- downloadHandler(
    filename = function() {
      # install.packages("questionr")
      #install.packages("purr")
      library(knitr)
      library(rmarkdown)
      library(questionr)
      library(rlang)
      #library(purrr)
      
      #import des données 
      data_base3<-read.table("../data/JEU_1.csv", header = TRUE, sep = ";", dec=",",na.strings="NA")  #("C:/Cours/4A/S8/Numérique/Maquette/JEU_2.csv"
      data_base<- data_base3
      n<-nrow(data_base)
      p<-ncol(data_base)
      
      for (i in 1:p){
        
          test_id<-freq(data_base[i])
          if (nrow(test_id) != nrow(data_base[i])){
            envoi<-data_base[i]
            write.csv(envoi, file = "envoi2.csv")
            outputFile <- paste("Maquette_Lignes", names(data_base)[i], ".Rmd", sep="")
            #render("Maquette_colonne_quali.Rmd", output_format = "html_document", output_file = outputFile, encoding = "UTF-8", output_dir = "res")
            knit("../scriptsRapports_Rmd/Maquette_Lignes.Rmd", output = outputFile, encoding = "UTF-8" )
            render(outputFile, encoding = "UTF-8")
          }else{
            
          }
        }
      },
      
    content = function(file) {
    }
  )  
})
