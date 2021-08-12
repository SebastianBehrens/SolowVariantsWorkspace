# Simulate Land Version
source("HelperFunctions.R")
source("SimulationFunctions/ExtendedSolowModelLand.R")
testnamel <-c("alpha", "beta", "kappa", "delta", "n", "s", "g", "X")
testivl <- c(0.33, 0.2, 0.2, 0.1, 0.02, 0.2, 0.05, 0.05, 5)
testpfcl <- c(NA,NA,NA, NA, NA, NA, NA, NA)
testnvl <- c(NA, NA, NA, NA, NA, NA, NA, NA)
np <- 50
testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
paragrid <- testgridalt
startvals <- list(L = 1, K = 1, A = 1)
testsimulation_land <- SimulateExtendedSolowModelScarceResourceLand(testgridalt, np,startvals)

# Simulate General Version
source("SimulationFunctions/GeneralSolowModel.R")
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
combined %>% mutate(kind = factor(kind)) %>% select(all_of(names(combined)[c(4, 6, 12, 9, 1, 24, 26)])) %>% pivot_longer(-c("period", "kind"), names_to = "Variable") %>% 
  mutate(Variable = as.factor(Variable)) %>% 
  ggplot(aes(period, value, col = kind, group = kind)) + 
  geom_line() + 
  facet_wrap(~Variable, scales = "free", ncol = 2) + 
  labs(x = "Period", y = "Value") 

getSimFunction <- function(ModelCode){
  out <- case_when(
    ModelCode == "BS" ~ "SimulateBasicSolowModel", 
    ModelCode == "GS" ~ "SimulateGeneralSolowModel", 
    ModelCode == "ESSOE" ~ "SimulateExtendedSolowModelSmallOpenEconomy", 
    ModelCode == "ESSRL" ~ "SimulateExtendedSolowModelScarceResourceLand", 
    ModelCode == "ESSRO" ~ "SimulateExtendedSolowModelScarceResourceOil", 
    ModelCode == "ESSROL" ~ "SimulateExtendedSolowModelScarceResourceOilAndLand", 
    ModelCode == "ESHC" ~ "SimulateExtendedSolowModelHumanCapital"
    TRUE ~ NA
  )
  if(is.na(out)){warning("The entered shortcode for a model variant does not exist.")}
}

compareEconomies <- function(ModelCode1, ModelCode2, columns){
  simulation1 <- do.call(getSimFunction(ModelCode1), )
  combined <- 
    testsimulation_land %>% mutate(kind = "land") %>% bind_rows(testsimulation_general %>% mutate(kind = "general"))
}



