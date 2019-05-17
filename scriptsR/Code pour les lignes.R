#Importer le fichier CSV
dataTest <- read.table("JEU_1.csv",header=TRUE, na.strings = c("NA","-","VIDE"), sep=";", dec=",", row.names = )

head(dataTest)

## l= ligne agriculteur , à récupérer sur shiny ou même à tester ici en mettant par ex : l<- 3 pour l'agriculteur 3

l <- dataTest$ID[c(1)] 
l

#Boucle permettant de trier les  variavles quanti et quali , mais facultatif ici dans le cas 
# d'une analyse par ligne
p<-nrow(dataTest)
n<-ncol(dataTest)

qt <- NULL
ql <- NULL
for (i in 1:n){
  if (is.numeric(dataTest[,i])) {
    qt <- c(qt,i)
  }else{
    ql <- c(ql,i)
  }
}

data_quali<-dataTest[,ql]
head(data_quali)
data_quanti<-dataTest[,qt]
data_quanti<-data_quanti[,-1] #pour supprimer la colonne des identifiants 
head(data_quanti)

############################## Analyse par ligne ###########


### Analyse qualitative ###

  par(mfrow=c(1,2)) # cette fonction permet de configurer le nombre de graph à afficher sur une page
                    #Ici on afficher deux graph sur une même "horizontale"
  
  Monx <- 0.7 #Permet le positionnement de la croix sur le graphique
  if (dataTest$PROD[l]=="POULETTE") Monx=1.9
  
  barplot(table(dataTest$PROD), main=paste("Agriculteur",l)) #Graphique
  points(x=Monx,y=80, col="red", pch="x", cex=5)
  
  
  o <- which(levels(dataTest$ALIMENT)==dataTest$ALIMENT[l])
  table(dataTest$ALIMENT)
  coleur <- rep("grey", nlevels(dataTest$ALIMENT)) #Colorie toute les niveaux de la variable en gris sur le graph
  coleur[dataTest$ALIMENT[l]] <- "red" #Colorie en rouge le niveau correspondant à l'agriculteur "
  barplot(table(dataTest$ALIMENT), col=coleur, main=paste("Agriculteur",l)) #Graph
  
  par(mfrow=c(1,1)) #Idem que précédemment sauf qu'on affiche qu'un seul graph 
  
  p <- which(levels(dataTest$TYPE)==dataTest$TYPE[l])
  table(dataTest$TYPE)
  coleur <- rep("grey", nlevels(dataTest$TYPE))
  coleur[dataTest$TYPE[l]] <- "red"
  barplot(table(dataTest$TYPE), col=coleur, main=paste("Agriculteur",l))



### Analyse quantitative ###
  
  par(mfrow=c(1,1))
  
  q <- which(levels(dataTest$EstimationConso)==dataTest$EstimationConso[l])
  table(dataTest$EstimationConso)
  # définition de variable à stocker
  posi <-dataTest$NbPoules[c(l)] 
  posi2<-dataTest$EstimationConso[c(l)] 
  posi3<-dataTest$NbPoules[c(l)]

  
  
  hist(dataTest$EstimationConso, nclass = 10, prob = FALSE, col = "cornflowerblue", border = "white", 
       xlim = c(0, 0.0002), main =paste("Agriculteur",l), xlab = "Consommation", ylab = "Nombre d'éleveurs")
  text(0.000015, 55, paste("
                Estimation 
                Consommation 
                =", posi2), cex = 0.55) # La fonction text() permet d'insérer du texte
  abline(v=posi2,col="red",lwd=1.5,lty=1) #Permet d'afficher une barre verticale pour placer l'agriculteur
  
  
  hist(dataTest$NbPoules, nclass = 10, prob = FALSE, col = "cornflowerblue", border = "white", 
       xlim = c(0, 16000), main =paste("Agriculteur",l), xlab = "Nombre de poules", ylab = "Nombre d'éleveurs")
  
  text(13000, 32, paste("Nb Total 
          éleveurs =", sum(complete.cases(dataTest$NbPoules))), cex = 0.75)
 
  
  
  abline(v=posi,col="red",lwd=1.5,lty=1)
  text(3000, 30, paste("Nb poules de l'éleveur =", posi), cex = 0.55)

