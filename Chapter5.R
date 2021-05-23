# https://brshallo.github.io/r4ds_solutions/07-exploratory-data-analysis.html#covariation 
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
# remove
diamonds2 <- diamonds %>% 
  filter(between(y,3,20))
# set to NA
diamonds2 <- diamonds %>% 
  mutate(y=ifelse(y < 3 | y > 20, NA, y))

ggplot(diamonds2, aes(x,y)) +
  geom_point()

ggplot(diamonds2, aes(x,y)) +
  geom_point(na.rm = T)

nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(mapping = aes(sched_dep_time)) + 
  geom_freqpoly(mapping = aes(colour = cancelled), binwidth = 1/4)

# Exercises 2 ----
ggplot(diamonds2, aes(cut))+ 
  geom_bar()

ggplot(diamonds2, aes(y))+
  geom_histogram()

sum(diamonds2$y, na.rm = T)
mean(diamonds2$y, na.rm = T)
#----
# hard to see difference because the overall counts differ so much
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)
ggplot(diamonds) + 
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)

ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot()
# unordered
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()
# ordered by medain of hwy
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) +
  coord_flip()

# Exercises 3 ----
nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(mapping = aes(x=sched_dep_time, y=..density..)) + 
  geom_freqpoly(mapping = aes(colour = cancelled), binwidth = .25)+
  xlim(c(5,25))

nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(mapping = aes(x=sched_dep_time)) + 
  geom_density(mapping = aes(fill = cancelled), alpha = 0.30)+
  xlim(c(5,25))

cor(diamonds$price, select(diamonds, carat, depth, table, x, y, z))

ggplot(data = diamonds, aes(x = cut, y = carat))+
  geom_boxplot()+
  coord_flip()

# install.packages("ggstance")
# install.packages("lvplot")
# install.packages("ggbeeswarm")
library(ggstance)
library(lvplot)
library(ggbeeswarm)

x <- ggplot(diamonds)+
  ggstance::geom_boxploth(aes(x = carat, y = cut))

y <- ggplot(diamonds)+
  geom_boxplot(aes(x = cut, y = carat))+
  coord_flip()

grid.arrange(x, y, nrow=2)

set.seed(1234)
diamonds %>% 
  ggplot()+
  lvplot::geom_lv(aes(x = cut, y = price))

set.seed(1234)
diamonds %>% 
  ggplot()+
  geom_boxplot(aes(x = cut, y = price))

diamonds %>% 
  ggplot()+
  lvplot::geom_lv(aes(x = cut, y = price, alpha = ..LV..), fill = "blue")+
  scale_alpha_discrete(range = c(0.7, 0))

diamonds %>% 
  ggplot()+
  lvplot::geom_lv(aes(x = cut, y = price, fill = ..LV..))

ggplot(diamonds,aes(x = cut, y = carat))+
  geom_violin()

ggplot(diamonds,aes(colour = cut, x = carat, y = ..density..))+
  geom_freqpoly()

ggplot(mpg, aes(x = displ, y = cty, color = drv))+
  geom_point()    

ggplot(mpg, aes(x = displ, y = cty, color = drv))+
  geom_jitter()

ggplot(mpg, aes(x = displ, y = cty, color = drv))+
  geom_beeswarm()

ggplot(mpg, aes(x = displ, y = cty, color = drv))+
  geom_quasirandom()

plot_orig <- ggplot(mpg, aes(x = displ, y = cty, color = drv))+
  geom_point()

plot_bees <- ggplot(mpg, aes(x = 1, y = cty, color = drv))+
  geom_beeswarm()

plot_quasi <- ggplot(mpg, aes(x = 1, y = cty, color = drv))+
  geom_quasirandom()

gridExtra::grid.arrange(plot_orig, plot_bees, plot_quasi, ncol = 1)
# ----
# visualize covariation
ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color))

diamonds %>% 
  count(color, cut)

diamonds %>% 
  count(color, cut) %>%  
  ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = n))

# Exercises 4 ----

cut_in_color_graph <- diamonds %>% 
  group_by(color, cut) %>% 
  summarise(n = n()) %>% 
  mutate(proportion_cut_in_color = n/sum(n)) %>%
  ggplot(aes(x = color, y = cut))+
  geom_tile(aes(fill = proportion_cut_in_color))+
  labs(fill = "proportion\ncut in color")

cut_in_color_graph

flights %>% 
  group_by(dest, month) %>% 
  summarise(delay_mean = mean(dep_delay, na.rm=TRUE), 
            n = n()) %>% 
  mutate(sum_n = sum(n)) %>% 
  select(dest, month, delay_mean, n, sum_n) %>% 
  as.data.frame() %>% 
  filter(dest == "ABQ") %>% 
  #the sum on n will be at the dest level here
  filter(sum_n > 30) %>% 
  ggplot(aes(x = as.factor(month), y = dest, fill = delay_mean))+
  geom_tile()

