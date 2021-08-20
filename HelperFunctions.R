

### 0 Preparations (helper functions) #############################
# 0.1 individual parameter path  ---------------------------------
create_path <- function(iv, pfc, nv, np){
  ## will create a vector of parameter values for periods 0 through n.
  # iv for initial value;
  # pfc for period for change;
  # nv for new value;
  # np vor number of periods
  
  # catching nonsensical inputs
  if(!is.na(pfc)){
  # if the period of change occurs in later periods than a simulation is 
  #                                 created for, then it does not matter.
    if(pfc > np){
      pfc <- NA
    }
    # catching negative periods of change
    if(pfc < 0){
      pfc <- abs(pfc)
    }
    
  }
  
  
  if(!is.na(pfc)){
    part1 <- rep(iv, pfc)
    part2 <- rep(nv, np, np-pfc+1)
  }else{
    part1 <- c()
    part2 <- rep(iv, np+1)
  }
  return(c(part1, part2))
}
# testing
# create_path(2, 3, 4, 7)

# 0.2 grid of individual parameter paths ---------------------------------
create_parameter_grid <- function(namel, ivl, pfcl, nvl, np){
  # np <- 10
  aux <- tibble(period = c(0:np))
  for(i in seq_along(namel)){
    ## testing
    # i <- 1
    # aux_path <- create_path(1, 5, 3, np)
    # namel <- c("testvar")
    aux_path <- create_path(ivl[[i]], pfcl[[i]], nvl[[i]], np)
    aux[[namel[[i]] ]] <- aux_path
  }
  return(aux)
}

# testing of create_paramter_grid
# testnamel <- c("B", "alpha", "delta", "n", "s")
# testivl <- c(1,1/3,0.1, 0.04, 0.23)
# testpfcl <- c(NA,NA, NA, NA, NA)
# testnvl <- c(NA, NA, NA, NA, NA)
# testgrid <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, 50)


# 0.3 grid of paths of model variables ---------------------------------
create_simulation_table <- function(vts, np) {
  # vts for variables to simulate
  aux <- tibble(period = c(0:np))
  for (i in c(1:length(vts))) {
    aux_sequence <- rep(NA, np + 1)
    aux[[vts[[i]]]] <- as.double(aux_sequence)
  }
  return(aux)
}

# 0.4 (not used) start values filler ---------------------------------
# fill_start_values <- function(var, value, dataset){
#   index <- which(dataset$period == 0)
#   dataset[[index, var]] <- value
#   return(dataset)
# }
# fill_start_values("testvar", 5, sim_table)


