#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
options(encoding ="UTF-8")
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Test du 10 mai PM"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("colonne", "Sélectionner une colonne :", 
                        #multiple permet de choisir plusieurs colonnes
                        choices = c( "Nom_Agri", "Date", "Heure_RDV", "Adresse"),
                            # textOutput(outputId= "cols"),
                            # c( "Nom_Agri", "Date", "Heure_RDV", "Adresse"),
                            # c("Agriculteur", "Date", "Heure du rendez-vous", "Adresse"),
                        multiple = TRUE 
            )
         ),
        
        selectizeInput('x3', 'X3', choices = setNames(state.abb, state.name)),

    
        # Show a plot of the generated distribution
        mainPanel(
           tableOutput(outputId = "table"),
           textOutput(outputId= "cols")
        )
    )
)

# Define Herver logic required to draw a histogram
server <- function(input, output) {

    
    
    output$table <- renderTable({
        donnee <- read.table("EXEMPLE.csv",header=TRUE, na.strings = NA, sep=";")
        
        donnee[,c("Nom_Agri",input$colonne)]
    })
    
    output$cols <- renderText({
        donnee <- read.table("EXEMPLE.csv",header=TRUE, na.strings = NA, sep=";")
        #names(donnee))
        x <- donnee[,input$variable]
        
    output$values <- renderPrint({
        list(names(donnee))
        
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
