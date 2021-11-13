rm(list = ls())
library(tidyverse)
library(R.utils)
library(purrr)

aux <- R.utils::sourceDirectory("/Users/sebastianbehrens/Documents/GitHub/SolowVariants/R")

for (i in seq_along(aux)){
    source(aux[[i]])
}