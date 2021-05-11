# install.packages("tidyverse")
library(tidyverse)

mpg
attach(mpg)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))

# Exercises ----
ggplot(data = mpg)

nrow(mpg)
ncol(mpg)

# the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd
mpg$drv
?mpg

ggplot(data = mpg) +
  geom_point(mapping = aes(x=hwy, y=cyl))

# type of car vs type of drive train
ggplot(data = mpg) +
  geom_point(mapping = aes(x=class, y=drv))

# ----
# two seater outliers
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=class))

# not a good idea
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size=class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, alpha=class))

# only 6 shapes at a time 
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy), color="blue")

# things to change: color, size, shape, fill

# Exercises 2 ----
# whats wrong 
ggplot(data = mpg) +
  geom_point(
    mapping = aes(x=displ, y=hwy, color="blue")
  )

# manufacturer, model, trans, drv, fl, class
sapply(colnames(mpg), function(x) class(mpg[[x]]))

# continuous variable mapping
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy), color=hwy)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy), size=hwy)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy), shape=hwy)

# multiple mappings
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy), shape=hwy,size=hwy,color=hwy)


?geom_point
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=displ,colour=class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=displ,colour=class), shape=hwy)


ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=displ < 5))

# ----
# single var
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) + 
  facet_wrap(~ class, nrow=2)

# two vars
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) + 
  facet_grid(drv~cyl)

# Exercises 3 ----
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) + 
  facet_wrap(~ displ, nrow=2)

# How do they relate?
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) + 
  facet_grid(drv~cyl)
ggplot(data = mpg) +
  geom_point(mapping = aes(x=drv, y=cyl))

# . means all variables <variable> ~ (is dependent) 
as.factor(drv)
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) + 
  facet_grid(drv ~ .)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) + 
  facet_grid(~ drv)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) + 
  facet_grid(.~ cyl)

# consider: for large dataset
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) + 
  facet_wrap(~ class, nrow=2)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, color=class)) 

# why doesn't facet_grid have ncol or nrow?
?facet_wrap

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) + 
  facet_wrap(~ class, ncol=2)

# why facet_grid with vars unique levels as columns?

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) + 
  facet_grid(~ drv)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, color=drv))


