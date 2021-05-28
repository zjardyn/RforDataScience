# vignette("tibble")

library(tidyverse)

# coerce
as_tibble(iris)

tibble(
  x = 1:5, 
  y = 1, 
  z = x ^ 2 + y
)

# It’s possible for a tibble to have column names that are not valid R variable names, aka non-syntactic names. For example, they might not start with a letter, or they might contain unusual characters like a space. To refer to these variables, you need to surround them with backticks, `:

tb <- tibble(
  `:)` = "smile", 
  ` ` = "space",
  `2000` = "number"
)
tb

tribble(
  ~x, ~y, ~z,
  #--|--|----
  "a", 2, 3.6,
  "b", 1, 8.5
)

tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)

nycflights13::flights %>% 
  print(n = 10, width = Inf)

# options(tibble.print_max = n, tibble.print_min = m): if more than n rows, print only m rows. Use options(tibble.print_min = Inf) to always show all rows.

# Use options(tibble.width = Inf) to always print all columns, regardless of the width of the screen.

nycflights13::flights %>% 
  View()

df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

df$x
df[["x"]]
df[[1]]

df %>% .$x
df %>% .[["x"]]

class(as.data.frame(tb))

# Exercises 1 ----
mtcars %>%
  class()
as.tibble(mtcars) %>% 
  class()

# might index the wrong thing 
df <- data.frame(abc = 1, xyz = "a")
df$x
df[, "xyz"]
df[, c("abc", "xyz")]

tb <- as.tibble(df)
tb$x
tb[, "xyz"]
tb[, c("abc", "xyz")]

var <- "mpg"
tb <- tibble(mtcars)
tb[[var]]

annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)

annoying$`1`
annoying %>% 
  ggplot(aes(`1`, `2`)) +
  geom_point()

annoying <- annoying %>% 
  mutate(`3` = `2` / `1`)

colnames(annoying) <- c("one", "two", "three")
annoying

?tibble::enframe

# options(tibble.width = Inf)

# ----
