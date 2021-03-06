## Mai 2019
##
##

# Benoit LECOUR
# Script R qui rassemble tous les traitements possibles pour analyse qualitative en colonne


#import des données 
données<-read.csv2("C:/Cours/4A/S8/Numérique/Maquette/JEU_1.csv")
head(données,3,5)
p<-nrow(données)
n<-ncol(données)

##### Analyse par colonne ###########

### Analyse qualitative ###

#tutos sur analyses univariées quali et quanti
browseURL("https://odr.inra.fr/intranet/carto/cartowiki/index.php/Statistiques_descriptives_avec_R#Statistiques_2")
browseURL("http://larmarange.github.io/analyse-R/statistique-univariee.html#variable-qualitative")
browseURL("http://lmrs.math.cnrs.fr/Persopage/Giraudo/BiostatL2_StatR_P2016.pdf")
#tuto pour mise en forme des graph
browseURL("http://www.sthda.com/french/wiki/titre-des-graphiques-avec-le-logiciel-r-comment-personnaliser")

#choix de la variable
i<-3

  #effectifs 
  table_effectifs<-table(données[i])
  table_effectifs
  summary(données[i])
  #effectifs triés croissants
  table_effectifs_c<-sort(table(données[i],useNA="always"))
  table_effectifs_c
  
  #tableau effectifs et proportions
  library(questionr)
  table_freq<-freq(données[i])
  table_freq
  
  #proportions en %
  table_prop<-round(prop.table(table(données[i]))*100,1)
  table_prop
  
  #diagrammes batons
  barplot(table_effectifs,main="Effectifs par type de bâtiment",xlab="Type de bâtiment",ylab="Effectif")
  barplot(table_prop, main="Proportion par type de bâtiment", xlab="Type de bâtiment",ylab="Effectif en %")
  
  #diagramme camembert
  pie(table_effectifs,main="Répartition par type de bâtiment")
  pie(table_prop,main="% par type de bâtiment")

