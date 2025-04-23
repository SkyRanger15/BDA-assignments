iris
df <- iris[,1:4]
df
df <- scale(df)
df
wss <- vector()
for(k in 1:10){
  kmeans_results <- kmeans(df,centers = k,nstart = 20)
  wss[k] <- kmeans_results$tot.withinss
}

plot(1:10,wss,type = "b",pch = 19)


set.seed(42)
kmeans_result <- kmeans(df,centers = 3,nstart = 20)

kmeans_result

iris$cluster = as.factor(kmeans_result$cluster)

iris
ggplot(data = iris,aes(x= Sepal.Length,y = Sepal.Width, colour = cluster))+
  geom_point(size = 3)+
  labs(title = "clustering",x="sepal length", y = "petal length")+
  theme_minimal()

pca <- prcomp(df)
df <- data.frame(pca$x[,1:2],clust = iris$cluster)
df

ggplot(data = df,aes(x = PC1 , y = PC2,colour = clust))+
  geom_point(size=2)+
  theme_classic()



