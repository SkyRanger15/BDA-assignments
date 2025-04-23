# Install required packages if not already installed
install.packages("tm")
install.packages("syuzhet")
install.packages("tidytext")
install.packages("ggplot2")
install.packages("wordcloud")

# Load the libraries into the R session
library(tm)
library(syuzhet)
library(tidytext)
library(ggplot2)
library(wordcloud)

# Example unstructured text data: Customer reviews
reviews <- c("The product is amazing, I love it!",
             "Worst purchase ever, totally regret it.",
             "The quality is great, but it took too long to arrive.",
             "I am very happy with the service and the product.",
             "It was okay, not as good as I expected.")

# Create a data frame
review_data <- data.frame(id = 1:5, review = reviews, stringsAsFactors = FALSE)

# Text cleaning and preprocessing
review_data$clean_review <- tolower(review_data$review)

clean_corpus <- Corpus(VectorSource(review_data$clean_review))
clean_corpus <- tm_map(clean_corpus, content_transformer(tolower))
clean_corpus <- tm_map(clean_corpus, removePunctuation)
clean_corpus <- tm_map(clean_corpus, removeNumbers)
clean_corpus <- tm_map(clean_corpus, removeWords, stopwords("en"))
clean_corpus <- tm_map(clean_corpus, stripWhitespace)
clean_corpus <- tm_map(clean_corpus, stemDocument)

review_data$clean_review <- sapply(clean_corpus, as.character)

# Sentiment analysis using NRC lexicon
sentiment_scores <- get_nrc_sentiment(review_data$clean_review)

# Bind sentiment scores with the original data
review_data_sentiment <- cbind(review_data, sentiment_scores)

# Summarize sentiment scores
sentiment_summary <- colSums(sentiment_scores[, 1:8])

# Sentiment bar chart visualization
sentiment_summary_df <- data.frame(sentiment = names(sentiment_summary), score = sentiment_summary)

ggplot(sentiment_summary_df, aes(x = reorder(sentiment, score), y = score, fill = sentiment)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Sentiment Analysis of Customer Reviews", x = "Sentiment", y = "Score")

# Word cloud visualization
wordcloud(words = unlist(strsplit(tolower(paste(review_data$clean_review, collapse = " ")), " ")),
          min.freq = 1, 
          scale = c(3, 0.5), 
          colors = brewer.pal(8,"Dark2"))

