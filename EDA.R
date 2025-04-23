data("flights")
head(flights)
str(flights)
summary(flights)
colSums(is.na(flights))
flights$TimeOfDay <- ifelse(flights$hour >=6 & flights$hour < 12,"Morning", ifelse(flights$hour >= 12 & flights$hour < 18 , "Afternoon","Night"))
print(flights)
view(flights)
data_sorted <- flights[order(flights$year,flights$month,flights$day,flights$hour,flights$minute),]
print(data_sorted)
numeric_col <-sapply(data_sorted,is.numeric)
numeric_col 
data_sorted[numeric_col] <- lapply(data_sorted[numeric_col],function(x){x-min(x)/max(x)-min(x)})
print(data_sorted)


TimeOfDay_grp <- flights %>% 
  group_by(TimeOfDay) %>% 
  summarise(flight_count = n())
ggplot(TimeOfDay_grp,aes(x="",y=flight_count,fill = TimeOfDay))+
  geom_bar(stat = "identity",width = 1)+
  coord_polar(theta="y")+
  labs(title = "hello")+
  theme_minimal()
  
  