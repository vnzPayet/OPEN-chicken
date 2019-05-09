#06/05/2019
#Nathan JEAN et Juliette ARCHAMBAUX
#Code qui ne fonctionne pas

##    UI    ##

menuItem("Editer des rapports", tabName = "edit", icon = icon("clipboard")),


#Pour visualiser un fichier .md
#includeMarkdown("lettreR.md")

# Pour l'impression
tabItem(tabName = "edit",
        fluidRow(
          #Choix du document
          box ("Documents disponibles à l'impression",
               navlistPanel("Rapports",
                            tabPanel("Colonne Quanti",
                                     h4("Rapport Colonne Quanti")
                            ),
                            tabPanel("Colonne Quali",
                                     h4("Rapport Colonne Quali")
                            ),
                            tabPanel("Ligne Quanti",
                                     h4("Rapport Ligne Quanti")
                            ),
                            tabPanel("Ligne Quali",
                                     h4("lettreR.Rmd")
                            )
               )
          ),
          #Impression
          box( "Impression du document",
               radioButtons('format', 'Format du document à éditer :', c('PDF', 'HTML', 'Word'),
                            inline = TRUE),
               downloadButton('editionrapport')
          )
        )
)



##  SERVER  ##

function(input, output) {
  output$editionrapport <- downloadHandler(
    filename = function() {
      paste('my-report', sep = '.', switch(
        input$format, PDF = 'pdf', HTML = 'html', Word = 'docx'
      ))
    },
    content = function(file) {
      src <- normalizePath('report.Rmd')
      
      # temporarily switch to the temp dir, in case you do not have write
      # permission to the current working directory
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, 'report.Rmd', overwrite = TRUE)
      
      library(rmarkdown)
      out <- render('report.Rmd', switch(
        input$format,
        PDF = pdf_document(), HTML = html_document(), Word = word_document()
      ))
      file.rename(out, file)
    }
  )
}
