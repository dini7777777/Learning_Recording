

getwd()
Movies <- read.csv("Movie-Ratings.csv")
head(Movies)

# Rename
colnames(Movies) <- c("Film", "Genre", "CriticRatings", "Audience.Ratings", "Budget", "Year")
head(Movies)
tail(Movies)
str(Movies)
summary(Movies)

# We don't wish the Year column be treated as numercial vector
head(factor(Movies$Year))
is.matrix(Movies$Year)
is.matrix(factor(Movies$Year))
str(factor(Movies$Year))

Movies$Year <- factor(Movies$Year)
summary(Movies)

# Aesthetics-----
library(ggplot2)

# add geometry
ggplot(data=Movies, aes(x=CriticRatings, y=Audience.Ratings)) +
  geom_point()

# add colour
ggplot(data=Movies, aes(x=CriticRatings, y=Audience.Ratings, colour=Genre)) +
  geom_point()

# add size
ggplot(data=Movies, aes(x=CriticRatings, y=Audience.Ratings,
       colour=Genre, size=Genre)) +
  geom_point()

# add size in a better way, more information in a plot
ggplot(data=Movies, aes(x=CriticRatings, y=Audience.Ratings,
                        colour=Genre, size=Budget)) +
  geom_point()





# Save the plotting as an object
p <- ggplot(data=Movies, aes(x=CriticRatings, y=Audience.Ratings,
                            colour=Genre, size=Budget)) +
  geom_point()
# With the dataframe ENCLOSED !!!
# You need to refresh it when your data is CHANGED !




# -----------------Multilayer-----------------

# Plot OVER LAYERS
p <- ggplot(data=Movies, aes(x=CriticRatings, y=Audience.Ratings,
                             colour=Genre, size=Budget))
# points
p + geom_point()
# lines
p + geom_line()

# BOTH
p + geom_point() + geom_line()
p + geom_line() + geom_point()
# the ORDERS Matters!


# -----------------Overriding Aesthetics-----------------

q <- ggplot(data=Movies, aes(x=CriticRatings, y=Audience.Ratings,
                                colour=Genre, size=Budget))
# ONLY add geom layer 
q + geom_point()

# Overwriting aes
# Ex1
q + geom_point(aes(size=CriticRatings))
#-----the old size of budget is overwritten!

# Ex2
q + geom_point(aes(colour=Budget))

# q remains the same
q + geom_point()

# Ex3 x,y axis
q + geom_point(aes(x=Budget))

# Ex4
q + geom_line() + geom_point()
 # Reduce line size
 q + geom_line(size=0.3) + geom_point()

# -----------------Mapping v.s. Setting-----------------
r <- ggplot(data=Movies, aes(x=CriticRatings, y=Audience.Ratings))
r + geom_point()

# Add colour
# 1. Mapping
r + geom_point(aes(colour=Genre))
# 2. Setting
r + geom_point(colour="Red")
# ERROR:
# r + geom_point(aes(colour="Red"))
# Mapping plot to the variable "Red" object


# 1.Mapping
r + geom_point(aes(size=Budget))
# 2.Setting
r + geom_point(size=3)
# ERROR:
# r + geom_point(aes(size=3))


# -----------------Mapping v.s. Setting-----------------
s <- ggplot(data=Movies, aes(x=Budget))
s + geom_histogram(binwidth = 7)

# add colour
s + geom_histogram(binwidth = 7, fill="Red")
s + geom_histogram(binwidth = 7, aes(colour=Genre))
s + geom_histogram(binwidth = 7, aes(fill=Genre))
s + geom_histogram(binwidth = 7, aes(fill=Genre), colour="Black")

# Density Charts
s + geom_density(aes(color=Genre))
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position = "stack")

