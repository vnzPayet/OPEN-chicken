library(shiny)
#install.packages(shinydashboard)
library(shinydashboard)

options(encoding ="UTF-8")

##########   UI   ##########

ui <- dashboardPage(
    
    #Titre
    dashboardHeader(title = "Projet OPEN-chicken"),
    
    #Menu sur le côté
    dashboardSidebar(
        sidebarMenu(
            menuItem("Quali", tabName = "quali", icon = icon("chart-bar")),
            menuItem("Quanti", tabName = "quanti", icon = icon("chart-pie")),
            menuItem("Ligne", tabName = "ligne", icon = icon("bars"))
        )
    #Dernière ligne de dashboardSidebar    
    ),
    
    #Contenu du reste de la page
    dashboardBody(
        # On décide de faire un Body par menuItem avec tabItems
        tabItems(
            # QUALI
            tabItem(tabName = "quali",
                    h2("Quali"),
                    #fluidRow uniquement dans le 1er tabItem
                    fluidRow(
                        box("TEST 1"),
                        
                        box("TEST 2"
                        )
                    )
            ),
            
            # QUANTI
            tabItem(tabName = "quanti",
                    h2("Quanti"),
                    fluidRow(
                    box("TEST 1"),
                    
                    box("TEST 2"
                    )
                    )
            ),
            
            # LIGNE
            tabItem(tabName = "ligne",
                    h2("Ligne"),
                    fluidRow(
                    box("TEST 1"),
                    
                    box("TEST 2"
                    )
                    )
            )
        #Dernière ligne de tabItems    
        )
    # Dernière ligne de DashboardBody
    )
#Dernière ligne de dashboardPage 
)


########## SERVER ##########
server <- function(input, output) {

#Dernière ligne de SERVER    
}

# Run the application 
shinyApp(ui = ui, server = server)
