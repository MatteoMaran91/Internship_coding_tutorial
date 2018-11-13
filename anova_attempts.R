# Example of ANOVA in R with two factors
#
# Matteo Maran  maran@cbs.mpg,de
# 12 November 2018

# We will use a built-in dataset called ToothGrowth (description taken from http://www.sthda.com/english/wiki/r-built-in-data-sets#usarrests)
# This data set contains the result from an experiment studying the effect of vitamin C on tooth growth in 60 Guinea pigs.
# Each animal received one of three dose levels of vitamin C (0.5, 1, and 2 mg/day) by one of two delivery methods (orange juice or ascorbic acid (a form of vitamin C and coded as VC).

# The first factor (dose of Vitamin C) has three levels. The second factor (delivery method) has two levels. So we have a 3*2 two-factor design. 


# In case it is not already installed, install ggplot
install.packages("ggplot2")

##
rm(list=ls())                           # clear
library(ggplot2)                        # load ggplot 2


# We first import the data as a dataframe.
my_dataframe <- data.frame(ToothGrowth)

# Let's also have a look at its structure and explore it a bit
head(my_dataframe)                      # show beginning of the dataframe
str(my_dataframe)                       # show the structure
names(my_dataframe)                     # column names

# We can explore the different levels of each factor. For level we mean a condition.
levels(my_dataframe$supp)               # the factor delivery method (supp) has two levels, OJ and 
levels(my_dataframe$dose)               # here we get no levels (NULL). Since dose is a numeric vector, we might wanna convert it to a factor
my_dataframe$dose <- factor(my_dataframe$dose)               # see help("factor")

# Run anova
my_anova = aov(len ~ supp*dose, data = my_dataframe)
summary(my_anova)

# Post-hoc comparisons
TukeyHSD(my_anova, "dose")
TukeyHSD(my_anova, "supp")

# Anova corresponds to a linear model
my_lm <- lm(len ~ supp + dose+ supp:dose, data = my_dataframe)
summary(my_lm)

# Plot results
qplot(supp,len,data=my_dataframe , facets=~dose, main="Tooth growth of guinea pigs by supplement type and dosage (mg)",xlab="Supplement type", ylab="Tooth length") + geom_boxplot(aes(fill = supp))
qplot(dose,len,data=my_dataframe, facets=~supp, main="Tooth growth of guinea pigs by supplement type and dosage (mg)",xlab="Dose", ylab="Tooth length") + geom_boxplot(aes(fill = dose))