# 0.5 encoding variables ---------------------------------
variable_encoder <- function(variables){
  # variables <- c("Output per Effective Worker")
  n_vars <- length(variables)
  aux <- as.double(rep(NA, n_vars))
  for(i in 1:n_vars){
    aux2 <- variables[[i]]
    aux3 <- case_when(
      aux2 == "Total Factor Productivity" ~ "TFP",
      
      aux2 == "Human Capital Stock" ~ "H",
      aux2 == "Log of Human Capital Stock" ~ "logH",
      aux2 == "Capital Stock" ~ "K",
      aux2 == "Log of Capital Stock" ~ "logK",
      aux2 == "Growth Rate of Capital Stock" ~ "gK",
      aux2 == "Growth Rate of Human Capital Stock" ~ "gH",
      
      aux2 == "Capital Stock per Worker" ~ "KpW",
      aux2 == "Log of Capital Stock per Worker" ~ "logKpW",
      aux2 == "Growth Rate of Capital Stock per Worker" ~ "gKpW",
      
      aux2 == "Human Capital Stock per Worker" ~ "HpW",
      aux2 == "Log of Human Capital Stock per Worker" ~ "logHpW",
      aux2 == "Growth Rate of Human Capital Stock per Worker" ~ "gHpW",
      
      aux2 == "Capital Stock per Effective Worker" ~ "KpEW",
      aux2 == "Log of Capital Stock per Effective Worker" ~ "logKpEW",
      aux2 == "Growth Rate of Capital Stock per Effective Worker" ~ "gKpEW",
      
      aux2 == "Human Capital Stock per Effective Worker" ~ "HpEW",
      aux2 == "Log of Human Capital Stock per Effective Worker" ~ "logHpEW",
      aux2 == "Growth Rate of Human Capital Stock per Effective Worker" ~ "gHpEW",
      
      aux2 == "Labor Stock" ~ "L",
      
      aux2 == "Wage Rate" ~ "WR", 
      aux2 == "Rental Rate" ~ "RR",
      aux2 == "Capital Rental Rate" ~ "RR",
      aux2 == "Land Rental Rate" ~ "LR",
      
      aux2 == "Output" ~ "Y",
      aux2 == "Log of Output" ~ "logY",
      aux2 == "Growth Rate of Output" ~ "gY",
      
      aux2 == "Output per Worker" ~ "YpW",
      aux2 == "Log of Output per Worker" ~ "logYpW",
      aux2 == "Growth Rate of Output per Worker" ~ "gYpW",
      
      aux2 == "Output per Effective Worker" ~ "YpEW",
      aux2 == "Log of Output per Effective Worker" ~ "logYpEW",
      aux2 == "Growth Rate of Output per Effective Worker" ~ "gYpEW",
      
      aux2 == "National Output" ~ "Yn",
      aux2 == "National Wealth" ~ "V",
      aux2 == "National Wealth per Worker"~ "VpW",
      aux2 == "Net Foreign Assets" ~ "F",
      aux2 == "Net Foreign Assets per Worker" ~ "FpW",
      aux2 == "National Savings" ~ "Sn",
      
      aux2 == "Energy Use" ~ "E",
      aux2 == "Resource Stock" ~ "R",
      
      aux2 == "Consumption" ~ "C",
      aux2 == "Consumption per Worker" ~ "CpW",
      aux2 == "Consumption per Effective Worker" ~ "CpEW",
      
      aux2 == "Capital to Output Ratio" ~ "CtO"
      
      
      
    )
    aux[[i]] <- aux3
    
  }
  return(aux)
}


# 0.6 visualise a simulation ---------------------------------
VisualiseSimulation <- function(simulation_data, variables, scale_identifier){
  variables <- c("period", variables)
  simulation_data %>% select(all_of(variables)) %>% 
    pivot_longer(-period, names_to = "Variable") %>% 
    mutate(Variable = as.factor(Variable)) %>% 
    ggplot(aes(period, value, col = Variable)) + 
    geom_line() + 
    facet_wrap(~Variable, scales = scale_identifier, ncol = 2)+ 
    labs(x = "Period", y = "Value") + 
    theme(legend.position = "none")
}


