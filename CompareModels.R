# Simulate Land Version
testnamel <- c("alpha", "beta", "delta", "n", "s", "g", "X")
testivl <- c(1/3, 0.2, 0.1, 0.02, 0.2, 0.05, 5)
testpfcl <- c(NA,NA,NA, NA, NA, NA, NA)
testnvl <- c(NA, NA, NA, NA, NA, NA, NA)
np <- 50
testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
paragrid <- testgridalt
startvals <- list(L = 1, K = 1, A = 1)
testsimulation_land <- SimulateExtendedSolowModelScarceResourceLand(testgridalt, np,startvals)

# Simulate General Version
testnamel <- c("g", "alpha", "delta", "n", "s")
testivl <- c(0.05, 1/3,0.1, 0.02, 0.2)
testpfcl <- c(NA,NA,NA, NA, NA)
testnvl <- c(NA, NA, NA, NA, NA)
np <- 50
testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
paragrid <- testgridalt
startvals <- list(K = 1, L = 1, A = 1)
testsimulation_general <- SimulateGeneralSolowModel(testgridalt, np,startvals)

combined <- 
  testsimulation_land %>% mutate(kind = "land") %>% bind_rows(testsimulation_general %>% mutate(kind = "general"))
combined %>% mutate(kind = factor(kind)) %>% select(all_of(names(combined)[c(4, 6, 12, 9, 1, 24)])) %>% pivot_longer(-c("period", "kind"), names_to = "Variable") %>% 
  mutate(Variable = as.factor(Variable)) %>% 
  ggplot(aes(period, value, col = kind, group = kind)) + 
  geom_line() + 
  facet_wrap(~Variable, scales = "free", ncol = 2) + 
  labs(x = "Period", y = "Value") 


