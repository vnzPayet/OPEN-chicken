## Analyse de données quanti avant la fonction desc
## Samuel NAQUIN

#import des données 
données<-read.csv2("data/JEU_1.csv",header=TRUE, na.strings = c("NA","-","VIDE"), sep=";", dec=",")# changer le fichier d'entrée
head(données,8,9,10) #
nrow(données)
ncol(données)

#####Analyse par colonne######

###analyse quantitative
#âge
age<-données[,8]
age
mean(données[,8],na.rm=TRUE)
min(données[,8],na.rm=TRUE)
max(données[,8],na.rm=TRUE)
sd(données[,8],na.rm=TRUE)

#consommation
consommationfac<-données[,9]
consommation<- as.numeric(sub(",",".",as.character(consommationfac))) #tansformation de la virgule en point (numeric)
consommation
mean(consommation,na.rm=TRUE)
min(consommation,na.rm=TRUE)
max(consommation,na.rm=TRUE)
sd(consommation,na.rm=TRUE)

hist(consommation,col="red",xlab="Nombre de poules",ylab="Nombre d'éleveurs",main="Histogramme du nombre de poules par éleveur")

#Nombre de poules
nb_poules<-données[,10]
nb_poules
hist(nb_poules,breaks=9,col="red",xlab="Nombre de poules",ylab="Nombre d'éleveurs",main="Histogramme du nombre de poules par éleveur")

mean(nb_poules,na.rm=TRUE)
min(nb_poules,na.rm=TRUE)
max(nb_poules,na.rm=TRUE)
sd(nb_poules,na.rm=TRUE)


desc <- function(x){
  Moy <- mean(x,na.rm=TRUE)
  Mini<- min(x,na.rm=TRUE)
  Max<- max(x,na.rm=TRUE)
  E_type<- sd(x,na.rm=TRUE)

  rbind(Moy, Mini, Max, E_type)
  
}

desc(nb_poules)
desc(consommation)


# breaks : nombre de barres
# density : barres vides (0) ou hachurées
# tck = 0.01 : longueur des graduations
# xlab & ylab : titre de l'axe des abscisses et ordonnées
# main : titre de l'histogramme
# col : couleur des barres - pour mettre d'autres couleurs
#proportions





