library(tidyverse)
# a <- 3
# print(a)
aux <- tibble(a = c(1,2,3), b = c(1, 4, 9)) 
aux %>% ggplot(aes(a, b)) + geom_point()