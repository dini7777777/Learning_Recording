
setwd("/Users/dini/Documents/東西丟這/R/Udemy Advanced/Section 2")

fin <-read.csv("Future-500.csv")

head(fin)
str(fin)

# Dangerous
#fin$Profit <-factor(fin$Profit)

head(fin)
str(fin)
summary(fin)

# DANGEROUS  ->> Wrong number
# fin$Profit <- as.numeric(fin$Profit)

# Correct

#---------sub() gsub()--------
# Replace pattern
fin$Expenses <- gsub(" Dollars", "", fin$Expenses)
str(fin)
fin$Expenses <- gsub(",", "", fin$Expenses)
str(fin)

# Escape sequences: "\\"
# For specific sign
fin$Revenue <- gsub("\\$","",fin$Revenue)
fin$Revenue <- gsub(",","",fin$Revenue)
str(fin)

fin$Growth <- gsub("%","",fin$Growth)
str(fin)

# Back to num
fin$Revenue <- as.numeric(fin$Revenue)
fin$Expenses <- as.numeric(fin$Expenses)
fin$Growth <- as.numeric(fin$Growth)
str(fin)

fin$Revenue <- as.integer(fin$Revenue)
fin$Expenses <- as.integer(fin$Expenses)
fin$Growth <- as.integer(fin$Growth)
str(fin)
summary(fin)


typeof(fin$Growth)







