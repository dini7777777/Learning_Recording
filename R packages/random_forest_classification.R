setwd("~/Documents/東西丟這/R/Machine Learning/Machine Learning A-Z Template Folder/Part 3 - Classification/Section 20 - Random Forest Classification")


# Importing the dataset
data = read.csv('Social_Network_Ads.csv')
data = data[3:5]

# Encoding the target feature as factor
data$Purchased = factor(data$Purchased, levels = c(0, 1))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(data$Purchased, SplitRatio = 0.75)
training_set = subset(data, split == TRUE)
test_set = subset(data, split == FALSE)

# Feature Scaling
training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])

# Fitting SVM to the Training set
# install.packages('e1071')
library(randomForest)
classifier = randomForest(x = training_set[-3],
                        y = training_set$Purchased, 
                        ntree = 10)

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-3])

# Making the Confusion Matrix
cm = table(test_set[, 3], y_pred)
cm

# Visualising the Training set results
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
grid_predict = predict(classifier, newdata = grid_set)
plot(set[, -3],
     main = 'Randomforest (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(grid_predict), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(grid_predict==1, 'lemonchiffon', 'pink'))
points(set, pch=16, cex=I(0.5), col = ifelse(set[, 3]==1, 'steelblue', 'darkorange4'))

# Visualising the Test set results
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
grid_predict = predict(classifier, newdata = grid_set)
plot(set[, -3], main = 'Randomforest (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(grid_predict), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(grid_predict==1, 'lemonchiffon', 'pink'))
points(set, pch=16, cex=I(0.5), col = ifelse(set[, 3]==1, 'steelblue', 'darkorange4'))


###
plot(classifier)
