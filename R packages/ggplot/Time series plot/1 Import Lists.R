
setwd("/Users/dini/Documents/東西丟這/R/Udemy Advanced/Section 3")

util <- read.csv("Machine-Utilization.csv")
head(util)
tail(util)
str(util)
summary(util)

# Derive Utilization Column
util$utilization <- 1 - util$Percent.Idle
head(util, 15)

# Data-times
tail(util, 15)
?POSIXct
util$PosixTime <- as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")
head(util, 15)
#delete old one
util$Timestamp <- NULL





# Goal:
# A Lists with:
#/ Machine name
#/ Mean max min per month
#/ fall below 90% or not
#/ all Hours with rate unknown
#/ dataframe per machine
#/ Plot for all machine


#------Lists-----
RL1 <- util[util$Machine=="RL1",]
summary(RL1)

util$Machine <- factor(util$Machine)

util_stats_rl1 <-c(min(RL1$utilization, na.rm = T),
                   mean(RL1$utilization, na.rm = T),
                   max(RL1$utilization, na.rm = T) )
util_stats_rl1

rl1_under90_flag <- length(util_stats_rl1 < 0.9) > 0

list_rl1 <- list("RL1", util_stats_rl1, rl1_under90_flag)
list_rl1

# Naming names
# Way 1
names(list_rl1)
names(list_rl1) <- c("Machine", "Stats", "LowThreshold" )
list_rl1
# Way 2
list_rl1_ <- list(Machine="RL1", Status=util_stats_rl1, LowThreshold=rl1_under90_flag)
list_rl1_

#------Extract component of a list-----
# Three Ways:
# [] - get a list
# [[]] - get a actual object
# $ - a prettier form of [[]]
list_rl1[2]
list_rl1[[2]]
typeof(list_rl1[2])
typeof(list_rl1[[2]])

list_rl1[2:3]
# Wrong:
# list_rl1[[2:3]]
typeof(list_rl1[2:3])
typeof(list_rl1[[2:3]])

# To get one element
list_rl1[[2]][3]
list_rl1$Stats[3]
# Wrong:
# list_rl1[2][3]

# Adding or deleting component of a list
# Way 1
list_rl1[4] <- "Newcomponent"
list_rl1
# Way 2
RL1
list_rl1$UnknownHours <- RL1[is.na(RL1$utilization), "PosixTime"]
list_rl1

list_rl1$Data <- RL1
summary(list_rl1)
str(list_rl1)
# Also can add dataframe to list

# Delete
list_rl1[4] <- NULL
# Notice! the numeration shifted!
# Unlike dataframe

# P.S.
# If add to very after, the space will be NULL
# Ex:
# list_rl1[7] <- "New"


#-----Subsetting a list------
# Using []
list_rl1[2:4]
list_rl1[c(2, 4)]
# similiar to vextors

# Wrong:
# list_rl1[[2:4]]
# Only Specity one thing in [[]]






