data("mtcars")
mtcars
head(mtcars)
sum(is.na(mtcars))

set.seed(123)

splitidx <- createDataPartition(mtcars$mpg, p = 0.8 , list = FALSE)
trainset <- mtcars[splitidx,]
testset <- mtcars[-splitidx,]

model <- lm(mpg ~ wt+disp+hp , data = trainset)
summary(model)

pred <- predict(model, newdata = testset)

actual <- mtcars$mpg

Rmse <- sqrt(mean((pred - actual)^2))
cat("RMSE = ", Rmse)

ggplot(data = testset, aes(x = mpg, y = pred)) +
  geom_point(color = "blue") +
  geom_abline(intercept = 0, slope = 1, color = "red") +
  labs(title = "Actual vs Predicted MPG",
       x = "Actual MPG",
       y = "Predicted MPG") +
  theme_minimal()


