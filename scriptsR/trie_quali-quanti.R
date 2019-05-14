setwd("C:/Cours/4A/S8/Numérique/Maquette/OPEN-chicken")
données<-read.table("C:/Cours/4A/S8/Numérique/Maquette/JEU_1.csv", header = TRUE, sep = ";", dec=",",na.strings="NA")
p<-nrow(données)
n<-ncol(données)

qt <- NULL
ql <- NULL
for (i in 1:n){
  if (is.numeric(données[,i])) {
    qt <- c(qt,i)
  }else{
    ql <- c(ql,i)
  }
}

données_quali<-données[,ql]
head(données_quali)
données_quanti<-données[,qt]
données_quanti<-données_quanti[,-1]
#pour supprimer la colonne des identifiants 
head(données_quanti)
