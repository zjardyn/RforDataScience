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

# onlyt 6 shapes at a time 
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=class))
