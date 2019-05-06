#Set working directory 
setwd("C:/Cours/4A/S8/Numérique/Maquette/OPEN-chicken")

#import des données 
données<-read.csv2("C:/Cours/4A/S8/Numérique/Maquette/JEU_1.csv")
head(données,3,5)
nrow(données)
ncol(données)

##### Analyse par colonne ###########

### Analyse qualitative ###

#tutos sur analyses univariées quali et quanti
browseURL("https://odr.inra.fr/intranet/carto/cartowiki/index.php/Statistiques_descriptives_avec_R#Statistiques_2")
browseURL("http://larmarange.github.io/analyse-R/statistique-univariee.html#variable-qualitative")
#tuto pour mise en forme des graph
browseURL("http://www.sthda.com/french/wiki/titre-des-graphiques-avec-le-logiciel-r-comment-personnaliser")

#effectifs 
table_effectifs<-table(données[3])
table_effectifs
summary(données$TYPE)
#effectifs triés croissants
table_effectifs_c<-sort(table(données$TYPE,useNA="always"))
table_effectifs_c

#tableau effectifs et proportions
library(questionr)
table_freq<-freq(données$TYPE)
table_freq

#proportions en %
browseURL("http://lmrs.math.cnrs.fr/Persopage/Giraudo/BiostatL2_StatR_P2016.pdf")
table_prop<-round(prop.table(table(données$TYPE))*100,1)
table_prop

#diagrammes batons
barplot(table_effectifs,main="Effectifs par type de bâtiment",xlab="Type de bâtiment",ylab="Effectif")
barplot(table_prop, main="Proportion par type de bâtiment", xlab="Type de bâtiment",ylab="Effectif en %")

#diagramme camembert
pie(table_effectifs,main="Répartition par type de bâtiment")
pie(table_prop,main="% par type de bâtiment")
