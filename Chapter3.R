# answers to exercises: https://jrnold.github.io/r4ds-exercise-solutions/transform.html#exercise-5.6.1

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
# dbl (float) doesn't equal int
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
(x <- filter(flights, arr_delay >= 120 & dep_delay <= 0))
(y <- filter(flights, !(arr_delay < 120 | dep_delay > 0)))
all.equal(x, y)
# checks out!
filter(flights, dep_delay >= 60, dep_delay > arr_delay + 30)
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
# sort rows with arrange
arrange(flights, year, month, day)
arrange(flights, desc(dep_delay))

df <- tibble(x = c(5, 2, NA))
# missing values at the end
arrange(df, x)
arrange(df, desc(x))

# Exercises 2 ----
arrange(df, desc(is.na(x)))
colnames(flights)
arrange(flights, desc(dep_delay))
arrange(flights, dep_delay)
# v = d/t
arrange(flights, desc(distance/air_time))
arrange(flights, desc(distance))
arrange(flights, distance)

# ----
# select columns
colnames(flights)
select(flights, year, month, day)
# slice
select(flights, year:day)
# everything but
select(flights, -(year:day))

# helper funcs

# starts_with
# ends_with
# contains
# matches
# num_range

# renaming
rename(flights, tail_num = tailnum)

# select a few first, then the rest
select(flights, time_hour, air_time, everything())

# Exercises 3 ----
select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, starts_with('dep'), starts_with('arr'))

select(flights, dep_time, dep_time)

vars <- c("year", "month", "day", "dep_delay", "arr_delay")
select(flights, any_of(vars))

select(flights, contains("TIME"))
?contains
select(flights, contains("TIME", ignore.case = F))

# ----
# add new vars with mutate
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)

flights_new <- mutate(flights_sml,
                      gain = dep_delay - arr_delay,
                      speed = distance / air_time * 60
)

View(flights_new)

mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)

transmute(flights,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

# must be vectorized: input is vector, output is vector of same length
# arithmetic operators: +, -, *, /, ^, are vectorized as they use "recycling"

# modular arithmetic: %/% (integer division) and %% (remainder)
transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100)

# logs: log(), log2(), log10(), transforming across magnitudes. log2 is most interpretable

# offsetting 
(x <- 1:10)
lag(x)
lead(x)

# Cumulative and rolling aggregates:cumsum(), cumprod(), cummin(), cummax(), dplyr::cummean()

x
cumsum(x)
cummean(x)

y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)
min_rank(desc(y))

# also try row_number(), dense_rank(), percent_rank(), cume_dist(), ntile()
y
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)

# Exercises 4 ----
flights_new <- select(flights,
                      dep_time,
                      sched_dep_time,
                      air_time,
                      arr_time,
                      dep_delay)

flights_new <- mutate(flights_new,
          dep_min_midn = (dep_time %/% 100) * 60 + dep_time %% 100,
          sched_dep_min_midn = (sched_dep_time %/% 100) * 60 + sched_dep_time %% 100)

transmute(flights_new, 
          air_time,
          air_time2 = arr_time - dep_time)

flights_new <- mutate(flights_new,
          arr_min_midn = (arr_time %/% 100) * 60 + arr_time %% 100,
          )

flights_new <- mutate(flights_new, 
                      flight_time = arr_min_midn - dep_min_midn)

select(flights_new, air_time, flight_time)

sum(flights_new$air_time == flights_new$flight_time, na.rm = TRUE)

# clock format, difference is in dep_delay
select(flights_new, dep_time, sched_dep_time, dep_delay)

# min_rank() is equivalent to rank() method with the argument ties.method = 'min'
head(arrange(flights_new, min_rank(desc(dep_delay))), 10)
?min_rank

# recycling
1:3 + 1:10

?sin

# ----

# group with summarise, collapse down to a single row
summarise(flights, delay = mean(dep_delay, na.rm = T))

# pair it with group by
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)

delay <- filter(delay, count > 20, dest != "HNL")
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# group by dest then summarise then filter noise, all in one with pipe
delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")


flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay, na.rm = TRUE))

# save new dataset
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

# include counts in aggregates

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay)
  )

ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)

# number of flights vs average delay
delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )
# variation decrease as n increases    
ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
      geom_point(alpha = 1/10)

delays %>% 
  filter(n > 25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)


# same pattern
# Convert to a tibble so it prints nicely
# install.packages("Lahman")
library(Lahman)
batting <- as_tibble(Lahman::Batting)

batters <- batting %>% 
  group_by(playerID) %>% 
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

batters %>% 
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() + 
  geom_smooth(se = FALSE)

batters %>% 
  arrange(desc(ba))

# useful summary funcs

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0]) # the average positive delay
  )

# measures of spread: sd(x), IQR(x), mad(x)
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

# rank measures: min(x), quantile(x, 0.25), max(x)
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

