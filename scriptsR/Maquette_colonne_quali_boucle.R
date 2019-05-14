#Set working directory 
setwd("C:/Cours/4A/S8/Numérique/Maquette/OPEN-chicken")

#import des données 
data<-read.table("C:/Cours/4A/S8/Numérique/Maquette/JEU_1.csv", header = TRUE, sep = ";", dec=",",na.strings="NA")
p<-nrow(data)
p
n<-ncol(data)
n

#trie des colonnes quali et quanti
qt <- NULL
ql <- NULL
for (i in 1:n){
  if (is.numeric(data[,i])) {
    qt <- c(qt,i)
  }else{
    ql <- c(ql,i)
  }
}
data_quali<-data[,ql]
head(données_quali)
data_quanti<-data[,qt]
data_quanti<-data_quanti[,-1]
#pour supprimer la colonne des identifiants 
head(données_quanti)

##### Analyse par colonne ###########

### Analyse qualitative ###
test_ql<-data_quali[,1:4]
head(test_ql)
nql<-ncol(test_ql)
for (i in 1:nql) {
  
    table_effectifs<-table(test_ql[i])
    table_prop<-round(prop.table(table(test_ql[i]))*100,1)
    
    barplot(table_effectifs,main="Effectifs par modalités", xlab="Modalités", ylab = "Effectifs")
    barplot(table_prop, main="Proportions par modalités",xlab="Modalités", ylab="Effectif en %")
    
    pie(table_effectifs,main="Répartition par modalité")
    pie(table_prop,main="% par modalité")
    
    par(mfrow=c(2,2))
}


