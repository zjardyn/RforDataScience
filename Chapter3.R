# install.packages("nycflights13")
library(nycflights13)
library(tidyverse)

# stats::filter()
# dplyr::filter()
attach(flights)
flights
# int, dbl, chr, dttm, lgl, fctr, date

# dplyr basics: filter() observations, arrange() rows, select() variables, mutate() new variables, summarise() many values down, as well as group_by() (changes scope of each function)

# select all flights on January 1st
filter(flights, month == 1, day == 1)

# assign it 
jan1 <- filter(flights, month == 1, day == 1)

# R either prints results or saves them as a variable, this does both
(dec25 <- filter(flights, month == 12, day == 25))

# comparisons
filter(flights, month = 1)

# dbl doesn't equal int
sqrt(2) ^ 2 == 2
1 / 49 * 49 == 1

near(sqrt(2) ^ 2,  2)
near(1 / 49 * 49, 1)

# booleans
# November or December
filter(flights, month == 11 | month == 12)

# equivalent
nov_dec <- filter(flights, month %in% c(11, 12))


# De Morgan's Law: !(x & y) is the same as !x | !y, and !(x | y) is the same as !x & !y.

filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

# missing values
NA > 5
10 == NA
NA + 10
NA / 2

NA == NA

# x and ys age. we don't know them.
x <- NA
y <- NA

# therefore we don't know if their ages are equal!
x == y

is.na(x)

df <- tibble(x = c(1, NA, 3))

filter(df, x > 1)
filter(df, is.na(x) | x > 1)

# Exercises 1 ----
# flights
colnames(flights)
filter(flights, arr_delay >= 2)
filter(flights, dest %in% c("IAH", "HOU"))
unique(flights$carrier)
filter(flights, carrier %in% c("UA", "AA", "DL"))
filter(flights, month %in% 7:9)
# De morgan's law
(x <- filter(flights, arr_delay > 2 & dep_delay < 0))
(y <- filter(flights, !(arr_delay <= 2 | dep_delay >= 0)))
all.equal(x, y)
# checks out!
filter(flights, dep_delay >= 1 & sched_arr_time - arr_time >30)
flights$dep_time
filter(flights, dep_time %in% 0:600)

?between
(x <- filter(flights, month %in% 7:9))
(y <- filter(flights, between(month, 7,9)))
all.equal(x,y)
(x <- filter(flights, dep_time %in% 0:600))
(y <- filter(flights, between(dep_time, 0, 600)))
all.equal(x,y)

sum(is.na(flights$dep_time))
apply(flights, 2, function(x) sum(is.na(x)))
# canceled flights?

NA ^ 0
NA | TRUE
FALSE & NA

TRUE & NA
NA * 0

# ----

arrange(flights, year, month, day)
arrange(flights, desc(dep_delay))

df <- tibble(x = c(5, 2, NA))
