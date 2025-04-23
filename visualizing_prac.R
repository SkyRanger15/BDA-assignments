data(flights)
flights

view(flights)
data1 <- flights[!is.na(flights$air_time),]

flights %>% 
  ggplot(aes(x = distance , y=air_time))+
  geom_point(alpha = 0.3,color = "red")+
  labs(title = "scatter plot",x = "distance",y="Air time")+
  theme_minimal()

ggplot(flights,aes(x=carrier,fill= carrier))+
  geom_bar()+
  labs(title = "Bar Plot ", x= "carrier", y ="count")+
  theme_minimal()

data_sum <- flights %>% 
  group_by(month) %>% 
  summarise(avg_dep_delay = mean(dep_delay,na.rm = TRUE))
data_sum

ggplot(data_sum,aes(x = month, y = avg_dep_delay))+
  geom_line(color = "green",size = 1)+
  geom_point(color = "magenta",size = 3)+
  labs(title = "avg dep per month",x="average_dep",y="month")+
  theme_minimal()

ggplot(flights, aes(x = carrier, y = dep_delay)) +
  geom_boxplot(outlier.colour = "red", fill = "skyblue") +
  coord_cartesian(ylim = c(-20, 100)) +  # limit y-axis for better visibility
  labs(
    title = "Departure Delays by Airline Carrier",
    x = "Carrier",
    y = "Departure Delay (minutes)"
  ) +
  theme_minimal()
