# install.packages("tidyverse")
# install.packages("maps")
library(tidyverse)
library(maps)

mpg
attach(mpg)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))

# Exercises 1 ----
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

# ----
# different geoms
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy))
# try other categorical vars
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy, linetype=drv))

# every geom function takes a mapping arg but not every aesthetic works with every geom
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy, group =drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy, color =drv),
              show.legend = F)

# add multiple geom layers
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) +
  geom_smooth(mapping = aes(x=displ, y=hwy))

# less redundant
ggplot(data = mpg, mapping = aes(x=displ, y=hwy) ) +
  geom_point() +
  geom_smooth()

# different aesthetics in different layers
ggplot(data = mpg, mapping = aes(x=displ, y=hwy) ) +
  geom_point(mapping = aes(colour= class)) +
  geom_smooth() # can add a group mapping here too!

ggplot(data = mpg, mapping = aes(x=displ, y=hwy) ) +
  geom_point(mapping = aes(colour= class)) +
  geom_smooth(
    data=filter(mpg, class == "subcompact"),
    se = F)

# Exercises 4 ----
# geome_smooth for line charts

# notice how color=drv will affect the lines!
ggplot(
  data = mpg,
  mapping = aes(x=displ, y=hwy,color=drv) 
  ) +
  geom_point() +
  geom_smooth(se=FALSE) 

# show.legend = F removes the legend 

?geom_smooth

# se=F removes confidence interval from loess line!

ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point() +
  geom_smooth()

# or 

ggplot() +
  geom_point(data = mpg,
             mapping = aes(x=displ, y=hwy)
             ) +
  geom_smooth(data = mpg,
              mapping = aes(x=displ, y=hwy)
              )

# 6 graphs 

ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point() +
  geom_smooth(se=F)

ggplot(data = mpg, mapping = aes(x=displ, y=hwy, group = drv)) +
  geom_point() +
  geom_smooth(se=F)

ggplot(data = mpg, mapping = aes(x=displ, y=hwy, color = drv)) +
  geom_point() +
  geom_smooth(se=F)

ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(se=F)

ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(se=F,mapping = aes(linetype = drv))


ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point(mapping = aes(color = drv)) 

# ----
# statistical transformations
detach(mpg)
attach(diamonds)
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x=cut))

# bar charts, histograms, and freq polygons bin your data and then plot bin counts. smoothers fit a mod and then plot preds from mod. boxplots compute a summary of the dist and display a formatted box.

# the algo used to calc new values is the stat. in this case count stat.

? geom_bar # computed variables

ggplot(data = diamonds) + 
  stat_count(mapping = aes(x=cut))

# every geom has a default stat and every stat has a default geom

# change stat of geom_bar from count to identity (use raw data)
demo <- tribble(
  ~a,      ~b,
  "bar_1", 20,
  "bar_2", 30,
  "bar_3", 40
)

ggplot(data = demo) +
  geom_bar(
    mapping = aes(x = a, y = b), stat = "identity"
  )

# override default mapping from transformed vars to aesthetics
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x=cut, y=..prop.., group=1))

# summarize y values for each unique x value
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x=cut, y= depth),
    fun.ymin = min, 
    fun.ymax = max,
    fun.y = median
  )

# Exercises 5 ----
# default geom is "pointrange"
?stat_summary

ggplot(diamonds) +
  geom_pointrange(mapping = aes(x=cut, y=depth, ymin = depth, ymax = depth))

?geom_smooth
?stat_smooth

?geom_boxplot
?stat_boxplot

# etc

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x=cut))

ggplot(data = diamonds) + 
  geom_col(mapping = aes(x=cut, y=depth))

?geom_col
#  geom_bar() makes the height of the bar proportional to the number of cases in each group, geom_col() uses stat_identity(): it leaves the data as is.

?stat_smooth
# computed variables are y, ymin, ymax, se. 
# position, method (lm glm loess, etc), formula: poly etc, se:confidence interval

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x=cut, y=..prop.., group=1))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x=cut, y=..prop..))

# ----
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x=cut, color=cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x=cut, fill=cut))

# each colored rectangle is a combo of cut and clarity! but info is missing
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x=cut, fill=clarity))

# change alpha or have no fill
ggplot(data = diamonds,
       mapping = aes(x=cut, fill=clarity)
       ) + 
  geom_bar(alpha=1/5, position="identity")

ggplot(data = diamonds,
       mapping = aes(x=cut, color=clarity)
) + 
  geom_bar(fill=NA, position="identity")

# easier to compare proportions across groups
ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x=cut, fill=clarity),
    position = "fill"
  )

# proportional comparison
ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x=cut, fill=clarity),
    position = "dodge"
  )

# dealing with overplotting
detach(diamonds)
attach(mpg)

ggplot(data=mpg)+
  geom_point(
    mapping = aes(x=displ,y=hwy),
    position = "jitter"
  )
# less accurate at small scales, more revealing at large scales

# Exercises 6 ----
ggplot(data=mpg, mapping=aes(x=cty, y=hwy))+
  geom_point()

ggplot(data=mpg, mapping=aes(x=cty, y=hwy))+
  geom_smooth()

?geom_jitter
# amount controlled by width and height

# The jitter geom is a convenient shortcut for geom_point(position = "jitter"). It adds a small amount of random variation to the location of each point, and is a useful way of handling overplotting caused by discreteness in smaller datasets.

?geom_count
# This is a variant geom_point() that counts the number of observations at each location, then maps the count to point area. It useful when you have discrete data and overplotting.

ggplot(data=mpg,  mapping=aes(x=displ, y=hwy))+
  geom_count()
  
ggplot(data=mpg,  mapping=aes(x=displ, y=hwy))+
  geom_jitter()  

?geom_boxplot  
# position = "dodge2" 

ggplot(data=mpg,  mapping=aes(x=class, y=hwy)) +
  geom_boxplot()

# ----
ggplot(data=mpg,  mapping=aes(x=class, y=hwy)) +
  geom_boxplot() + coord_flip()

nz <- map_data("nz")

ggplot(nz, aes(long, lat, group=group)) +
  geom_polygon(fill = "white", color = "black")

ggplot(nz, aes(long, lat, group=group, color = region == "South.Island" && "North.Island")) +
  geom_polygon()

bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill= cut), 
    show.legend = F,
    width = 1
  ) +
  theme(aspect.ratio = 1) + 
  labs( x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

# Exercises 6 ----

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x=cut, fill=clarity), width = 1) +
  theme(aspect.ratio = 1) +
  labs( x = NULL, y = NULL) +
  coord_polar()

?labs

?coord_quickmap() # approximation
?coord_map

ggplot(mpg, aes(cty, hwy)) + 
  geom_point() +
  geom_abline() +
  coord_fixed()
