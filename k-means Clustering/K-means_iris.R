library(ggplot2)

ggplot(iris, aes(iris$Petal.Length, iris$Petal.Width, color= iris$Species))+geom_point()
#clustering
set.seed(20)
wss=numeric(15)
for(k in 1:15) wss[k] =sum(kmeans(iris[, 3:4], k, nstart = 20)$withinss)
plot(1:15, wss, type="b", xlab ="#clusters", ylab = "Within sum of squares")
irisCluster=kmeans(iris[, 3:4], 5, nstart = 20)
table(irisCluster$cluster, iris$Species)
irisCluster$cluster=as.factor(irisCluster$cluster)
ggplot(iris, aes(iris$Petal.Length, iris$Petal.Width,
                 color= irisCluster$cluster))+geom_point()
