

### 0 Preparations (helper functions) #############################
# 0.1 individual parameter path  ---------------------------------
create_path <- function(iv, pfc = NA, nv = NA, np){
  ## will create a vector of parameter values for periods 0 through n.
  # iv for initial value;
  # pfc for period for change;
  # nv for new value;
  # np vor number of periods
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
  for(i in c(1:length(namel))){
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
# testpfcl <- c(NA,NA,NA, NA, NA)
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
      aux2 == "National Savings" ~ "Sn",
      
      aux2 == "Energy Use" ~ "E",
      aux2 == "Resource Stock" ~ "R"
      
      
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
    if(i == "Sn"){sim_data[["Sn"]] <- paragrid[["s"]] * sim_data[["Yn"]]}
    if(i == "VpW"){sim_data[["VpW"]] <- sim_data[["V"]] / sim_data[["L"]]}
    
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
        phi = last_row_parameter[["phi"]],
        YpW = last_row_simulation[["YpW"]],
        RR = last_row_simulation[["RR"]],
        w = last_row_simulation[["WR"]],
        A = last_row_simulation[["TFP"]]
      )
    
    if(solow_variant == "BS") {
      aux_steadystate_variables <- variable_encoder(meta_BS_variables[c(4, 5, 8, 9)])
    }else if(solow_variant == "GS"){
      aux_steadystate_variables <- variable_encoder(meta_GS_variables[c(6, 7, 8, 9)]) # CpW missing.
    }else if(solow_variant == "ESSOE"){
      aux_steadystate_variables <- variable_encoder(meta_ESSOE_variables[c(4, 5, 8, 12)]) # CpW missing.
    }else if(solow_variant == "ESHC"){
      aux_steadystate_variables <- variable_encoder(meta_ESHC_variables[c(8, 9, 10, 11)]) # CpW missing.
    }
    
    for(i in aux_steadystate_variables){
      i <- aux_steadystate_variables[1]
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


# 0.99 testing ---------------------------------
# vtstest <- c("testvar", "ja", "nein")
# create_simulation_table(vtstest, 20)
# variable_encoder(c("Rental Rate"))
# add_var_computer(tibble(L = 3, Y = 9, YpW = NA), c(T, T, F), c(), "exo", "BS")

# last_row_simulation <- testsimulation[nrow(testsimulation), ]
# last_row_parameter <- paragrid[nrow(paragrid), ]
# solow_variant <- "GS"
# 
# result <- simulation_correctness_checker(testsimulation[nrow(testsimulation), ],
#                                paragrid[nrow(paragrid), ],
#                                "GS")
# 
# result$last_value
# result$steadystate




### 1.0 Basic Solow Growth Model #############################

# Meta-Information All Variables =================================
meta_BS_variables <-
  c(
    "Capital Stock",
    "Labor Stock",
    "Wage Rate",
    "Rental Rate",
    "Output",
    "Output per Worker",
    "Output per Effective Worker",
    "Log of Output",
    "Log of Output per Worker",
    "Log of Output per Effective Worker",
    "Growth Rate of Output",
    "Growth Rate of Output per Worker",
    "Growth Rate of Output per Effective Worker"
  )




## Testing
# testnamel <- c("B", "alpha", "delta", "n", "s")
# testivl <- c(2,1/3,0.1, 0.04, 0.23)
# testpfcl <- c(NA,NA,NA, NA, NA)
# testnvl <- c(NA, NA, NA, NA, NA)
# np <- 5
# testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
# paragrid <- testgridalt
# startvals <- list(K = 1, L = 1)
# testsimulation <- SimulateBasicSolowModel(testgridalt, np, list(K = 1, L = 1))
# # View(testsimulation)
# VisualiseSimulation(testsimulation, c("Y", "RR", "WR"), "free")
# 
# 


# Chapter 9 Model 
# L_A <- function(sr, L){sr * L}
# L_Y <- function(sr, L){(1-sr) * L}
# Y <- function(K, A, LY, alpha){(K^alpha)*(A * LY)^(1-alpha)}
# A_next <- function(rho, A, phi, lambda, LA){rho*(A^phi)*LA^lambda + A}
# c_fun <- function(s, Y, L){((1-s) * Y)/L}

# 
# data <- tibble(
#   K = K0,
#   A = A0,
#   L = L0,
#   LA = L_A(sR, L0),
#   LY = L_Y(sR, L0),
#   Y = Y(K0, A0, (1-sR)*L0, alpha),
#   c = c_fun(s, Y, L),
#   k = K/L,
#   y = Y/L,
#   y_tilde = y/A,
#   k_tilde = k/A,
#   c_tilde = c/A,
#   growth_k = NA,
#   growth_y = NA,
#   growth_c = NA,
#   period = 1
# )
# 
# 
# # data
# 
# periods <- 200
# for (i in 2:periods){
#   # i <- 2
#   # i <- i + 1




#########################################################################################
#####################             Other Stuff                       #####################
#########################################################################################

#   # calculating variables to be added ---------------------------------
#   Kinloop <- data$K[[i-1]]
#   Linloop <- data$L[[i-1]]
#   Ainloop <- data$A[[i-1]]
#   Yinloop <- data$Y[[i-1]]
#   LA_inloop <- data$LA[[i-1]]
#   LY_inloop <- data$LY[[i-1]]
#   
#   
#   
#   K_next_c <- K_next(s, Yinloop, delta, Kinloop)
#   # if(i <= 12){
#   #   K_next_c <- K0
#   # }
#   # 
#   A_next_c <- A_next(rho, Ainloop, phi, lambda, LA_inloop)
#   Y_next_c <- Y(K_next_c, A_next_c, LY_inloop, alpha)
#   L_next_c <- L_next(n_path[[i-1]], Linloop)
#   LA_next_c <- L_A(sR, L_next_c)
#   LY_next_c <- L_Y(sR, L_next_c)
#   c_next_c <- c_fun(s, Y_next_c, L_next_c)
#   k_next_c <- K_next_c/L_next_c
#   y_next_c <- Y_next_c/L_next_c
#   y_tilde_next_c <- y_next_c/A_next_c
#   k_tilde_next_c <- k_next_c/A_next_c
#   c_tilde_next_c <- c_next_c/A_next_c
#   
#   
#   data <- data %>%
#     complete(
#       K = K_next_c,
#       A = A_next_c,
#       L = L_next_c,
#       LA = LA_next_c,
#       LY = LY_next_c,
#       Y = Y_next_c,
#       c = c_next_c,
#       k = k_next_c,
#       y = y_next_c,
#       k_tilde = k_tilde_next_c,
#       c_tilde = c_tilde_next_c, 
#       y_tilde = y_tilde_next_c,
#       growth_k = log(k_next_c) - log(data$k[[i-1]]),
#       growth_y = log(y_next_c) - log(data$y[[i-1]]),
#       growth_c = log(c_next_c) - log(data$c[[i-1]]),
#       period = i
#     )
#   data <- data %>% arrange(period) %>% relocate(period)
#   
# }
# 
# growth_rate_computer <- function(series){log(series) - log(lag(series))}
# 
# data <- data %>% mutate(sy_tilde = s* y_tilde,
#                         gt = growth_rate_computer(A),
#                         kt_lned = log(k),
#                         y_lned = log(y),
#                         c_lned= log(c),
#                         gy = growth_rate_computer(data$y))
# 
# 
# 
# 
# data <- data %>% select(-c("K", "LA", "LY","Y", "k", "c", "y", "growth_c", "growth_y", "growth_k"))
# # data
# data_long <- data %>% pivot_longer(-period) %>% mutate(name = as.factor(name))
# # levels(data_long$name)
# levels(data_long$name) <- c("Total factor productivity",
#                             "Logarithm of consumption per worker",
#                             "Consumption per effective worker",
#                             "Growth of TFP",
#                             "Growth of output per worker",
#                             "Capital per effective worker",
#                             "Logarithm of capital per worker",
#                             "Workforce",
#                             "Investment rate times output per effective worker",
#                             "Logarithm of output per worker", 
#                             "Output per effective worker")
# 
# # data_long %>% mutate(period = period - 1) %>% tail()
# 
# data_long %>% mutate(period = period - 1) %>% drop_na() %>% ggplot(aes(period, value, col = name)) + geom_line() + facet_wrap(~name, scales = "free", ncol = 3)+ labs(x = "Period", y = "Value") + theme(legend.position = "none")