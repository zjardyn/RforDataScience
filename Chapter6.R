# RStudio > preferences > general > uncheck Restore .Rdata into workspace at startup; Save workspace to .RData on exit: Never

# Cmd/Ctrl + Shift + F10 Restart R
# Cmd/Ctrl + Shift + S rerun script

getwd()
# setwd("/path/to/my/CoolProject")

# Mac and Linux uses slashes (e.g. plots/diamonds.pdf) and Windows uses backslashes (e.g. plots\diamonds.pdf)

# Absolute paths: In Windows they start with a drive letter (e.g. C:) or two backslashes (e.g. \\servername) and in Mac/Linux they start with a slash “/” (e.g. /users/hadley)

# ~ to home dir

library(tidyverse)

ggplot(diamonds, aes(carat, price)) + 
  geom_hex()
# ggsave("diamonds.pdf")
# 
# write_csv(diamonds, "diamonds.csv")

#  notice the .Rproj file