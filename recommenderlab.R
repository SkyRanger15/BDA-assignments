data("MovieLense")
MovieLense
summary(MovieLense)
View(MovieLense)
colnames(MovieLense)[1:5]   # First 5 movies
rownames(MovieLense)[1:5]   # First 5 users
properreviews <- MovieLense[rowCounts(MovieLense)>50,]
set.seed(123)
train_test <- evaluationScheme(properreviews,method = "split",train = 0.8,given=10,goodRating=4)
model_ubcf <- Recommender(getData(train_test,"train"),method="UBCF")
summary(model_ubcf)
pred <- predict(model_ubcf,getData(train_test,"known"),type = "ratings")


pred_matrix <- as(pred, "matrix")
head(pred_matrix)


error <- calcPredictionAccuracy(pred, getData(train_test, "unknown"))
print(error)






















