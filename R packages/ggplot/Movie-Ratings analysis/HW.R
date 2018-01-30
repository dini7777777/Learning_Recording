

getwd()
Movies <- read.csv("Section6-Homework-Data.csv")
head(Movies)
colnames(Movies)[c(7,8,9,12,14,16,17,18)] <- c("Adjusted.Gross.mill","Budget.mill","Gross.mill","Overseas.mill","Profit.mill","Runtime.min","US.mill","Gross.US")

# Filtering

G <- Movies[, 3]== "action"|
  Movies[, 3]=="adventure"|
  Movies[, 3]=="animation"|
  Movies[, 3]=="comedy"|
  Movies[, 3]=="drama"

S <- Movies[, 6]=="Buena Vista Studios"|
  Movies[, 6]=="WB"|
  Movies[, 6]=="Fox"|
  Movies[, 6]=="Universal"|
  Movies[, 6]=="Sony"|
  Movies[, 6]=="Paramount Pictures"

Movies <- Movies[G&S,]

rm(S,G)


library(ggplot2)
p <- ggplot(data = Movies, aes(x=Genre, y=Gross.US) )

# Black Dots!
# Get rid of them later
p + geom_boxplot()


# Final touch
p$labels$size <- "Budget Millions"


p + geom_jitter( aes(size=Budget.mill, color=Studio)) + 
  geom_boxplot(alpha=0.3, outlier.color = NA) + 
  ggtitle("Domestic Gross % by Genre") + 
  theme(
    text = element_text(family = "Trajan Pro"),
    axis.title = element_text(color="Navy Blue", size=20),
    
    title = element_text(size=34),
    legend.title = element_text(size=20),
    legend.text = element_text(size=17)
    
  )
  



# Jitter instead of geom_point(aes(color=Studio))



# P.S.
ggplot(data=Movies, aes(x=Day.of.Week)) + geom_bar()
  


