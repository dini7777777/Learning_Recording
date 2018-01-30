library(ggplot2)

p <- ggplot(data=util)
mylpot <- p + 
  geom_line(aes(x=PosixTime, y=utilization, color=Machine)) + 
  facet_grid(Machine~.) + 
  geom_hline(yintercept = 0.9, color="Grey", linetype=2)

# Save the plot to the list !

list_rl1$Plot <- mylpot 
list_rl1[6]
summary(list_rl1)
str(list_rl1)

# SUPER CONVENIENT on organizing your data