# 0.7 computing additional variables ---------------------------------
add_var_computer <- function(sim_data, add_vars, parameter_data, technology_variant, solowversion){
  # sim_data for the simulation table created in every Solow Model Simulation Function (SimulateBasicSolowModel, SimulateGeneralSolowModel, SimulateExtendedSolowModelSmallOpenEconomy)
  # add_vars for the vector indicating whether a variable needs to be computer or not (it will not need to be computer in the ensuing function if it is endogeneous to the model)
  # parameter_data for the parameter grid
  # technology variant for the version where TFP is indicated as endogeneous by A or exogeneous by B 
  # solowversion for a string indicating the solow model version ("BS", "GS", "ESSOE", "ES....")
 
  ## Testing 
  # sim_data <- sim_table
  # add_vars <- remaining_vars_to_compute_bool
  # parameter_data <- paragrid
  # technology_variant <- "exo"
  # solowversion <- "ESSOE"
  
  
  # accomodating for different forms of technology:
  # A (endogeneous variable) and B (parameter) in the different Solow Models
  if(technology_variant == "endo"){
    technology <- sim_data[["TFP"]]
  }else if(technology_variant == "exo"){
    technology <- parameter_data[["B"]]
  }else{
    stop("Technology location unclear")
  }
  for(i in names(sim_data)[!add_vars]){
    # Variants of Output
    if(i == "YpW"){sim_data[["YpW"]] <- sim_data[["Y"]]/sim_data[["L"]]}
    if(i == "YpEW"){sim_data["YpEW"] <- sim_data[["Y"]]/(technology * sim_data[["L"]])}
    # Variants of Output Logarithmised
    if(i == "logY"){sim_data[["logY"]] <- sim_data[["Y"]] %>% log()}
    if(i == "logYpW"){sim_data[["logYpW"]] <- sim_data[["YpW"]] %>% log()}
    if(i == "logYpEW"){sim_data[["logYpEW"]] <- sim_data[["YpEW"]] %>% log()}
    # Variants of Capital
    if(i == "KpW"){sim_data[["KpW"]] <- sim_data[["K"]]/sim_data[["L"]]}
    if(i == "KpEW"){sim_data["KpEW"] <- sim_data[["K"]]/(technology * sim_data[["L"]])}
    # Variants of Human Capital
    if(i == "HpW"){sim_data[["HpW"]] <- sim_data[["H"]]/sim_data[["L"]]}
    if(i == "HpEW"){sim_data["HpEW"] <- sim_data[["H"]]/(technology * sim_data[["L"]])}
    # Variants of Capital Logarithmised
    if(i == "logK"){sim_data[["logK"]] <- sim_data[["K"]] %>% log()}
    if(i == "logKpW"){sim_data[["logKpW"]] <- sim_data[["KpW"]] %>% log()}
    if(i == "logKpEW"){sim_data[["logKpEW"]] <- sim_data[["KpEW"]] %>% log()}
    # Variants of Human Capital Logarithmised
    if(i == "logH"){sim_data[["logH"]] <- sim_data[["H"]] %>% log()}
    if(i == "logHpW"){sim_data[["logHpW"]] <- sim_data[["HpW"]] %>% log()}
    if(i == "logHpEW"){sim_data[["logHpEW"]] <- sim_data[["HpEW"]] %>% log()}
    # Variants of Growth
    if(i == "gY"){sim_data[["gY"]] <- log(sim_data[["Y"]]) - log(lag(sim_data[["Y"]]))}
    if(i == "gYpW"){sim_data[["gYpW"]] <- log(sim_data[["YpW"]]) - log(lag(sim_data[["YpW"]]))}
    if(i == "gYpEW"){sim_data[["gYpEW"]] <- log(sim_data[["YpEW"]]) - log(lag(sim_data[["YpEW"]]))}
    if(i == "gK"){sim_data[["gK"]] <- log(sim_data[["K"]]) - log(lag(sim_data[["K"]]))}
    if(i == "gKpW"){sim_data[["gKpW"]] <- log(sim_data[["KpW"]]) - log(lag(sim_data[["KpW"]]))}
    if(i == "gKpEW"){sim_data[["gKpEW"]] <- log(sim_data[["KpEW"]]) - log(lag(sim_data[["KpEW"]]))}
    if(i == "gH"){sim_data[["gH"]] <- log(sim_data[["H"]]) - log(lag(sim_data[["H"]]))}
    if(i == "gHpW"){sim_data[["gHpW"]] <- log(sim_data[["HpW"]]) - log(lag(sim_data[["HpW"]]))}
    if(i == "gHpEW"){sim_data[["gHpEW"]] <- log(sim_data[["HpEW"]]) - log(lag(sim_data[["HpEW"]]))}
    # Variants of Saving
    if(i == "Sn"){sim_data[["Sn"]] <- parameter_data[["s"]] * sim_data[["Yn"]]}
    # Variants of Wealth and Foreign Assets in SOE Version
    if(i == "VpW"){sim_data[["VpW"]] <- sim_data[["V"]] / sim_data[["L"]]}
    if(i == "FpW"){sim_data[["FpW"]] <- sim_data[["F"]] / sim_data[["L"]]}
    # Variants of Consumption
    
    if(i == "C"){sim_data[["C"]] <- sim_data[["Y"]] * (1- parameter_data[["s"]])}
    if(i == "CpW"){sim_data[["CpW"]] <- sim_data[["C"]] / sim_data[["L"]]}
    if(i == "CpEW"){sim_data[["CpEW"]] <- sim_data[["C"]] / (technology * sim_data[["L"]])}
    
    if(i == "CtO"){sim_data[["CtO"]] <- sim_data[["KpW"]]/sim_data[["YpW"]]}
    
    
    # Variables uniquely calculated to different Solow Model Versions (e.g. WR, RR)
    # WR, RR for BS ---------------------------------
    if(solowversion == "BS") {
      source("ModelFunctions/BSModelFunctions.R")
      if (i == "WR") {
        sim_data[["WR"]] <- BS_MF_WR(technology,
                                     sim_data[["K"]],
                                     sim_data[["L"]],
                                     parameter_data[["alpha"]])
      }
      # Rental Rate
      if (i == "RR") {
        sim_data[["RR"]] <- BS_MF_RR(technology,
                                     sim_data[["K"]],
                                     sim_data[["L"]],
                                     parameter_data[["alpha"]])
      }
      
    }
    # WR, RR for GS ---------------------------------
    if(solowversion == "GS") {
      source("ModelFunctions/GSModelFunctions.R")
      if (i == "WR") {
        sim_data[["WR"]] <- GS_MF_WR(technology,
                                     sim_data[["K"]],
                                     sim_data[["L"]],
                                     parameter_data[["alpha"]])
      }
      # Rental Rate
      if (i == "RR") {
        sim_data[["RR"]] <- GS_MF_RR(technology,
                                     sim_data[["K"]],
                                     sim_data[["L"]],
                                     parameter_data[["alpha"]])
      }
      
    }
    # WR, RR for ESSOE ---------------------------------
    if(solowversion == "ESSOE") {
      if (i == "WR") {
        source("ModelFunctions/ESSOEModelFunctions.R")
        sim_data[["WR"]] <- ESSOE_MF_WR(technology,
                                     sim_data[["K"]],
                                     sim_data[["L"]],
                                     parameter_data[["alpha"]])
        
      }
      # Rental Rate
      if (i == "RR") {
        sim_data[["RR"]] <- ESSOE_MF_RR(technology,
                                     sim_data[["K"]],
                                     sim_data[["L"]],
                                     parameter_data[["alpha"]])
      }
    } 
      # WR, RR for ESHC ---------------------------------
      if(solowversion == "ESHC") {
        if (i == "WR") {
          source("ModelFunctions/ESHCModelFunctions.R")
          sim_data[["WR"]] <- ESHC_MF_WR(technology,
                                         sim_data[["H"]],
                                         sim_data[["K"]],
                                         sim_data[["L"]],
                                         parameter_data[["alpha"]],
                                         parameter_data[["phi"]])
          
        }
        # Rental Rate
        if (i == "RR") {
          sim_data[["RR"]] <- ESHC_MF_RR(technology,
                                         sim_data[["H"]],
                                         sim_data[["K"]],
                                         sim_data[["L"]],
                                         parameter_data[["alpha"]],
                                         parameter_data[["phi"]])
        }
      
      
      
      }
    # WR, RR for ESSRL ---------------------------------
    if(solowversion == "ESSRL") {
      if (i == "WR") {
        source("ModelFunctions/ESSRLModelFunctions.R")
        sim_data[["WR"]] <- ESSRL_MF_WR(technology,
                                        sim_data[["K"]],
                                        sim_data[["L"]],
                                        parameter_data[["X"]],
                                        parameter_data[["alpha"]],
                                        parameter_data[["beta"]],
                                        parameter_data[["kappa"]])
      }
      # Rental Rate
      if (i == "RR") {
        sim_data[["RR"]] <- ESSRL_MF_RR(technology,
                                        sim_data[["K"]],
                                        sim_data[["L"]],
                                        parameter_data[["X"]],
                                        parameter_data[["alpha"]],
                                        parameter_data[["kappa"]])
      }
      # Land Rental Rate
      if (i == "LR") {
        sim_data[["LR"]] <- ESSRL_MF_LR(technology,
                                        sim_data[["K"]],
                                        sim_data[["L"]],
                                        parameter_data[["X"]],
                                        parameter_data[["alpha"]],
                                        parameter_data[["kappa"]])
      }
      
      
      
    }
    # WR, RR for ESSRO ---------------------------------
    if(solowversion == "ESSRO") {
      if (i == "WR") {
        source("ModelFunctions/ESSROModelFunctions.R")
        # The _WR and _RR functions don't exist yet, I will need to compute them by hand first. They are not given in the book.
        # sim_data[["WR"]] <- ESSRO_MF_WR()
        
      }
      # Rental Rate
      if (i == "RR") {
        # sim_data[["RR"]] <- ESSRO_MF_RR()
      }
      
      
      
    }
    
    
    
  }
  
  return(sim_data)
}

