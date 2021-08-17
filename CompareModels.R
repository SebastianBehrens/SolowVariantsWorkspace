# rm(list = ls())

# setwd("/Users/sebastianbehrens/Documents/GitHub/SolowVariants")
# # Simulate Land Version
source("HelperFunctions.R")
source("AutomatingShinyAppPageCreation.R")
# source("SimulationFunctions/ESSRL.R")
# testnamel <-c("alpha", "beta", "kappa", "delta", "n", "s", "g", "X")
# testivl <- c(0.33, 0.2, 0.2, 0.1, 0.02, 0.2, 0.05, 0.05, 5)
# testpfcl <- c(NA,NA,NA, NA, NA, NA, NA, NA)
# testnvl <- c(NA, NA, NA, NA, NA, NA, NA, NA)
# np <- 50
# testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
# paragrid1 <- testgridalt
# startvals1 <- list(L = 1, K = 1, A = 1)
# testsimulation_land <- SimulateExtendedSolowModelScarceResourceLand(
#   testgridalt, np, startvals
# )
# 
# # Simulate General Version
# source("SimulationFunctions/GS.R")
# testnamel <- c("g", "alpha", "delta", "n", "s")
# testivl <- c(0.05, 1/3,0.1, 0.02, 0.2)
# testpfcl <- c(NA,NA,NA, NA, NA)
# testnvl <- c(NA, NA, NA, NA, NA)
# np <- 50
# testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
# paragrid <- testgridalt
# startvals <- list(K = 1, L = 1, A = 1)
# testsimulation_general <- SimulateGeneralSolowModel(testgridalt, np,startvals)
# 
# combined <-
#   testsimulation_land %>%
#   mutate(kind = "land") %>%
#   bind_rows(testsimulation_general %>% mutate(kind = "general"))
# combined %>%
#   mutate(kind = factor(kind)) %>%
#   select(all_of(names(combined)[c(4, 6, 12, 9, 1, 24, 26)])) %>%
#   pivot_longer(-c("period", "kind"), names_to = "Variable") %>%
#   mutate(Variable = as.factor(Variable)) %>%
#   ggplot(aes(period, value, col = kind, group = kind)) +
#   geom_line() +
#   facet_wrap(~Variable, scales = "free", ncol = 2) +
#   labs(x = "Period", y = "Value")

getSimFunction <- function(ModelCode) {
  out <- case_when(
    ModelCode == "BS" ~ "SimulateBasicSolowModel",
    ModelCode == "GS" ~ "SimulateGeneralSolowModel",
    ModelCode == "ESSOE" ~ "SimulateExtendedSolowModelSmallOpenEconomy",
    ModelCode == "ESSRL" ~ "SimulateExtendedSolowModelScarceResourceLand",
    ModelCode == "ESSRO" ~ "SimulateExtendedSolowModelScarceResourceOil",
    ModelCode == "ESSROL" ~ "SimulateExtendedSolowModelScarceResourceOilAndLand",
    ModelCode == "ESHC" ~ "SimulateExtendedSolowModelHumanCapital",
    TRUE ~ "NaN"
  )
  if (out == "NaN") {
    warning("The entered shortcode for a model variant does not exist.")
  }
  return(out)
}

create_parameter_grid_advanced <- function(ModelCode, np, n_ModelComparison, input) {
  parameternames <- getRequiredParams(ModelCode)
  # iteratively execute calls with the created strings
  parameterchange_valuebefore <- c()
  parameterchange_valueafter <- c()
  parameterchange_period <- c()

  for (i in parameternames) {
    # create strings of parameters
    # i <- "n"
    # ModelCode <- "BS"
    string_parameterchange_indicator <- paste("ComparingModels", n_ModelComparison, "_", ModelCode, "_parameterchange_indicator_", partAhelper_1(i), sep = "")
    string_parameterchange_period <- paste("ComparingModels", n_ModelComparison, "_", ModelCode, "_parameterchange_period_", partAhelper_1(i), sep = "")
    string_parameterchange_valuebefore <- paste("ComparingModels", n_ModelComparison, "_", ModelCode, "_parameterchange_valuebefore_", partAhelper_1(i), sep = "")
    string_parameterchange_valueafter <- paste("ComparingModels", n_ModelComparison, "_", ModelCode, "_parameterchange_valueafter_", partAhelper_1(i), sep = "")


    parameterchange_period <- eval(parse(text = paste("c(parameterchange_period, if(input$", string_parameterchange_indicator, ") input$", string_parameterchange_period, " else NA)", sep = "")))
    parameterchange_valuebefore <- eval(parse(text = paste("c(parameterchange_valuebefore, input$", string_parameterchange_valuebefore, ")", sep = "")))
    parameterchange_valueafter <- eval(parse(text = paste("c(parameterchange_valueafter, if(input$", string_parameterchange_indicator, ") input$", string_parameterchange_valueafter, " else NA)", sep = "")))
  }

  create_parameter_grid(
    getRequiredParams(ModelCode),
    parameterchange_valuebefore,
    parameterchange_period,
    parameterchange_valueafter,
    np
  )
}

