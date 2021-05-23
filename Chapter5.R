# exploratory data analysis
# generate questions
# search for answers by visualizing, transforming, modelling
# use what you learn to refine/generate new questions

library(tidyverse)

# What type of variation occurs within my variables?
# What type of covariation occurs between my variables?

attach(diamonds)
colnames(diamonds)

 ggplot(diamonds)+
  geom_bar(aes(cut))

diamonds %>% 
  count(cut)

# diamonds %>% 
#   group_by(cut) %>% 
#   summarise(n=n())

# categorical:barplot, continous:histogram or density

ggplot(diamonds)+
  geom_histogram(aes(carat), binwidth = 0.5)

diamonds %>% 
  count(cut_width(carat, 0.5))

smaller <- diamonds %>% 
  filter(carat < 3)

ggplot(smaller, aes(carat)) + 
  geom_histogram(binwidth = 0.1)

ggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)

# Which values are the most common? Why?
# Which values are rare? Why? Does that match your expectations?
# Can you see any unusual patterns? What might explain them?

# subgroups
ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.01)

# short eruptions, long eruptions
ggplot(data = faithful, mapping = aes(x = eruptions)) + 
  geom_histogram(binwidth = 0.25)

?diamonds
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5)

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))

unusual <- diamonds %>% 
  filter(y < 3 | y > 20) %>% 
  select(price, x, y, z) %>%
  arrange(y)

# It’s good practice to repeat your analysis with and without the outliers.

# Exercises 1 ----
library(gridExtra)

x <-ggplot(diamonds)+
  geom_histogram(aes(x))
y <-ggplot(diamonds)+
  geom_histogram(aes(y))
z <-ggplot(diamonds)+
  geom_histogram(aes(z))
grid.arrange(x,y,z, nrow=3)

ggplot(diamonds, aes(price)) + 
  geom_histogram(binwidth = 1.5)

ggplot(diamonds, aes(price, color= cut)) + 
  geom_histogram(position= "stack",binwidth = 0.5)
# big dataset, makes smaller binwidths run slowly
dim(diamonds)

sum(diamonds$carat == 0.99)
sum(diamonds$carat == 1)

ggplot(diamonds, aes(price)) + 
  geom_histogram() + 
  coord_cartesian(xlim = c(0,5000))

ggplot(diamonds, aes(price)) + 
  geom_histogram() + 
  coord_cartesian(ylim = c(0,50))
# ----