cut_in_color_graph

cut_in_color_graph+
  coord_flip()
# ----
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price))

ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, y = price), alpha = 1 / 100)

# install.packages("hexbin")
library(hexbin)
ggplot(data = smaller) +
  geom_bin2d(mapping = aes(x = carat, y = price))
ggplot(data = smaller) +
  geom_hex(mapping = aes(x = carat, y = price))

ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))

ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))

# Exercises 5 ----
##violin
ggplot(smaller, aes(x = carat, y = price))+
  geom_violin(aes(group = cut_width(carat, 0.1)))

ggplot(smaller, aes(x = carat, y = price))+
  geom_violin(aes(group = cut_number(carat, 20)))

##letter value
ggplot(smaller, aes(x = carat, y = price))+
  lvplot::geom_lv(aes(group = cut_width(carat, 0.1)))

ggplot(smaller, aes(x = carat, y = price))+
  lvplot::geom_lv(aes(group = cut_number(carat, 20)))

ggplot(smaller, aes(x = carat, y = price))+
  geom_violin(aes(group = cut_number(carat, 10)))

ggplot(smaller, aes(x = carat, y = price))+
  geom_violin(aes(group = cut_width(carat, 0.25)))

ggplot(smaller, aes(x = price)) +
  geom_freqpoly(aes(colour = cut_number(carat, 10)))

library(plotly)
p <- ggplot(smaller, aes(x=price))+
  geom_freqpoly(aes(colour = cut_width(carat, 0.25)))

plotly::ggplotly(p)

ggplot(diamonds, aes(x = price, y = carat))+
  geom_violin(aes(group = cut_width(price, 2500)))
# price dist of large vs small diamonds
diamonds %>% 
  mutate(percent_rank = percent_rank(carat),
         small = percent_rank < 0.025,
         large = percent_rank > 0.975) %>% 
  filter(small | large) %>% 
  ggplot(aes(large, price)) +
  geom_violin()+
  facet_wrap(~large)

ggplot(diamonds, aes(x = carat, y = price))+
  geom_jitter(aes(colour = cut), alpha = 0.2)+
  geom_smooth(aes(colour = cut))

ggplot(diamonds, aes(x = carat, y = price))+
  geom_boxplot(aes(group = cut_width(carat, 0.5), colour = cut))+
  facet_grid(. ~ cut)

diamonds %>% 
  mutate(carat = cut(carat, 5)) %>% 
  ggplot(aes(x = carat, y = price))+
  geom_boxplot(aes(group = interaction(cut_width(carat, 0.5), cut), fill = cut), position = position_dodge(preserve = "single"))

ggplot(data = diamonds) +
  geom_point(mapping = aes(x = x, y = y)) +
  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11))

ggplot(data = diamonds) +
  geom_boxplot(mapping = aes(x = cut_width(x, 1), y = y)) +
  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11))


all_states <- map_data("state")
p <- geom_polygon(data = all_states, 
                  aes(x = long, y = lat, group = group, label = NULL), 
                  colour = "white", fill = "grey10")

dest_regions <- nycflights13::airports %>% 
  mutate(lat_cut = cut(percent_rank(lat), 2, labels = c("S", "N")),
         lon_cut = cut(percent_rank(lon), 2, labels = c("W", "E")),
         quadrant = paste0(lat_cut, lon_cut)) 

point_plot <- dest_regions %>%
  ggplot(aes(lon, lat, colour = quadrant))+
  p+
  geom_point()

point_plot+
  coord_quickmap()
# ----
ggplot(data = faithful) + 
  geom_point(mapping = aes(x = eruptions, y = waiting))
# variation creates uncertainty, covariation reduces it

# The residuals give us a view of the price of the diamond, once the effect of carat has been removed

library(modelr)

mod <- lm(log(price) ~ log(carat), data = diamonds)

diamonds2 <- diamonds %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))

ggplot(data = diamonds2) + 
  geom_point(mapping = aes(x = carat, y = resid))

ggplot(data = diamonds2) + 
  geom_boxplot(mapping = aes(x = cut, y = resid))

ggplot(data = faithful, mapping = aes(x = eruptions)) + 
  geom_freqpoly(binwidth = 0.25)

ggplot(faithful, aes(eruptions)) + 
  geom_freqpoly(binwidth = 0.25)

diamonds %>% 
  count(cut, clarity) %>% 
  ggplot(aes(clarity, cut, fill = n)) + 
  geom_tile()

# 