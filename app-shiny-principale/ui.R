library(shiny)
#install.packages("shinydashboard")
library(shinydashboard)

options(encoding ="UTF-8")

##########   UI   ##########

ui <- dashboardPage(
  
  #Titre ----
  dashboardHeader(title = "Projet OPEN-chicken",
                  
                  dropdownMenu(type = "messages",
                               
                               messageItem(
                                 from = "PROMO 48",
                                 message = "Bienvenue sur notre application Shiny !",
                                 icon = icon("box-open")
                               )
                  )
  ),
  
  
  #Menu sur le côté ----
  dashboardSidebar(
    sidebarMenu(
      menuItem("Bienvenue !", tabName = "bienvenue", icon = icon("chess")),
      menuItem("Import tableau", tabName = "tableau", icon = icon("folder-open")),
      menuItem("Traitement par colonnes", tabName = "colonne", icon = icon("chart-bar")),
      menuItem("Traitement par lignes", tabName = "ligne", icon = icon("bars"))
    )
    #Dernière ligne de dashboardSidebar    
  ),
  
  
  #Contenu du reste de la page ----
  dashboardBody(
    # On décide de faire un Body par menuItem avec tabItems
    tabItems(
      
      # BIENVENUE ----
      tabItem(tabName = "bienvenue",
              h2("Bienvenue dans notre application Shiny !"),
              fluidRow(
                box(title = "Utilisation", solidheader = TRUE, collapsible = TRUE, background = "navy",
                    "Avec cette application web, vous pourrez interpréter vos données :
                            ",br(),"  - En colonne",br(),"  - En ligne ",br(),"  - Et générer des rapports à partir de modèles prédéfinis"),
                
                box(title = "GitHub OPEN-chicken", solidheader = TRUE, collapsible = TRUE, background = "teal",
                    "Le lien vers le git du projet : https://github.com/vnzPayet/OPEN-chicken/tree/master/app-shiny-principale ."
                    ,br(),br(),"Vous y trouverez tous nos codes, scripts et autres jeux de données, 
                        qui nous ont été utiles pour créer cette application web.
                        ",br(),"Vous pouvez vous en inspirer pour ajuster cette application à vos besoins !"),
                
                box(title = "Être à l'aise avec Shinydashboard", solidheader = TRUE, collapsible = TRUE, background = "teal",
                    "Shinydashboard est le package qui a permis de réaliser cette interface plutôt soignée."
                    ,br(),br(),"Vous pouvez prendre en main le package en suivant les conseils et les exemples du lien suivant : 
                            ",br(),br(),"rstudio.github.io/shinydashboard/index.html"),
                box(title = "Auteurs Version 1", solidheader = TRUE, collapsible = TRUE, background = "navy", "ARCHAMBAUX Juliette", 
                    br(),"CHENG Jean Rémi",
                    br(),"LAEBOUSSE Adam",
                    br(),"LECOUR Benoit",
                    br(),"JEAN Nathan",
                    br(),"NAQUIN Samuel",
                    br(),"RIBOUD Mathilde")
              )),
      
      # TABLEAU ----
      tabItem(tabName = "tableau",
              h2("Importer un tableau et afficher les données"),
              
              #Importer un fichier
              fileInput("file1", "Choisir un fichier CSV :",
                        multiple = FALSE,
              ),
              #Afficher le fichier importé
              tableOutput("contents"),
              
              #Sélectionner les colonnes que l'on souhaite afficher 
              
              #selectInput ne permet pas une interaction avec différents tableaux : 
              #il faut choisir SelectizeIput pour avoir une interface dynamique,
              #qui permet de ne pas saisir les noms de colonnes du tableau lu,
              #contrairement à SelectInput. 
              
              #Exemple avec SelectInput
              #selectInput("colonne", "Sélectionner une colonne :", 
              #choices = c( "Nom_Agri", "Date", "Heure_RDV", "Adresse")
              ##multiple permet de choisir plusieurs colonnes
              #multiple = TRUE),
              
              "Sélectionner les données que vous souhaitez afficher :",
              selectizeInput("val", 
                             label = NULL, 
                             choices = #letters[1:5],
                               # names(donnee),  
                               ## Il faut acceder à donnee via les renderTable
                               names("file1"),
                             multiple = TRUE),
              
              #fluidRow permet de faire un alinéa vis-à-vis du SideBar
              fluidRow(
                
                #On peut imaginer mettre un tableau, où bien un graphique...
                ##Pour un tableau
                box(
                  "Visualisation des données - tableau",
                  tableOutput(outputId = "tableau"),
                  textOutput(outputId= "cols")
                ),
                
                ##Pour un graphique
                box("Visualisation des données - graphique",
                    tableOutput("contents"),
                    plotOutput("graph")
                )
                
                #Pour enregistrer les données sélectionnées ----
                #Attention : pour le format pdf, il faut télécharger un package assez lourd.
                #box("Enregistrer ces données :",
                #   background = "navy",
                #   radioButtons('format', 'Format du document à éditer :', c('PDF', 'HTML', 'Word'),
                #             inline = TRUE),
                #   downloadButton("downloadData", "Télécharger")
                #   )
                
              )
      ),
      
      
      
      # COLONNE ----
      tabItem(tabName = "colonne",
              h2("Traitement en colonnes"),
              actionButton("colonnes", "Générer rapport colonne"),
              fluidRow(
                
                tableOutput("table"),width = 20)
              
      ),
      
      
      # LIGNE ----
      tabItem(tabName = "ligne",
              h2("Traitement en lignes"),
              actionButton("ligne_select", "Générer rapport 1 ligne"),
              actionButton("ligne", "Générer rapport toutes les lignes"),
              numericInput("ligne1","ligne à traiter",0), 
              fluidRow(
                tableOutput("table"),width = 20)
                )
      
      #Dernière ligne de tabItems    
    )
    # Dernière ligne de DashboardBody
  )
  #Dernière ligne de dashboardPage 
)