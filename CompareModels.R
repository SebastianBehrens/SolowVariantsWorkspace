source("HelperFunctions.R")
# source("AutomatingShinyAppPageCreation.R")



compareEconomies <- function(ModelCode1, ModelCode2, VariableVisualisationSelection, 
                             ParameterGrid1, ParameterGrid2, 
                             StartValues1, StartValues2, NumberPeriods1, NumberPeriods2) {
  
  sourceSimulationFile(ModelCode1)
  sourceSimulationFile(ModelCode2)
  simulation1 <- doCall(getSimFunction(ModelCode1), args = list(paragrid = ParameterGrid1, np = NumberPeriods1, startvals = StartValues1))
  simulation2 <- doCall(getSimFunction(ModelCode2), args = list(paragrid = ParameterGrid2, np = NumberPeriods2, startvals = StartValues2))
  
  sameModelCode <- ModelCode1 == ModelCode2
  combined <- simulation1 %>% mutate(Variant = ifelse(sameModelCode, paste0(ModelCode1, "1"), ModelCode1)) %>% 
    bind_rows(simulation2 %>% mutate(Variant = ifelse(sameModelCode, paste0(ModelCode1, "2"), ModelCode2))
              )
  
  visualisation <- combined %>% 
    mutate(Variant = factor(Variant)) %>%
    select(all_of(c("Variant", "period", VariableVisualisationSelection))) %>%
    pivot_longer(-c("period", "Variant"), names_to = "Variable") %>%
    mutate(Variable = as.factor(Variable)) %>%
    ggplot(aes(period, value, col = Variant, group = Variant)) +
    geom_line(alpha = 0.75) +
    facet_wrap(~Variable, scales = "free", ncol = 2) +
    labs(x = "Period", y = "Value")
  
  return(visualisation)
}


# testing compareModels
# GS
# testnamel <- c("g", "alpha", "delta", "n", "s")
# testivl <- c(0.05, 1/3,0.1, 0.02, 0.2)
# testpfcl <- c(NA,NA,NA, NA, NA)
# testnvl <- c(NA, NA, NA, NA, NA)
# np <- 50
# testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
# paragrid1 <- testgridalt
# startvals1 <- list(K = 1, L = 1, A = 1)
# # ESSROL
# testnamel <-c("alpha", "beta", "kappa", "delta", "n", "s", "sE", "g", "X")
# testivl <- c(0.33, 0.2, 0.2, 0.1, 0.02, 0.2, 0.05, 0.05, 5)
# testpfcl <- c(NA,NA,NA, NA, NA, NA, NA, NA, NA)
# testnvl <- c(NA, NA, NA, NA, NA, NA, NA, NA, NA)
# np <- 100
# testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
# paragrid2 <- testgridalt
# startvals2 <- list(L = 1, K = 1, A = 1, R = 1)
# var_selection <- getVariablesAvailableToBeVisualised("GS", "ESSROL") %>% sample(5) %>% variable_encoder()
# # SimulateExtendedSolowModelScarceResourceOilAndLand(paragrid2, np, startvals2)
# # 
# compareEconomies("GS", "ESSROL", var_selection, paragrid1, paragrid2, startvals1, startvals2, 50, 100)
# ModelCode1 <- "GS"
# ModelCode2 <- "ESSROL"
# VariablesToVisualise <- "a"
# ParameterGrid1 <- paragrid1
# ParameterGrid2 <- paragrid2
# StartValues1 <- startvals1
# StartValues2 <- startvals2
# NumberPeriods1 <- 50
# NumberPeriods2 <- 100
# VariableVisualisationSelection <- var_selection