# Start Overlaying
# Way 3
t <- ggplot(data=Movies, aes(x=Audience.Ratings))
t + geom_histogram(binwidth = 7, fill="White", color="Red")
# Way 4
t <- ggplot(data = Movies)
t + geom_histogram(aes(x=Audience.Ratings), binwidth=7, fill="White", color="Purple")
# Way 5
t <- ggplot()
t + geom_histogram(data=Movies, aes( x=Audience.Ratings), binwidth=7, fill="White", color="Purple")


# Statiscal transformation
? geom_smooth

u <- ggplot(data=Movies, aes(x=CriticRatings, y=Audience.Ratings, color=Genre))
u + geom_point(size=0.4) + geom_smooth(size=0.4, fill=NA)

# Boxplot
u <- ggplot(data=Movies, aes(x=Genre, y=Audience.Ratings, color=Genre))
u + geom_boxplot(size=2)
u + geom_point() + geom_boxplot()
u + geom_boxplot() + geom_point()

# Way 6
# Tip! Hack
# Throw randomly on x
u + geom_boxplot() + geom_jitter(size=0.5, alpha=0.4 )
# Another way
u + geom_jitter(size=0.5) + geom_boxplot(alpha=0.5)




# -----------------Using Facets-----------------
t <- ggplot(data=Movies, aes(x=Budget))
t + geom_histogram(aes(fill=Genre), color="black", binwidth = 10 )

# facets
t + geom_histogram(aes(fill=Genre), color="black", binwidth = 10 ) +
  facet_grid(Genre~. )
# Fixing axis so that they're not uniform on all histogram, chart won;t be small
t + geom_histogram(aes(fill=Genre), color="black", binwidth = 10 , size=0.3) +
  facet_grid(Genre~. , scales = "free")

# Scatterplots
w <- ggplot(data=Movies, aes(x=CriticRatings, y=Audience.Ratings, color=Genre))
w + geom_point()

w + geom_point() + facet_grid(Genre~.)
w + geom_point() + facet_grid(Year~.)
w + geom_point() + facet_grid(Genre~Year)
w + geom_point() + geom_smooth(size=1) + facet_grid(Genre~Year)
# Facet PLot 1
w + geom_point(aes(size=Budget)) + geom_smooth() + facet_grid(Genre~Year)


#-----Coordinates
# limits
# zoom
m <- ggplot(data=Movies, aes(x=CriticRatings, y=Audience.Ratings, size=Budget, color=Genre))
m + geom_point() + xlim(50,100) + ylim(50,100)


# This method doesn't always work well !
n <- ggplot(data=Movies, aes(x=Budget))
n + geom_histogram(aes(fill=Genre), color="Black", size=0.2)

n + geom_histogram(aes(fill=Genre), color="Black", size=0.2) + 
  ylim(0, 50)
# ^ Not good


# Zoom instead
n + geom_histogram(aes(fill=Genre), color="Black", size=0.2) + coord_cartesian(ylim = c(0,50))

# Improve 1
w + geom_point(aes(size=Budget)) + geom_smooth() + facet_grid(Genre~Year) +  coord_cartesian(ylim=c(0,100))


# -----------------Themes (Non data ink)-----------------
o <- ggplot(data=Movies, aes(x=Budget))
h <- o + geom_histogram(aes(fill=Genre), color="Black", size=0.4, binwidth=7)

# Axes Lables
h + xlab("Money Axis") + ylab("Number of Movies") + 
  ggtitle("Movie Budget Distribution") + 
  theme(text = element_text(colour = "Brown", size=27,  family = "Trajan Pro"),
      axis.title.x  = element_text(colour="Pink"),
      axis.title.y = element_text(colour="Navy Blue"),
      
      legend.background = element_rect(fill="Grey90"),
      legend.title = element_text(size=18),
      legend.text = element_text(size=18),
      legend.position = c(1,1),
      legend.justification = c(1,1),
      
      plot.title = element_text(size=50, family = "Times"),
      plot.subtitle = element_text(size = 20)
      )

?theme


