# Hierarchical Clustering
setwd("~/Documents/東西丟這/R/Machine Learning/Machine Learning A-Z Template Folder/Part 4 - Clustering/Section 25 - Hierarchical Clustering")
data <- read.csv("Mall_Customers.csv")

# ony need x y
X <- data[4:5]

dendrogram = hclust(dist(X, method = 'euclidean'))
plot(dendrogram)

hc = hclust(dist(X, method = 'euclidean'), method = 'ward.D')
y_hc <- cutree(hc, 5)



# Visualization
# Way 1
cluster::clusplot(X, y_hc)

# Way 2
library(cluster)
clusplot(X, 
         y_hc, 
         shade = F, 
         color = T, 
         lines = 0, 
         labels = 1, 
         plotchar = F, 
         span = T, 
         main = paste('Cluster of Customers'),
         xlab = "Annual income", 
         ylab = "Spending Score")