# 0.8 compute steady state values and check correctness of simulations ---------------------------------
simulation_correctness_checker <- function(last_row_simulation, last_row_parameter, solow_variant){
  # last_row for the last row of the simulation table (sim_table %>% tail(1))
  # solow_variant for the different solow variants
    aux <- tibble(variable = toString(NA), last_value = as.double(NA), steadystate = as.double(NA))
    aux[[1,1]] <- NA
    
    all_possible_steady_state_function_inputs <- 
      list(
        delta = last_row_parameter[["delta"]],
        s = last_row_parameter[["s"]],
        sK = last_row_parameter[["sK"]],
        sH = last_row_parameter[["sH"]],
        n = last_row_parameter[["n"]],
        B = last_row_parameter[["B"]],
        r = last_row_parameter[["r"]],
        g = last_row_parameter[["g"]],
        alpha = last_row_parameter[["alpha"]],
        beta = last_row_parameter[["beta"]],
        kappa = last_row_parameter[["kappa"]],
        phi = last_row_parameter[["phi"]],
        YpW = last_row_simulation[["YpW"]],
        RR = last_row_simulation[["RR"]],
        w = last_row_simulation[["WR"]],
        A = last_row_simulation[["TFP"]],
        KpW = last_row_simulation[["KpW"]],
        L = last_row_simulation[["L"]],
        X = last_row_parameter[["X"]],
        R = last_row_simulation[["R"]]
      )
    
    if(solow_variant == "BS") {
      # Remark: The selections variable_encoder(meta_GS_variables[c(6, 7, 8, 9)]) can be generally adjusted to simply c("KpW", "YpW", ...) as done for some
      aux_steadystate_variables <- c("KpW", "YpW", "CpW", "WR", "RR")
    }else if(solow_variant == "GS"){
      aux_steadystate_variables <- c("KpW", "YpW", "CpW", "WR", "RR", "KpEW", "YpEW")
    }else if(solow_variant == "ESSOE"){
      aux_steadystate_variables <- c("KpW", "YpW", "WR", "VpW", "FpW")
    }else if(solow_variant == "ESHC"){
      aux_steadystate_variables <- c("KpEW", "HpEW", "YpEW", "YpW", "CpW") # WR and RR missing
    }else if(solow_variant == "ESSRL"){
      aux_steadystate_variables <- c("CtO", "YpW") # WR and RR missing
    }else if(solow_variant == "ESSRO"){
      aux_steadystate_variables <- c("YpW")
     }
    
    for(i in aux_steadystate_variables){
      aux_function_name <- paste(solow_variant, "_SS_", i, sep = "")
      SS_val_computed <- doCall(aux_function_name, args = all_possible_steady_state_function_inputs)
      aux <- aux %>% complete(variable = i, last_value = last_row_simulation[[i]], steadystate = SS_val_computed)
    }
    aux <- aux %>% drop_na()
    aux <- aux %>% mutate_at(vars(steadystate, last_value), round, digits = 2)
    aux <- aux %>% mutate(is_same = case_when(
      last_value == steadystate ~ "Equal",
      TRUE ~ "Different"
    ))
    return(aux)

}


