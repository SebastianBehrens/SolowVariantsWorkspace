# This file contains additional helper functions that are only relevant to the shiny app operationalization of the SolowVariant package as it will be published on GitHub.


getRequiredParams_as_string <- function(ModelCode) {
    out <- if (ModelCode == "BS") {
        out <- 'c("B", "alpha", "delta", "n", "s")'
    } else if (ModelCode == "GS") {
        out <- 'c("g", "alpha", "delta", "n", "s")'
    } else if (ModelCode == "ESSOE") {
        out <- 'c("B", "alpha", "n", "s", "r")'
    } else if (ModelCode == "ESSRL") {
        out <- 'c("alpha", "beta", "delta", "n", "s", "g", "X")'
    } else if (ModelCode == "ESSRO") {
        out <- 'c("alpha", "beta", "n", "g", "sE", "s", "delta")'
    } else if (ModelCode == "ESSROL") {
        out <- 'c("alpha", "beta", "kappa", "delta", "n", "s", "sE", "g", "X")'
    } else if (ModelCode == "ESHC") {
        out <- 'c("alpha", "phi", "n", "g", "sK", "sH", "delta")'
    } else {
        (
            out <- NaN
        )
    }
    if (is.na(out[[1]])) {
        warning("The entered shortcode for a model variant does not exist.")
    }
    return(out)
}
# sourceSimulationFile <- function(ModelCode){
#   path_to_source <- paste0("SimulationFunctions/",
#                            ModelCode, ".R")
#   source(path_to_source)
# }
# sourceSimulationFile("BS")

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


partAhelper_1 <- function(parameter){


  # Function ---------------------------------
  # originally from dynamically creating the code for tabs of new solow model variants
  out <- case_when(
    parameter == "B"~ "TFP",
    parameter == "alpha"~ "alpha",
    parameter == "beta"~ "beta",
    parameter == "kappa"~ "kappa",
    parameter == "phi"~ "phi",
    parameter == "alpha"~ "alpha",
    parameter == "lambda"~ "lambda",
    parameter == "s"~ "savings",
    parameter == "sK"~ "sK",
    parameter == "sH"~ "sH",
    parameter == "sR"~ "sR",
    parameter == "k"~ "k",
    parameter == "rho"~ "rho",
    parameter == "lambda"~ "lambda",
    parameter == "n"~ "popgrowth",
    parameter == "r"~ "realint",
    parameter == "g"~ "tfpgrowth",
    parameter == "sE"~ "energyconsumption",
    parameter == "X"~ "land",
    parameter == "delta"~ "delta",
    TRUE ~ "NA")
  if(out == "NA"){
    warning(paste("Parameter translation for", parameter, "not yet created. Create it in partAhelper_1 to continue."))
  }
  return(out)
}
partAhelper_2 <- function(parameter){
  # originally from dynamically creating the code for tabs of new solow model variants
  out <- case_when(
    parameter == "B"~ "TFP",
    parameter == "alpha"~ "Alpha",
    parameter == "beta"~ "Beta",
    parameter == "kappa"~ "Kappa",
    parameter == "phi"~ "Phi",
    parameter == "s"~ "Savings Rate",
    parameter == "sK"~ "Savings Rate to Physical Capital",
    parameter == "sH"~ "Savings Rate to Human Capital",
    parameter == "sR"~ "Prop. Labor Force in R&D",
    parameter == "k"~ "k",
    parameter == "rho"~ "Rho",
    parameter == "lambda"~ "lambda",
    parameter == "n"~ "Population Growth",
    parameter == "r"~ "Real Interest Rate",
    parameter == "g"~ "TFP Growth",
    parameter == "sE"~ "Energy Consupmtion",
    parameter == "X"~ "Land",
    parameter == "delta"~ "Delta",
    TRUE ~ "NA")
  if(out == "NA"){
    warning(paste("Parameter translation for", parameter, "not yet created. Create it in partAhelper_2 to continue."))
  }
  return(out)
}
