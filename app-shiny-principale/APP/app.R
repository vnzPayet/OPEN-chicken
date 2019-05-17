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
                        box(title = "Utilisation", solidheader = TRUE, collapsible = TRUE,
                        "Avec cette application web, vous pourrez interpréter vos données :
                            en colonne, en ligne et générer des rapports à partir de modèles prédéfinis !"),
                        
                        box(title = "GitHub OPEN-chicken", solidheader = TRUE, collapsible = TRUE,
                        "Le lien vers le git du projet : https://github.com/vnzPayet/OPEN-chicken/tree/master/app-shiny-principale .
                        Vous y trouverez tous nos codes, scripts et autres jeu de données, 
                        qui nous ont été utiles pour créer cette application web.
                        Vous pouvez vous en inspirer pour ajuster cette application à vos besoins !"),
                        
                        box(title = "Être à l'aise avec Shinydashboard", solidheader = TRUE, collapsible = TRUE,
                            "Shinydashboard est le package qui a permis de réaliser cette interface plutôt soignée.
                            Vous pouvez prendre en main le package en suivant les conseils et les exemples du lien suivant : 
                            https://rstudio.github.io/shinydashboard/index.html .") 
                        
                    )),
            
            # QUALI ----
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
                        
                            #Pour un tableau
                            box(
                            "Visualisation des données - tableau",
                            tableOutput(outputId = "tableau"),
                            textOutput(outputId= "cols")
                               ),
                            
                            #Pour un graphique
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
                    downloadButton("downloadColonnes", "Télécharger Colonnes"),
                    fluidRow(
                    box("TEST 1",
                        numericInput("ligne1","ligne à traiter",0),
                        tableOutput("table"),width = 20)
                    )
                    ),
            
            
            # LIGNE ----
            tabItem(tabName = "ligne",
                    h2("Traitement en lignes"),
                    downloadButton("downloadLignes", "TéléchargerLignes"),
                    fluidRow(
                    box("TEST 1",
                        numericInput("ligne1","ligne à traiter",0),
                        tableOutput("table"),width = 20)
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
    
 ####TABLEAU ----   
    
#Pour importer un fichier dans le Shiny ----
    
    output$contents <- renderTable({
        
    ### Méthode 1 ----    
    #https://shiny.rstudio.com/reference/shiny/0.14/fileInput.html    
        
    #inFile <- input$file1   
    #if (is.null(inFile))
    #    return(NULL)
    
    #read.csv(inFile$datapath, header = input$header)
    
    ### Méthode 2 ----
    #https://shiny.rstudio.com/gallery/file-upload.html
    
        
    req(input$file1)
    
    df <- read.csv(input$file1$datapath,header = TRUE, sep = ";", quote = '"',
                   dec = ".", fill = TRUE, comment.char = "")
    
    #df <- read.csv(input$file1$datapath,
    #               header = input$header,
    #               sep = input$sep,
    #               quote = input$quote)
    
    if(input$disp == "head") {
        return(head(df))
    }
    else {
        return(df)
    }

    })
    
#Pour lire le tableau ----
    output$tableau <- renderTable({
        donnee <- read.table(input$file1$datapath,
                             #"../data/EXEMPLE.csv", 
                             header=TRUE, na.strings = NA, sep=";")
        donnee[,c(input$val)]
    })
    
#Pour afficher les données ---- 
    output$cols <- renderText({
        donnee <- read.table(input$file1$datapath,
                            #"../../data/EXEMPLE.csv",
                            header=TRUE, na.strings = NA, sep=";")
        #names(donnee))
        x <- donnee[,input$variable]
                    })
    
#Même chose pour un graphique ----
    output$graph <- renderPlot({
         
        df <- read.csv(input$file1$datapath,header = TRUE, sep = ";", quote = '"',
                       dec = ".", fill = TRUE, comment.char = "")
        
        
        
    })
    
#PAS UTILE POUR FAIRE FONCTIONNER
   #output$values <- renderPrint({
        #values <- list(names(donnee))
        #values
        #str(values)
        #Permet de vérifier que 
        #})
        
# Pour télécharger les données affichées ----
    output$downloadData <- downloadHandler(
        filename = function() {
            paste('my-report', sep = '.', switch(
                #Sert à déterminer le format de sortie
                input$format, PDF = 'pdf', HTML = 'html', Word = 'docx'
            ))
        },
        content = function(file) {
            write.csv(datasetInput(), file, row.names = FALSE)
        }
    ) 
    
    
    
    

####COLONNE ----

output$table <- renderTable({
    myligne <- input$ligne1
    dataset <- read.csv("../data/JEU_1.csv",header=TRUE, sep=";", dec=",")
    
    write.csv(dataset[myligne,],file = "myligne.csv")
    dataset[myligne,]
    
    
})

output$downloadColonnes <- downloadHandler(
    filename = function() {
        #Set working directory 
        #setwd("/Users/mathilde/Desktop/APPLI11/APPLI12/")  #("C:/Cours/4A/S8/Numérique/Maquette/OPEN-chicken")
        # install.packages("questionr")
        # install.packages("purr")
        library(knitr)
        library(rmarkdown)
        library(questionr)
        library(rlang)
        # library(purrr)
        
        #import des données 
        data_base2<-read.table("../data/JEU_1.csv", header = TRUE, sep = ";", dec=",",na.strings="NA")  #("C:/Cours/4A/S8/Numérique/Maquette/JEU_2.csv"
        data_base<- data_base2
        n<-nrow(data_base)
        p<-ncol(data_base)
        
        for (i in 1:p){
            if (is.numeric(data_base[,i])==TRUE) {
                envoi<-data_base[i]
                write.csv(envoi, file = "envoi.csv")
                outputFile <- paste("Maquette_colonne-quanti_", names(data_base)[i], ".Rmd", sep="")
                knit("Maquette_colonne-quanti.Rmd", output = outputFile, encoding = "UTF-8")
                render(outputFile, encoding = "UTF-8", output_dir = "res")
                
            }else{
                test_id<-freq(data_base[,i])
                if (nrow(test_id) != nrow(data_base[i])){
                    envoi<-data_base[i]
                    write.csv(envoi, file = "envoi.csv")
                    outputFile <- paste("Maquette_colonne_quali_", names(data_base)[i], ".html", sep="")
                    knit("Maquette_colonne_quali.Rmd", output = outputFile, encoding = "UTF-8" )
                    render(outputFile, encoding = "UTF-8", output_dir = "res")
                }else{
                    
                }
            }
        }
    },
    
    content = function(file) {
    }
)

####LIGNE ----

output$table <- renderTable({
    myligne<- input$ligne1
    dataset <- read.csv("../data/JEU_1.csv",header=TRUE, sep=";", dec=",")
    
    write.csv(dataset[myligne,],file = "myligne.csv")
    dataset[myligne,]
    
    
})

output$downloadLignes <- downloadHandler(
    filename = function() {
        #Set working directory 
        #setwd("/Users/mathilde/Desktop/APPLI11/APPLI12/")  #("C:/Cours/4A/S8/Numérique/Maquette/OPEN-chicken")
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
                knit("Maquette_Lignes.Rmd", output = outputFile, encoding = "UTF-8" )
                render(outputFile, encoding = "UTF-8")
            }else{
                
            }
        }
    },
    
    content = function(file) {
    }
)  
#Dernière ligne de SERVER 
}


# Run the application ----
shinyApp(ui = ui, server = server)