# 0.9 compare different simulations ---------------------------------
compare_simulations <- function(simulation_list, sim_identifier_vector, vars_selection){
  # simulation_list is list(sim1, sim2, sim3, ...)
  # sim_identifier_vector is c("oil", "land", "oilland")
  # vars_selection is a vector of the variables to plot.
  
  # Verifying that inputs are 'correct' and can be worked with
  if(length(simulation_list) != length(sim_identifier_vector)){
    stop("Number of simulation identifier strings and number of simulations don't match.")
  }
  
  for(i in seq_along(simulation_list)){
   simulation_list[[i]] <- simulation_list[[i]] %>% mutate(sim_type = sim_identifier_vector[[i]])
  }
  
  if("period" %in% vars_selection){
    stop("You supplied the 'period' column into your variable selection. Remove it from the selection, please.")
  }
  if("sim_type" %in% vars_selection){
    stop("You supplied the 'sim_type' column into your variable selection. Remove it from the selection, please.")
  }
  # generating cumuative intersections of all column names. 
  # only those that exist in all simulations can be plotted in a comparison plot of variables across all simulations.
  list_of_col_names <- map(simulation_list, names)
  col_names_shared <- list_of_col_names[[1]]
  for(i in c(2:length(list_of_col_names))){
    col_names_shared <- intersect(col_names_shared, list_of_col_names[[i]])
  }
  # stacking all simulations with the shared column names
  sims_stacked <- simulation_list[[1]] %>% select(all_of(col_names_shared)) %>% mutate(sim_type = sim_identifier_vector[[1]])
  for(i in c(2:length(simulation_list))){
    # i <- 2
    sims_stacked <- sims_stacked %>% bind_rows(
      simulation_list[[i]] %>% 
        select(all_of(col_names_shared)) %>% 
        mutate(sim_type = sim_identifier_vector[[i]])
      )
  }
  
  library(tidyverse)
  
  theme_set(
    theme_classic() + 
      theme(
        axis.ticks.length = unit(-0.25, "cm"),
        axis.text.x = element_text(margin = unit(c(0.4,0,0,0), "cm")),
        axis.text.y = element_text(margin = unit(c(0,0.4,0,0), "cm")),
        axis.line = element_blank(),
        panel.grid.major.y = element_line(linetype = 2),
        plot.title = element_text(hjust = 0.5),
        text = element_text(family = "serif"),
        legend.justification = c("right", "top"),
        # legend.position = c(1, 1),
        legend.position = c(.98, .98),
        legend.background = element_rect(fill = NA, color = "black"),
        panel.border = element_rect(fill = NA, size = 1.25),
        strip.text = element_text(size = 12)
        # legend.margin = margin(6, 10, 6, 6)
        # legend.box.background = element_rect(colour = "black")
      )
    
  )
  
  
  sims_stacked %>% 
    select(all_of(c("period", "sim_type", vars_selection))) %>% 
    pivot_longer(-c("period", "sim_type"), names_to = "Variable") %>% 
    mutate(Variable = as.factor(Variable)) %>% 
    ggplot(aes(period, value, col = sim_type, group = sim_type)) + 
    geom_line(alpha = 0.75) + 
    facet_wrap(~Variable, scales = "free", ncol = 2) + 
    labs(x = "Period", y = "Value", col = "Solow Variant")
}

