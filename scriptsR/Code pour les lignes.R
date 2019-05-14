dataTest <- read.table("JEU_1.csv",header=TRUE, na.strings = c("NA","-","VIDE"), sep=";", dec=",", row.names = )

head(dataTest)

## pour ligne l= ligne agriculteur à récupérer sur shiny
l <- 3 

#Boucle 
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

##### Analyse par ligne ###########


### Analyse qualitative ###
  par(mfrow=c(1,2))
  
  Monx <- 0.7
  if (dataTest$PROD[l]=="POULETTE") Monx=1.9
  
  barplot(table(dataTest$PROD), main=paste("Agriculteur",l))
  points(x=Monx,y=80, col="red", pch="x", cex=5)
  
  
  o <- which(levels(dataTest$ALIMENT)==dataTest$ALIMENT[l])
  table(dataTest$ALIMENT)
  coleur <- rep("grey", nlevels(dataTest$ALIMENT))
  coleur[l] <- "red"
  barplot(table(dataTest$ALIMENT), col=coleur, main=paste("Agriculteur",l))
  
  par(mfrow=c(1,1))
  
  p <- which(levels(dataTest$TYPE)==dataTest$TYPE[l])
  table(dataTest$TYPE)
  coleur <- rep("grey", nlevels(dataTest$TYPE))
  coleur[l] <- "red"
  barplot(table(dataTest$TYPE), col=coleur, main=paste("Agriculteur",l))



### Analyse quantitative ###
  par(mfrow=c(1,1))
  
  q <- which(levels(dataTest$EstimationConso)==dataTest$EstimationConso[l])
  table(dataTest$EstimationConso)
  posi <-dataTest$NbPoules[c(l)] 
  posi2<-dataTest$EstimationConso[c(l)] 
  posi3<-dataTest$NbPoules[c(l)]

  
  
  hist(dataTest$EstimationConso, nclass = 10, prob = FALSE, col = "cornflowerblue", border = "white", 
       xlim = c(0, 0.0002), main =paste("Agriculteur",l), xlab = "Consommation", ylab = "Nombre d'éleveurs")
  text(0.000015, 55, paste("
                Estimation 
                Consommation 
                =", posi2), cex = 0.55)
  abline(v=posi2,col="red",lwd=1.5,lty=1)
  
  
  hist(dataTest$NbPoules, nclass = 10, prob = FALSE, col = "cornflowerblue", border = "white", 
       xlim = c(0, 16000), main =paste("Agriculteur",l), xlab = "Nombre de poules", ylab = "Nombre d'éleveurs")
  
  text(13000, 32, paste("Nb Total 
          éleveurs =", sum(complete.cases(dataTest$NbPoules))), cex = 0.75)
 
  
  
  abline(v=posi,col="red",lwd=1.5,lty=1)
  text(3000, 30, paste("Nb poules de l'éleveur =", posi), cex = 0.55)

