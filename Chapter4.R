# newfile: cmd/ctrl shift N

# run code from script: cmd/ctrl enter
# run all code: cmd/ctrl shift S
library(dplyr)
library(nycflights13)

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

# dont include install.packages() or setwd(); antisocial

# can hover over errors 
x y <- 10
3 == NA