getRequiredStartingValues <- function(ModelCode){
  out <- if (ModelCode == "BS") {
    out <- c("K", "L")
  } else if (ModelCode == "GS") {
    out <- c("A", "K", "L")
  } else if (ModelCode == "ESSOE") {
    out <- c("L", "V")
  } else if (ModelCode == "ESSRL") {
    out <- c("A", "K", "L")
  } else if (ModelCode == "ESSRO") {
    out <- c("A", "K", "L", "R")
  } else if (ModelCode == "ESSROL") {
    out <- NaN
  } else if (ModelCode == "ESHC") {
    out <- c("A", "K", "L", "H")
  } else {
    (
      out <- NaN
    )
  }
  if (is.na(out)) {
    warning("The entered shortcode for a model variant does not exist.")
  }
  return(out)
}

create_startvals_list <- function(ModelCode, n_ModelComparison, input){
  aux_list <- list()
  for(i in getRequiredStartingValues(ModelCode)){
    aux_var_as_string <- paste0("input$ComparingModels", n_ModelComparison, "_", ModelCode, "_initval_", i)
    aux_list <- eval(parse(text = paste0("append(aux_list, list(", i, " = ", aux_var_as_string, "))"))) # mistake seems to be here
  }
  
  return(aux_list)
}

# test_list <- list(ComparingModels1_BS_initval_K = 2, ComparingModels1_BS_initval_L = 1)
# test_out <- create_startvals_list("BS", 1, test_list)
# test_out

getRequiredParams <- function(ModelCode) {
  out <- if (ModelCode == "BS") {
    out <- c("B", "alpha", "delta", "n", "s")
  } else if (ModelCode == "GS") {
    out <- c("g", "alpha", "delta", "n", "s")
  } else if (ModelCode == "ESSOE") {
    out <- c("B", "alpha", "n", "s", "r")
  } else if (ModelCode == "ESSRL") {
    out <- c("alpha", "beta", "kappa", "delta", "n", "s", "g", "X")
  } else if (ModelCode == "ESSRO") {
    out <- c("alpha", "beta", "n", "g", "sE", "s", "delta")
  } else if (ModelCode == "ESSROL") {
    out <- c("alpha", "beta", "kappa", "delta", "n", "s", "sE", "g", "X")
  } else if (ModelCode == "ESHC") {
    out <- c("alpha", "phi", "n", "g", "sK", "sH", "delta")
  } else {
    (
      out <- NaN
    )
  }
  if (is.na(out)) {
    warning("The entered shortcode for a model variant does not exist.")
  }
  return(out)
}

sourceSimulationFile <- function(ModelCode){
  path_to_source <- paste0("SimulationFunctions/",
                           ModelCode, ".R")
  source(path_to_source)
}
# sourceSimulationFile("BS")

getVariablesAvailableToBeVisualised <- function(ModelCode1,
                                                ModelCode2){
  sourceSimulationFile(ModelCode1)
  sourceSimulationFile(ModelCode2)
  
  variables1 <- get(paste0("meta_", ModelCode1, "_variables"))
  variables2 <- get(paste0("meta_", ModelCode2, "_variables"))
  shared_variables <- intersect(variables1, variables2)
  return(shared_variables)
}

compareEconomies <- function(ModelCode1, ModelCode2, VariableVisualisationSelection, 
                             ParameterGrid1, ParameterGrid2, 
                             StartValues1, StartValues2, NumberPeriods1, NumberPeriods2) {
  sourceSimulationFile(ModelCode1)
  sourceSimulationFile(ModelCode2)
  simulation1 <- doCall(getSimFunction(ModelCode1), args = list(paragrid = ParameterGrid1, np = NumberPeriods1, startvals = StartValues1))
  simulation2 <- doCall(getSimFunction(ModelCode2), args = list(paragrid = ParameterGrid2, np = NumberPeriods2, startvals = StartValues2))
  
  combined <- simulation1 %>% mutate(Variant = ModelCode1) %>% 
    bind_rows(simulation2 %>% mutate(Variant = ModelCode2))
  
  visualisation <- combined %>% 
    mutate(Variant = factor(Variant)) %>%
    select(all_of(c("Variant", "period", VariableVisualisationSelection))) %>%
    pivot_longer(-c("period", "Variant"), names_to = "Variable") %>%
    mutate(Variable = as.factor(Variable)) %>%
    ggplot(aes(period, value, col = Variant, group = Variant)) +
    geom_line() +
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
# # ESSRL
# testnamel <-c("alpha", "beta", "kappa", "delta", "n", "s", "g", "X")
# testivl <- c(0.33, 0.2, 0.2, 0.1, 0.02, 0.2, 0.05, 0.05, 5)
# testpfcl <- c(NA,NA,NA, NA, NA, NA, NA, NA)
# testnvl <- c(NA, NA, NA, NA, NA, NA, NA, NA)
# np <- 100
# testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
# paragrid2 <- testgridalt
# startvals2 <- list(L = 1, K = 1, A = 1)
# 
# compareEconomies("GS", "ESSRL", var_selection, paragrid1, paragrid2, startvals1, startvals2, 50, 100)
# ModelCode1 <- "GS"
# ModelCode2 <- "ESSRL"
# VariablesToVisualise <- "a"
# ParameterGrid1 <- paragrid1
# ParameterGrid2 <- paragrid2
# StartValues1 <- startvals1
# StartValues2 <- startvals2
# NumberPeriods1 <- 50
# NumberPeriods2 <- 100
# 
# var_selection <- names(combined)[c(4, 6, 12, 9,   24, 26)]
