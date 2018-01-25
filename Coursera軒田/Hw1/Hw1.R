setwd("~/Documents/東西丟這/CEIBA/軒田基石/Hw1")

data_15 <- read.delim(textConnection(
                      gsub(" ", "\t", readLines("hw1_15_train.dat.txt"))),
                      header = F)
data_18_train <- read.delim(textConnection(
                      gsub(" ", "\t", readLines("hw1_18_train.dat.txt"))),
                      header = F)
data_18_test <- read.delim(textConnection(
                      gsub(" ", "\t", readLines("hw1_18_test.dat.txt"))),
                      header = F)

add1_left <-function(x) {
  x <- cbind(rep(1, nrow(x)), x)}

data_15 <- add1_left(data_15)
data_18_train <- add1_left(data_18_train)
data_18_test <- add1_left(data_18_test)

cat("\014")

##### Ex15
import <- as.matrix(data_15)
#test <- import

X_15 <- apply(import, 1, function(x) { c(x[-6]*x[6], x[6]) })
X_15 <- t(X_15)

PLA <- function(x){
      w = rep(0, ncol(data_15)-1)
      j <- 0
      for(i in 1:400) {
        a <- x[i, -6] %*% w
#        print(a)
#        print(a < 0 || (a==0 & x[i, 6]==1 ))
        if (a < 0 || (a==0 & x[i, 6]==1 )){
          w <- w + x[i, -6] #*x[i, 6]
          j <- j+1
          }
      }
      return( list(w, j) )
}

L <- PLA(X_15)
# LL <- PLA(X_15)
b <- apply(X_15, 1, function(x) x[-6]%*% L[[1]] )
sign(b)

##### Random Cycle ####
PLA_Random <- function(x){
  
  mu <- 1
  k <- sample(1:nrow(x) )
  w = rep(0, ncol(x)-1)
  j <- 0
  for(i in 1:nrow(x)) {
    a <- x[k[i], -6] %*% w
    if (a < 0 || (a==0 & x[k[i], 6]==1 )){
      w <- w + mu * x[k[i], -6] #*x[k[i], 6]
      j <- j+1
    }
  }
  return( list(w, j) )
}
L <- PLA_Random(X_15)


##### Expected number of updates #####
J_ <- 0
for(i in 1:2000){
  J_ <- J_ + PLA_Random(X_15)[[2]]
}
J_/2000



###### Ex 18 #####
import <- as.matrix(data_18_train)
X_18_train <- apply(import, 1, function(x) { c(x[-6]*x[6], x[6]) })
X_18_train <- t(X_18_train)

L <- PLA_Random(X_18_train)
b <- apply(X_18_train, 1, function(x) x[-6]%*% L[[1]] )
sum(sign(b))

import <- as.matrix(data_18_test)
X_18_test <- apply(import, 1, function(x) { c(x[-6]*x[6], x[6]) })
X_18_test <- t(X_18_test)

b <- sign(apply(X_18_test, 1, function(x) x[-6]%*% L[[1]]))
sum(sign(b))

cat("\014")

###### Ex 19 #####

Error_rate <- function(x, w){
  e <- nrow(x) - sum( sign( 
    apply(x, 1, function(x) x[-6]%*% w )
    ))
  e <- e/(2*nrow(x))
  return(e)
}

PLA_Random_Pocket_Stop <- function(x){
  
  k <- sample(1:nrow(x))
  w = rep(0, ncol(x)-1)
  w_ <- w
  j <- 0
  e <- sum(x[, 6] != -1)
  p <- 0
  
  for(i in 1:nrow(x)) {
    a <- x[k[i], -6] %*% w
    if (a < 0 || (a==0 & x[k[i], 6]==1 )){
      w <- w +  x[k[i], -6] #*x[k[i], 6]
      j <- j+1
    }
    
    e_ <-  Error_rate(x, w)
    if ( e >  e_ & p < 100){
      e <- e_
      w_ <- w
      p <- p+1
    }
  }
  return( list(w, j, w_, e_, p) )
}

L <- PLA_Random_Pocket_Stop(X_18_train)
L

Error_rate(X_18_test, L[[3]])

# Error_rate(X_15, w)




######## Visualize #####

X_15 <- X_15[, c(3,4,6)]

import <- X_15
import[, ncol(X_15)] <- factor(import[, ncol(X_15)])

ggplot() + 
  geom_point(aes(x=import[, 1], y=import[, 2], color=import[, ncol(import)] ), 
             #    colour = c("paleturquoise1", "rosybrown2"),
             size = I(2)) 



  geom_line(aes(x=import[import$SURFACE==1, ]$x,
                y=y_lin[import$SURFACE==1] ),
            color=c("skyblue2")) + 
  geom_line(aes(x=import[import$SURFACE==0, ]$x,
                y=y_lin[import$SURFACE==0]), 
            color=c("chartreuse4")) + 
  xlab("UVB") + 
  ylab("INHIBIT") +
  ggtitle("Practice 2") + 
  T + 
  scale_colour_manual(name="Surface",  
                      values = c("Deep"="steelblue4",
                                 "Surface"="seagreen3"))

sign



  