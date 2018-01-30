head(fin,25)
complete.cases(fin)

fin[!complete.cases(fin),]
# We found out that EMEPTY CHARACTERS are not counted as NA

# Solution
fin <-read.csv("Future-500.csv", na.strings = c("", " "))
str(fin)

# ------Find NA s---------
# Way 1
fin[!complete.cases(fin),]

# Way 2
# By each rows filtering
# Only ONE Row at a time
fin[is.na(fin$Expenses),]
# Rows with Expenses NA
# cause is.na check every elemants
k <- is.na(fin)


# Removing them with backup (Just in case)!
finbackup <- fin
fin[!complete.cases(fin),]
fin[is.na(fin$Industry),]
# Reassign with rows without NA in Industry
fin <- fin[!is.na(fin$Industry),]
str(fin)


#---------Reseting dataframe index (rownames)-------
fin
rownames(fin) <- 1:nrow(fin)
# Quicker Way
fin <- finbackup
fin <- fin[!is.na(fin$Industry),]
rownames(fin) <- NULL
tail(fin)


#------------Replacing missing data----------
#=====With KNOWN data=====
# New York city is in NewYork State
fin[is.na(fin$State) & fin$City=="New York", "State"] <- "NY"
fin[fin$City=="New York", ]
# Check

# San Francisco in CA
fin[is.na(fin$State)  & fin$City=="San Francisco", "State"] <-"CA"
fin[fin$City=="San Francisco", ]

# Check all city are fulfilled!
fin[!complete.cases(fin$City),]


#===== With Mean/Median =====
# Employees
fin[!complete.cases(fin$Employees),]
fin[!complete.cases(fin$Employees) & fin$Industry=="Retail", "Employees"] <- median( fin[ fin$Industry=="Retail", "Employees"] , na.rm = T)
fin[fin$Industry=="Retail",]
# Check

mean(fin$Employees, na.rm = T)
median(fin$Employees, na.rm = T)

# Another one
med_empl_FNserv <- median( fin[ fin$Industry=="Financial Services", "Employees"] , na.rm = T)

fin[!complete.cases(fin$Employees) & fin$Industry=="Financial Services", "Employees"] <- med_empl_FNserv
fin[fin$Industry=="Financial Services",]
# Check

# Groth
med_gro_Cons <- median( fin[ fin$Industry=="Construction", "Growth"] , na.rm = T)
fin[!complete.cases(fin$Growth) & fin$Industry=="Construction", "Growth"] <- med_gro_Cons
fin[fin$Industry=="Construction", ]
# Check 


fin[!complete.cases(fin),]
# Two companies dont havve all the MONEY data !
# Both in construction Industry

med_expens_Cons <- median(fin[fin$Industry=="Construction", "Expenses"], na.rm = T)
Lost_another <- !complete.cases(fin$Expenses) & (!complete.cases(fin$Revenue) | !complete.cases(fin$Profit) )
fin[Lost_two & fin$Industry=="Construction", "Expenses"] <- med_expens_Cons
fin[fin$Industry=="Construction", ]

med_rev_Cons <- median(fin[fin$Industry=="Construction", "Revenue"], na.rm = T)
Lost_two <- !complete.cases(fin$Revenue) | !complete.cases(fin$Profit)
fin[Lost_two & fin$Industry=="Construction", "Revenue"] <- med_rev_Cons



# data available via Caculating
# Revenue - Expenses = Profit
fin[!complete.cases(fin),]
fin[is.na(fin$Profit), "Profit"] <- fin[is.na(fin$Profit), "Revenue"] - fin[is.na(fin$Profit), "Expenses"]
fin[is.na(fin$Expenses), "Expenses"] <- fin[is.na(fin$Expenses), "Revenue"] - fin[is.na(fin$Expenses), "Profit"]



# Output
write.csv(fin, file="Future-500_cleandata.csv")




