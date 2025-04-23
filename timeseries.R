AirPassengers
summary(AirPassengers)
ts_data <- AirPassengers

plot(ts_data,main="Original TS",col = "blue")

decomposed <- decompose(ts_data)
decomposed
plot(decomposed)

str(ts_data)
adf.test(ts_data)

model <- auto.arima(ts_data)
summary(model)

forecasted <- forecast(model,h=12)
forecasted
plot(forecasted)
