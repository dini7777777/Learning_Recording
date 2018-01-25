setwd("~/Documents/東西丟這/R/Kaggle/Toxic Comment Classification Challenge")

train <- read.csv("train.csv")

rmwords <- c("wikipedia", "also", "around", "admin", "articl", "can", "cant", "come", "comment", "dont", "edit", "even", "hey", "ive", "like",  "just", "look", "know", "name", "now", "one", "page", "person", "peopl", "say", "see", "talk", "that", "time",  "use", "user", "want", "way",  "will", "your")

NLP <- function(data, p){
  # install.packages('tm')
  library(tm)
  corpus <- VCorpus(VectorSource(data$comment_text))
  #as.character(corpus[1])
  
  corpus <- tm_map(corpus, content_transformer(tolower))
  #as.character(corpus[[1]])
  #as.character(corpus[[841]])
  
  corpus <- tm_map(corpus, removeNumbers)
  #as.character(corpus[[841]])
  
  corpus <- tm_map(corpus, removePunctuation)
  #as.character(corpus[[841]])
  
  # 移除無意義語助詞
  # install.packages('SnowballC')
  # stopwords 內一定要有 ()
  corpus <- tm_map(corpus, removeWords, stopwords())
  #as.character(corpus[[841]])
  # 找字根
  corpus <- tm_map(corpus, stemDocument)
  # 移除自定義的無意義詞
  corpus <- tm_map(corpus, removeWords, rmwords)
  #as.character(corpus[[841]])
  # 讓空格都變一個
  corpus <- tm_map(corpus, stripWhitespace)
  #as.character(corpus[[841]])
  
  
  # Creating the bag of Words models
  dtm <- DocumentTermMatrix(corpus)
  # Filter nonfrequent words leave p%, 99%
  dtm <- removeSparseTerms(dtm, p)
  
  # Use the classification model Alreadt built
  data <- as.data.frame(as.matrix(dtm))
  # data$price <- factor(B1$price, levels = 1:565 )
  return(data)
}
data <- NLP(train, 0.99)


L1 <- train[train$toxic==1, ]
L2 <- train[train$severe_toxic==1, ]
L3 <- train[train$obscene==1, ]
L4 <- train[train$threat==1, ]
L5 <- train[train$insult==1, ]
L6 <- train[train$identity_hate==1, ]


p <- 0.97

WL1 <- NLP(L1, p)
WL2 <- NLP(L2, p)
WL3 <- NLP(L3, p)
WL4 <- NLP(L4, p)
WL5 <- NLP(L5, p)
WL6 <- NLP(L6, p)


write.csv(data, file = "bagofwords.csv")



W4 <- apply(WL4, c(1,2), as.logical)
n4 <- apply(W4, 1, sum)

