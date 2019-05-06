#Set working directory 
setwd("C:/Cours/4A/S8/Numérique/Maquette/OPEN-chicken")

#import des données 
données<-read.table("C:/Cours/4A/S8/Numérique/Maquette/JEU_1.csv", header = TRUE, sep = ";", dec=",",na.strings="NA")
p<-nrow(données)
p
n<-ncol(données)
n

##### Analyse par colonne ###########

### Analyse qualitative ###

#choix de la variable
i<-1
while (i<=n) {
  test<-is.numeric(données[1,i])
  test
  if(test==FALSE){
    table_effectifs<-table(données[i])
    table_prop<-round(prop.table(table(données[i]))*100,1)
    barplot(table_effectifs,main="Effectifs par modalités", xlab="Modalités", ylab = "Effectifs")
    barplot(table_prop, main="Proportions par modalités",xlab="Modalités", ylab="Effectif en %")
    pie(table_effectifs,main="Répartition par modalité")
    pie(table_prop,main="% par modalité")
  }else{
    i<-i+1
  }
i<-i+1
i
}


