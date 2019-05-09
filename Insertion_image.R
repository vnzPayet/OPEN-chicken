#06/05/2019
#Juliette ARCHAMBAUX
#Code qui ne fonctionne pas

##UI

# Charger une image
mainPanel(
  imageOutput("isara", width = 100, height = 100)
)


##SERVER

#Insertion d'une image
function(input, output, session) {
  output$isara <- renderImage({
    
    # Return a list containing the filename
    list(src = "isara.png",
         contentType = 'image/png',
         width = 100,
         height = 100,
         alt = "Logo Isara")
  }, deleteFile = FALSE)
}
