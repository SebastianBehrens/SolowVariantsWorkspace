

# Creating Helper Functions =================================
# path function ---------------------------------
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

# path grid function ---------------------------------
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


# simulation table function ---------------------------------
create_simulation_table <- function(vts, np) {
  # vts for variables to simulate
  aux <- tibble(period = c(0:np))
  for (i in c(1:length(vts))) {
    aux_sequence <- rep(NA, np + 1)
    aux[[vts[[i]]]] <- as.double(aux_sequence)
  }
  return(aux)
}

# testing
# vtstest <- c("testvar", "ja", "nein")
# create_simulation_table(vtstest, 20)

# start values filler (not used) ---------------------------------
# fill_start_values <- function(var, value, dataset){
#   index <- which(dataset$period == 0)
#   dataset[[index, var]] <- value
#   return(dataset)
# }
# vts <- c("L", "K", "RR", "WR", "Y", vts)
# sim_table <- create_simulation_table(vts, np)
# fill_start_values("testvar", 5, sim_table)
# Model Functions =================================

# Simulating the Economy =================================

SimulateBasicSolowModel <- function(paragrid, np, vts, startvals){
  # paragrid for parameter grid;
  # np for number of periods;
  # vts for vars to simulate
  
  # paragrid <- test
  
  # Basic Model Functions ---------------------------------
  BS_MF_KN <- function(s, Y, delta, K){s * Y + (1-delta)*K}
  BS_MF_LN <- function(n, L){(1+n) * L}
  BS_MF_RR <- function(B, K, L, alpha){alpha * B * (K/L)^(alpha - 1)}
  BS_MF_WR <- function(B, K, L, alpha){(1-alpha) * B * (K/L)^alpha}
  BS_MF_Y <- function(B, K, L, alpha){B * K^alpha * L^(1-alpha)}
  
  # Initialize Simulation Table ---------------------------------
  # vts <- c("YpW", "YpEW")
  vts <- c("L", "K", "RR", "WR", "Y", vts)
  sim_table <- create_simulation_table(vts, np)
  
  # Fill in Start Values for Period 0 ---------------------------------
  # startvals <- list(L = 1, K = 2)
  aux_index <- which(sim_table$period == 0)
  sim_table[[aux_index, "L"]] <- startvals$L
  sim_table[[aux_index, "K"]] <- startvals$K
  sim_table[[aux_index, "Y"]] <- BS_MF_Y(paragrid[["B"]][[which(paragrid$period == 0)]], 
                                         sim_table[["K"]][[which(sim_table$period == 0)]],
                                         sim_table[["L"]][[which(sim_table$period == 0)]],
                                         paragrid[["alpha"]][[which(paragrid$period == 0)]])
  sim_table[[aux_index, "RR"]] <- BS_MF_RR(paragrid[["B"]][[which(paragrid$period == 0)]], 
                                           sim_table[["K"]][[which(sim_table$period == 0)]],
                                           sim_table[["L"]][[which(sim_table$period == 0)]],
                                           paragrid[["alpha"]][[which(paragrid$period == 0)]])
  
  sim_table[[aux_index, "WR"]] <- BS_MF_WR(paragrid[["B"]][[which(paragrid$period == 0)]], 
                                           sim_table[["K"]][[which(sim_table$period == 0)]],
                                           sim_table[["L"]][[which(sim_table$period == 0)]],
                                           paragrid[["alpha"]][[which(paragrid$period == 0)]])
  # Simulating Periods after Period 0 ---------------------------------
  for (i in 1:np){
    # i <- 1
    # print(i)
    aux_index <- which(sim_table$period == i)
    sim_table[[aux_index, "L"]] <- BS_MF_LN(paragrid[["n"]][[which(paragrid$period == i-1)]],
                                            sim_table[["L"]][[which(sim_table$period == i-1)]])
    sim_table[[aux_index, "K"]] <- BS_MF_KN(paragrid[["s"]][[which(paragrid$period == i-1)]],
                                            sim_table[["Y"]][[which(sim_table$period == i-1)]],
                                            paragrid[["delta"]][[which(paragrid$period == i-1)]],
                                            sim_table[["K"]][[which(sim_table$period == i-1)]])
    sim_table[[aux_index, "Y"]] <- BS_MF_Y(paragrid[["B"]][[which(paragrid$period == i)]], 
                                           sim_table[["K"]][[which(sim_table$period == i)]],
                                           sim_table[["L"]][[which(sim_table$period == i)]],
                                           paragrid[["alpha"]][[which(paragrid$period == i)]])
    sim_table[[aux_index, "RR"]] <- BS_MF_RR(paragrid[["B"]][[which(paragrid$period == i)]], 
                                             sim_table[["K"]][[which(sim_table$period == i)]],
                                             sim_table[["L"]][[which(sim_table$period == i)]],
                                             paragrid[["alpha"]][[which(paragrid$period == i)]])
    
    sim_table[[aux_index, "WR"]] <- BS_MF_WR(paragrid[["B"]][[which(paragrid$period == i)]], 
                                             sim_table[["K"]][[which(sim_table$period == i)]],
                                             sim_table[["L"]][[which(sim_table$period == i)]],
                                             paragrid[["alpha"]][[which(paragrid$period == i)]])
    
  }
  
  # Computing Additional Variables ---------------------------------
  remaining_vars_to_compute <- vts %in% c("L", "K", "RR", "WR", "Y")
  for(i in vts[!remaining_vars_to_compute]){
    print(i)
    if(i == "YpW"){sim_table <- sim_table %>% mutate(YpW = Y/L)}
    if(i == "YpEW"){sim_table <- sim_table %>% mutate(YpEW = Y/(paragrid[["B"]]*L))}
  }
  
  
  return(sim_table)
}

VisualiseSimulation <- function(simulation_data, variables){
  # simulation_data <- sim_table
  variables <- c("period", variables)
  simulation_data %>% select(variables) %>% 
    pivot_longer(-period, names_to = "Variable") %>% 
    mutate(Variable = as.factor(Variable)) %>% 
    ggplot(aes(period, value, col = Variable)) + 
    geom_line() + 
    facet_wrap(~Variable, scales = "free", ncol = 3)+ 
    labs(x = "Period", y = "Value") + 
    theme(legend.position = "none")
}

## Testing
# testnamel <- c("B", "alpha", "delta", "n", "s")
# testivl <- c(1,1/3,0.1, 0.04, 0.23)
# testpfcl <- c(NA,NA,NA, NA, NA)
# testnvl <- c(NA, NA, NA, NA, NA)
# testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, 200)
# addvarstest <- c("YpW", "YpEW")
# testsimulation <- SimulateBasicSolowModel(testgridalt, 200, addvarstest, list(K = 1, L = 1))
# VisualiseSimulation(testsimulation, c("Y", "RR", "WR", addvarstest))
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