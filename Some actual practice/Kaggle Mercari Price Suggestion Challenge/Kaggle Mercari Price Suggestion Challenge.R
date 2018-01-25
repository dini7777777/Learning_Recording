setwd("~/Documents/東西丟這/R/Kaggle/Kaggle Mercari Price Suggestion Challenge")
data_original <- read.delim('train.tsv', quote = '', na.strings = c( "", "No description yet" ) )

L <- levels(data_original$category_name)
L
# data_original[122:157,]
# data_original$train_id[122:157]
# data_original$category_name[1]
cat <- 516

a <- data_original$category_name == L[cat]
which(a == TRUE)

data_cat <- data_original[which(a == TRUE), ]
levels(droplevels(data_cat)$brand_name)

NLP <- function(data_cat){
# install.packages('tm')
library(tm)
corpus <- VCorpus(VectorSource(data_cat$name))
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
#as.character(corpus[[841]])
# 讓空格都變一個
corpus <- tm_map(corpus, stripWhitespace)
#as.character(corpus[[841]])


# Creating the bag of Words models
dtm <- DocumentTermMatrix(corpus)
# Filter nonfrequent words leave 99%
dtm <- removeSparseTerms(dtm, 0.99)

# Use the classification model Alreadt built
data <- as.data.frame(as.matrix(dtm))
# data$price <- factor(B1$price, levels = 1:565 )
return(data)
}

data <- NLP(data_cat)


#---------- Classification

library(caTools)
set.seed(123)
split = sample.split(data_cat$price, SplitRatio = 0.75)
training_set = subset(data, split == TRUE)
test_set = subset(data, split == FALSE)

####
# install.packages('matlib')
library(matlib)
# Least square linear solution Ax=b
A <- as.matrix(training_set)
b <- subset(data_cat$price, split == TRUE) 
x <- Inverse(t(A)%*%A) %*% as.matrix(t(A)) %*% b

colnames(data)
which.min(x)
High <- data_cat[data[, which.max(x)]==1, ]
Low  <- data_cat[data[, which.min(x)]==1, ]

i= 54
colnames(data)[i]
K <- data_cat[data[, i]==1, ]
x[i]


predict_price_test <- as.matrix(test_set) %*% x
price_test <- subset(data_cat$price, split == F)
(predict_price_test - price_test )/price_test



























------------------------------------------------
# unlist(strsplit(as.character(data_original$category_name[1]), "[/]"))
L <- strsplit(as.character(data_original$category_name), "[/]")
first_cat <- lapply(L, function(x) x[1])
second_cat <- lapply(L, function(x) x[2])

# data_original[ first_cat=="Women", ]
first_cat_data <- as.data.frame(unlist(first_cat))
summary(first_cat_data)
second_cat_data <- as.data.frame(unlist(second_cat))
summary(second_cat_data)

men <- data_original[ which(K=="Men"), ]

# data_original$category_name[1:5]
