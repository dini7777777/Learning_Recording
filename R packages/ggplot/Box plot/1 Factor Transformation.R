a <- c(3,4,3,3,7,9,2,3)
a
typeof(a)

b <- factor(a)
b
typeof(b)

## Levels of b
c <-as.numeric(b)
c
typeof(c)

d <- factor(b)
d
typeof(d)

rm(list=ls(all=TRUE))
########
# Char to numeric
a <- c("7","4","3","11")
a
typeof(a)

b <- as.numeric(a)
b
typeof(b)

# Factor to numeric
## You get LEVELS of the factors!
## CAUTION
f <- factor(c("7","4","3","11","15","12"))
f
typeof(f)

g <- as.numeric(f)
g
typeof(g)

# Solution:
# Use as.numeric only for CHARACTER
h <- as.numeric(as.character(f))
h
typeof(h)
