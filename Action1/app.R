#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

### ressource : https://shiny.rstudio.com/articles/action-buttons.html

library(knitr)
library(rmarkdown)
library(shiny)

ui <- fluidPage(
  actionButton("do", "Generate")
)

server <- function(input, output, session) {
  observeEvent(input$do, {
    data_base<-read.table("../data/JEU_1.csv", header = TRUE, sep = ";", dec=",",na.strings="NA")
    #png("test.png")
    #plot(1, pch=16, col="blue")
    #dev.off()
    i <- 8
    envoi<-data_base[i]
    write.csv(envoi, file = "../tmp/envoi.csv")
    outputFile <- paste("Maquette_colonne-quanti_", names(data_base)[i], ".Rmd", sep="")
    knit("../scriptsRapports_Rmd/Maquette_colonne-quanti.Rmd", output = outputFile, encoding = "UTF-8")
    render(outputFile, encoding = "UTF-8", output_dir = "res")
    
  })
}

shinyApp(ui, server)

