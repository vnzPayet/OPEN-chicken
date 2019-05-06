library(FactoMineR)

JEU1 <- read.table("JEU_1.csv",header=TRUE, na.strings = "NA", sep=";")
JEU1[1,1]
JEU1[c("1"),] # Ex : Permet d'afficher toutes les valeurs de chaque colonne pour la ligne 1 

x <- 3 # Variable correspondant à la ligne voulu

estimconso <- JEU1[, c(9)]
plot(JEU1$estimation.conso) # Répartition de l'estimation consommée
# même graphique que ligne précédente
plot(estimconso)


# Graphiques pour type de prod
x <- 3
plot(JEU1$PROD)
abline(v=JEU1$PROD[c(x)],lwd=1,col="red") #

# Graphiques pour le nombre de poules

plot(JEU1$Nb.Poules)

boxplot(JEU1$Nb.Poules)
pos <-JEU1$Nb.Poules[c(x)] 


hist(JEU1$Nb.Poules, nclass = 10, prob = FALSE, col = "cornflowerblue", border = "white", 
     xlim = c(0, 16000), main = "", xlab = "Nombre de poules", ylab = "Nombre d'éleveurs")

text(14000, 32, paste("N =", sum(complete.cases(JEU1$Nb.Poules))), cex = 1.1)



abline(v=pos,col="red",lwd=1.5,lty=1)
text(4000, 30, paste("Nb poules de l'éleveur =", pos), cex = 0.55)


#Graphique estimation consommation

ColConso <- JEU1$estimation.conso
ConsomEstim <- as.numeric(sub(",",".",as.character(ColConso)))
pos2 <-ConsomEstim[c(x)] 
hist(ConsomEstim,breaks=10,col="Blue",xlab="Durée (années)",
     ylab="Occurrences",main="Durée moyenne des études dans le pays X",ylim=c(0,70),tck=0.00001)
abline(v=pos2,col="red",lwd=1.5,lty=1)
