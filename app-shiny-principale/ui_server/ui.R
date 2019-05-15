
  
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
  # Application title
  titlePanel("Test APPLI3"),
  
  # Sidebar with a slider input for number of bins 
    sidebarPanel(
      
      # Boutons pour choisir le format puis télécharger le jeu de données----
    #  radioButtons('format', 'Format du document à éditer :', c('PDF', 'HTML', 'Word'),
    #               inline = TRUE),
      # Boutons DL----
     # downloadButton("downloadData", "Télécharger"),
    downloadButton("downloadColonnes", "TéléchargerColonnes"),
      
    downloadButton("downloadLignes", "TéléchargerLignes"),
    # Copy the line below to make an action button
  #  actionButton("action", label = "Action"),
    
  #  hr(),
 #   fluidRow(column(2, verbatimTextOutput("value"))),
    
    
  
    # Show a plot of the generated distribution
      mainPanel(
        
        # Output: Data file ----
        tableOutput("table"),width = 20)
       # plotOutput("test")
      
    )
  ))