# measures of position: first(x), nth(x, 2), last(x), similar to indexing
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first_dep = first(dep_time), 
    last_dep = last(dep_time)
  )

not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r))

# To count the number of non-missing values, use sum(!is.na(x))
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))

not_cancelled %>% 
  count(dest)

not_cancelled %>% 
  count(tailnum, wt = distance)

# How many flights left before 5am? (these usually indicate delayed
# flights from the previous day)
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(n_early = sum(dep_time < 500))


# What proportion of flights are delayed by more than an hour?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_prop = mean(arr_delay > 60))

daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))

daily %>% 
  ungroup() %>%             # no longer grouped by date
  summarise(flights = n())  # all flights

# Exercises 5 ----

# flight delay is costly to passengers, arrival delay is more costly because it can impact later stages of travel. if arrival delay doesnt impact departure delay then it wont matter.

not_cancelled %>% 
  count(dest)

not_cancelled %>%
  group_by(dest)  %>%
  summarise(n=n())
# count() counts number of instances within each group of vars
not_cancelled %>%
  count(tailnum, wt=distance)

not_cancelled %>%
  group_by(tailnum)  %>%
  summarise(n=sum(distance))

apply(flights, 2, function(x) sum(is.na(x)))
# air time, arr_delay

cancelled_per_day <- flights %>% 
  mutate(cancelled = (is.na(arr_delay) | is.na(dep_delay))) %>%
  group_by(year, month, day) %>%
  summarise(
    cancelled_num = sum(cancelled),
    flights_num = n(),
  )

ggplot(cancelled_per_day) +
  geom_point(aes(x = flights_num, y = cancelled_num)) 

cancelled_and_delays <- 
  flights %>%
  mutate(cancelled = (is.na(arr_delay) | is.na(dep_delay))) %>%
  group_by(year, month, day) %>%
  summarise(
    cancelled_prop = mean(cancelled),
    avg_dep_delay = mean(dep_delay, na.rm = TRUE),
    avg_arr_delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  ungroup()

ggplot(cancelled_and_delays) +
  geom_point(aes(x = avg_dep_delay, y = cancelled_prop))

ggplot(cancelled_and_delays) +
  geom_point(aes(x = avg_arr_delay, y = cancelled_prop))

flights %>%
  group_by(carrier) %>%
  summarise(arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(desc(arr_delay))

filter(airlines, carrier == "F9")

flights %>%
  filter(!is.na(arr_delay)) %>%
  # Total delay by carrier within each origin, dest
  group_by(origin, dest, carrier) %>%
  summarise(
    arr_delay = sum(arr_delay),
    flights = n()
  ) %>%
  # Total delay within each origin dest
  group_by(origin, dest) %>%
  mutate(
    arr_delay_total = sum(arr_delay),
    flights_total = sum(flights)
  ) %>%
  # average delay of each carrier - average delay of other carriers
  ungroup() %>%
  mutate(
    arr_delay_others = (arr_delay_total - arr_delay) /
      (flights_total - flights),
    arr_delay_mean = arr_delay / flights,
    arr_delay_diff = arr_delay_mean - arr_delay_others
  ) %>%
  # remove NaN values (when there is only one carrier)
  filter(is.finite(arr_delay_diff)) %>%
  # average over all airports it flies to
  group_by(carrier) %>%
  summarise(arr_delay_diff = mean(arr_delay_diff)) %>%
  arrange(desc(arr_delay_diff))

flights %>%
  count(dest, sort = TRUE)
# ----
# grouped mutates
# worst members
flights_sml %>% 
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)

# threshold
popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365)
popular_dests

popular_dests %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)

# Exercises 6

# summary funcs: mean(), lead(), lag(), min_rank(), row_number(), in combination with group_by( ) in a mutate or filter

a_tibble <- tibble(x = 1:9,
       group = rep(c("a", "b", "c"), each = 3)) 

a_tibble %>%
  mutate(x_mean = mean(x)) %>%
  group_by(group) %>%
  mutate(x_mean_2 = mean(x))

# operators not affected by group_by()

a_tibble %>%
  mutate(y = x + 2) %>%
  group_by(group) %>%
  mutate(z = x + 2)

a_tibble %>%
  mutate(y = x %% 2) %>%
  group_by(group) %>%
  mutate(z = x %% 2)

a_tibble %>%
  mutate(y = log(x)) %>%
  group_by(group) %>%
  mutate(z = log(x))

a_tibble %>%
  mutate(x_lte_y = x <= y) %>%
  group_by(group) %>%
  mutate(x_lte_y_2 = x <= y)

tibble(x = runif(9),
       group = rep(c("a", "b", "c"), each = 3)) %>%
  group_by(group) %>%
  arrange(x)
  

# are affected 
a_tibble %>%
  group_by(group) %>%
  mutate(lag_x = lag(x),
         lead_x = lead(x))

