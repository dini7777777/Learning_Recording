library(ggplot2)

# Classify Industry with all the money
p <- ggplot(data=fin)
p
p + geom_point( aes(x=Revenue, y=Expenses, color=Industry, size=Profit) )


# Scatter plot withIndustry trends
d <- ggplot(data=fin, aes(x=Revenue, y=Expenses, color=Industry) )
d + geom_point() + geom_smooth( fill=NA, size=0.7)

# Boxplot
f <- ggplot( data=fin, aes( x=Industry, y=Growth, color=Industry ))
f + geom_boxplot(outlier.colour =NA, alpha=0.7) + geom_jitter(alpha=0.5)




