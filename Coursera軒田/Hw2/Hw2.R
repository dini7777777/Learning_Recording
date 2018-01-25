setwd("~/Documents/東西丟這/CEIBA/軒田基石/Hw2")

# Ex 17
decision_stump <- function(n){
x <- runif(n, -1, 1)
y <- sign(x)
library(caTools)
split <- sample.split(y, 0.8)
z <- y
z[split==F] <- -z[split==F]
A<- NULL
for(t in n:1){
  A <- rbind(A, c(rep(1, t), rep(-1, n-t)) )
}
E_in <- (n - A %*% z )/(2*n)
E_out <- (n - A %*% y )/(2*n)
return( c(min(E_in), min(E_out)) )
}

t <- 5000
n <- 20
E_in <- 0
E_out <- 0
for(i in 1:t){
  E_in <- E_in + decision_stump(n)[1]
  E_out <- E_out + decision_stump(n)[2]
}
E_in/t
E_out/t

# Ex 19
test_data <- read.table("hw2_test.dat")
train_data <- read.table("hw2_test.dat")

max(train_data)
max(test_data)

# install.packages("dplyr")
library("dplyr")
y <- arrange(train_data, V1)[10]
y[, 2] <- arrange(train_data, V2)[10]
y[, 3] <- arrange(train_data, V2)[10]
y[, 4] <- arrange(train_data, V2)[10]
y[, 5] <- arrange(train_data, V2)[10]
y[, 6] <- arrange(train_data, V2)[10]
y[, 7] <- arrange(train_data, V2)[10]
y[, 8] <- arrange(train_data, V2)[10]
y[, 9] <- arrange(train_data, V2)[10]


n <- nrow(train_data)
E <- NULL
for (i in 1:9){
  A<- NULL
  
  for(t in n:1){
    A <- rbind(A, c(rep(1, t), rep(-1, n-t)) ) }
  A <- rbind(A, -A)
  
  E_in <- (n - A %*% y[, i] )/(2*n)
  E[i] <- min(E_in)
}