a_tibble %>%
  mutate(x_cumsum = cumsum(x)) %>%
  group_by(group) %>%
  mutate(x_cumsum_2 = cumsum(x))

a_tibble %>% 
  mutate(rnk = min_rank(x)) %>%
  group_by(group) %>%
  mutate(rnk2 = min_rank(x))

tibble(group = rep(c("a", "b", "c"), each = 3), 
       x = runif(9)) %>%
  group_by(group) %>%
  arrange(x) %>%
  mutate(lag_x = lag(x))

# worst on-time record
flights %>%
  filter(!is.na(tailnum)) %>%
  mutate(on_time = !is.na(arr_time) & (arr_delay <= 0)) %>%
  group_by(tailnum) %>%
  summarise(on_time = mean(on_time), n = n()) %>%
  filter(min_rank(on_time) == 1)

quantile(count(flights, tailnum)$n)


flights %>%
  filter(!is.na(tailnum), is.na(arr_time) | !is.na(arr_delay)) %>%
  mutate(on_time = !is.na(arr_time) & (arr_delay <= 0)) %>%
  group_by(tailnum) %>%
  summarise(on_time = mean(on_time), n = n()) %>%
  filter(n >= 20) %>%
  filter(min_rank(on_time) == 1)

flights %>%
  filter(!is.na(arr_delay)) %>%
  group_by(tailnum) %>%
  summarise(arr_delay = mean(arr_delay), n = n()) %>%
  filter(n >= 20) %>%
  filter(min_rank(desc(arr_delay)) == 1)

# best hour to fly
flights %>%
  group_by(hour) %>%
  summarise(arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(arr_delay)

flights %>%
  filter(arr_delay > 0) %>%
  group_by(dest) %>%
  mutate(
    arr_delay_total = sum(arr_delay),
    arr_delay_prop = arr_delay / arr_delay_total
  ) %>%
  select(dest, month, day, dep_time, carrier, flight,
         arr_delay, arr_delay_prop) %>%
  arrange(dest, desc(arr_delay_prop))
# lag 
lagged_delays <- flights %>%
  arrange(origin, month, day, dep_time) %>%
  group_by(origin) %>%
  mutate(dep_delay_lag = lag(dep_delay)) %>%
  filter(!is.na(dep_delay), !is.na(dep_delay_lag))

lagged_delays %>%
  group_by(dep_delay_lag) %>%
  summarise(dep_delay_mean = mean(dep_delay)) %>%
  ggplot(aes(y = dep_delay_mean, x = dep_delay_lag)) +
  geom_point() +
  scale_x_continuous(breaks = seq(0, 1500, by = 120)) +
  labs(y = "Departure Delay", x = "Previous Departure Delay")

lagged_delays %>%
  group_by(origin, dep_delay_lag) %>%
  summarise(dep_delay_mean = mean(dep_delay)) %>%
  ggplot(aes(y = dep_delay_mean, x = dep_delay_lag)) +
  geom_point() +
  facet_wrap(~ origin, ncol=1) +
  labs(y = "Departure Delay", x = "Previous Departure Delay")

# suspicious flights 
standardized_flights <- flights %>%
  filter(!is.na(air_time)) %>%
  group_by(dest, origin) %>%
  mutate(
    air_time_mean = mean(air_time),
    air_time_sd = sd(air_time),
    n = n()
  ) %>%
  ungroup() %>%
  mutate(air_time_standard = (air_time - air_time_mean) / (air_time_sd + 1))

ggplot(standardized_flights, aes(x = air_time_standard)) +
  geom_density()

standardized_flights %>%
  arrange(air_time_standard) %>%
  select(
    carrier, flight, origin, dest, month, day,
    air_time, air_time_mean, air_time_standard
  ) %>%
  head(10) %>%
  print(width = Inf)

# ranking carriers
flights %>%
  # find all airports with > 1 carrier
  group_by(dest) %>%
  mutate(n_carriers = n_distinct(carrier)) %>%
  filter(n_carriers > 1) %>%
  # rank carriers by numer of destinations
  group_by(carrier) %>%
  summarize(n_dest = n_distinct(dest)) %>%
  arrange(desc(n_dest))
filter(airlines, carrier == "EV")
filter(airlines, carrier %in% c("AS", "F9", "HA"))
# For each plane, count the number of flights before the first delay of greater than 1 hour.
flights %>%
  # sort in increasing order
  select(tailnum, year, month,day, dep_delay) %>%
  filter(!is.na(dep_delay)) %>%
  arrange(tailnum, year, month, day) %>%
  group_by(tailnum) %>%
  # cumulative number of flights delayed over one hour
  mutate(cumulative_hr_delays = cumsum(dep_delay > 60)) %>%
  # count the number of flights == 0
  summarise(total_flights = sum(cumulative_hr_delays < 1)) %>%
  arrange(total_flights)
