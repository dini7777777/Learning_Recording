head(fin)
fin$Revenue == 14016543



fin[fin$Revenue == 14016543, ]
# NA rows, besause:
complete.cases(fin$Revenue == 14016543)
# Not ALL TRUE

# Solution
fin[which(fin$Revenue == 14016543), ]









