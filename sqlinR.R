head(flights)
View(flights)
jan_flights <- sqldf("SELECT *
                     FROM flights
                     WHERE month = 1")
jan_flights


View(airlines)

flights_df <- as.data.frame(flights)
airlines_df<-as.data.frame(airlines)

con <-dbConnect(RSQLite::SQLite(),"flights_db.sqlite")

dbWriteTable(con, "flights",flights_df,overwrite = TRUE)
dbWriteTable(con,"airlines",airlines_df,overwrite =TRUE)

joined_data <- dbGetQuery(con,"SELECT flights.*,airlines.name
                          FROM flights
                          INNER JOIN airlines ON flights.carrier = airlines.carrier")

joined_data

avg_time_data <- dbGetQuery(con,"SELECT flights.carrier,AVG(air_time) as avg_air_time
                            FROM flights
                            GROUP BY carrier")
avg_time_data

ggplot(avg_time_data,aes(x= carrier,y = avg_air_time,fill = carrier))+
  geom_bar(stat = "identity")+
  theme_minimal()


orderedbydist <-dbGetQuery(con,"SELECT *
                           FROM flights
                           ORDER BY distance DESC")

orderedbydist


countbyorigin <- dbGetQuery(con,"SELECT origin,COUNT(*) AS total_flights
                            FROM flights
                            GROUP BY origin
                            ORDER BY total_flights DESC")

countbyorigin  


union_example <- dbGetQuery(con,"
                            SELECT flight, origin, dest, air_time, 'Short' AS category
                            FROM flights
                            WHERE air_time < 60
                            
                            UNION

                            SELECT flight, origin, dest, air_time, 'Long' AS category
                            FROM flights
                            WHERE air_time > 300
                            ")
print(union_example)  
  
  
  
  