#  ---------------------------------
partAhelper_1 <- function(parameter){
  # originally from dynamically creating the code for tabs of new solow model variants
  out <- case_when(
    parameter == "B"~ "TFP", 
    parameter == "alpha"~ "alpha", 
    parameter == "beta"~ "beta", 
    parameter == "kappa"~ "kappa", 
    parameter == "phi"~ "phi", 
    parameter == "alpha"~ "alpha",
    parameter == "s"~ "savings",
    parameter == "sK"~ "sK",
    parameter == "sH"~ "sH",
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

# helper functions for comparing models ---------------------------------
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
    out <- c("A", "K", "L", "R")
  } else if (ModelCode == "ESHC") {
    out <- c("A", "K", "L", "H")
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
  if (is.na(out[[1]])) {
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

# 0.99 testing ---------------------------------
# vtstest <- c("testvar", "ja", "nein")
# create_simulation_table(vtstest, 20)
# variable_encoder(c("Rental Rate"))
# add_var_computer(tibble(L = 3, Y = 9, YpW = NA), c(T, T, F), c(), "exo", "BS")

# last_row_simulation <- testsimulation[nrow(testsimulation), ]
# last_row_parameter <- paragrid[nrow(paragrid), ]
# solow_variant <- "BS"
# 
# result <- simulation_correctness_checker(testsimulation[nrow(testsimulation), ],
#                                paragrid[nrow(paragrid), ],
#                                "BS")

# result$last_value
# result$steadystate

# simulation_list <- list(testsimulation_general, testsimulation_land)
# sim_identifier_vector <- c("General Solow Model", "Extended Solow Model with Scarce Resources --- Land")
# vars_selection <- names(testsimulation_general)[c(4, 6, 18, 23)]
# compare_simulations(list(testsimulation_general, testsimulation_land),
#                     c("General Solow Model", "Extended Solow Model with Scarce Resources --- Land"),
#                     names(testsimulation_general)[c(4, 6, 19, 23)])
