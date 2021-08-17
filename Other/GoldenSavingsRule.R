testnamel <- c("B", "alpha", "delta", "n", "s")
testivl <- c(10, 1/3,0.1, 0.005, 0.22)
testpfcl <- c(NA,NA,NA, NA, NA)
testnvl <- c(NA, NA, NA, NA, NA)
testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
paragrid <- testgridalt
np <- 200
startvals <- list(K = 1, L = 1)

testsimulation <- SimulateBasicSolowModel(testgridalt, np,startvals)
source("HelperFunctions.R")
library(tidyverse)
aux <- tibble(s = NA, c = NA)
for (j in seq(0, 1, 0.05)){
# for (i in seq(0, 1, 0.05)){
    testnamel <- c("B", "alpha", "delta", "n", "s")
    testivl <- c(10, 1/3,0.1, 0.005, j)
    testpfcl <- c(NA,NA,NA, NA, NA)
    testnvl <- c(NA, NA, NA, NA, NA)
    testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
    paragrid <- testgridalt
    np <- 200
    startvals <- list(K = 1, L = 1)
    
    testsimulation <- SimulateBasicSolowModel(testgridalt, np,startvals)
    aux <- aux %>% complete(c = testsimulation[["CpW"]][[201]], s = j)
# }
}

aux %>% ggplot(aes(s, c)) + geom_line()
