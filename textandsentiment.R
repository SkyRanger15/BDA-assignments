text <- c("I love this product, it's amazing!",
          "Worst experience ever, totally disappointed.",
          "Okay service, but not worth the price.",
          "Excellent quality and very satisfied!",
          "Terrible! Would not recommend.")

corpus <- VCorpus(VectorSource(text))

#operations

corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus,removeWords,stopwords("en"))
corpus <- tm_map(corpus,stripWhitespace)
corpus

corpus <- tm_map(corpus,stemDocument)
# Loop through the corpus and print each cleaned document
for (i in 1:length(corpus)) {
  cat(paste0("Document ", i, ": ", corpus[[i]]$content, "\n"))
}

review_data <- data.frame(id = 1:5, review = text, stringsAsFactors = FALSE)
review_data            
review_data$cleaned <- sapply(corpus,as.character)      
review_data

sentiment_score <- get_nrc_sentiment(review_data$cleaned)
sentiment_score
review_data_sentiment <- cbind(review_data, sentiment_score)
review_data_sentiment
sentiment_summary <- colSums(sentiment_score[, 1:8])
sentiment_summary
df_sentimentscore <- data.frame(sentiment = names(sentiment_summary), score <- sentiment_summary)

df_sentimentscore

ggplot(data = df_sentimentscore,aes(x = reorder(sentiment,-score),y = score))+
  geom_bar(stat = "identity", fill="coral")+
  theme_minimal()

dtm <- TermDocumentMatrix(corpus)
dtm
m <- as.matrix(dtm)
m
word_freq <- sort(rowSums(m))

df_wordcount <- data.frame(word = names(word_freq),freq = word_freq)
df_wordcount

wordcloud(words = df_wordcount$word,freq = df_wordcount$freq)


