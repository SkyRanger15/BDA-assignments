iris

trainidx = createDataPartition(iris$Species,p = 0.8, list = FALSE)
trainset = iris[trainidx,]
testset = iris[-trainidx,]

dct = rpart(Species ~ . ,data = trainset,method = "class")

pred = predict(dct,testset,type = "class")

confmat <- confusionMatrix(pred,testset$Species)
confmat

rpart.plot(dct)
