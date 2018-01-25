# K means
setwd("~/Documents/東西丟這/R/Machine Learning/Machine Learning A-Z Template Folder/Part 4 - Clustering/Section 24 - K-Means Clustering")
data <- read.csv("Mall_Customers.csv")

# ony need x y
X <- data[4:5]
set.seed(77)
wcss <- vector()

for(i in 1:10)
  wcss[i] <- sum(kmeans(X,i)$withinss)

plot(1:10, wcss, type = "b", 
     main = "Cluster of clients",
     xlab = "number of cluster", 
     ylab = "WCSS")
# kmeans(X,i)$withinss
# kmeans(X,i)[4]

# Choose suitable n, do it!
K <- kmeans(X, 5, iter.max = 300, nstart = 30)
K
# Visualization
library(cluster)
clusplot(X, 
         K$cluster, 
         shade = F, 
         color = T, 
         lines = 0, 
         labels = 1, 
         plotchar = F, 
         span = T, 
         xlab = "Annual income", 
         ylab = "Spending Score")










