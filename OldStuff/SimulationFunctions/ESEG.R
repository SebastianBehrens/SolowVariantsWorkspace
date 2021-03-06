# ### 1.0 Extended Solow Growth Model for Endogeneous Growth #############################

# # Meta-Information All Variables =================================
# meta_ESEG_variables <-
#     c(
#         "Output",
#         "Consumption",
#         "Capital Stock",
#         "Labor Stock",
#         "Total Factor Productivity",
#         "Output per Worker",
#         "Consumption per Worker",
#         "Capital Stock per Worker",
#         "Output per Effective Worker",
#         "Consumption per Effective Worker",
#         "Capital Stock per Effective Worker",
        
#         "Wage Rate",
#         "Rental Rate",
        
#         "Log of Capital Stock",
#         "Log of Capital Stock per Worker",
#         "Log of Capital Stock per Effective Worker",
        
#         "Log of Output",
#         "Log of Output per Worker",
#         "Log of Output per Effective Worker",
        
#         "Growth Rate of Output",
#         "Growth Rate of Output per Worker",
#         "Growth Rate of Output per Effective Worker",
        
#         "Growth Rate of Capital Stock",
#         "Growth Rate of Capital Stock per Worker",
#         "Growth Rate of Capital Stock per Effective Worker"
#     )

# SimulateExtendedSolowModelEndogenousGrowth <- function(paragrid, np, startvals){

#   # Roxygen Header ---------------------------------
#   #' @title Simulates the ESEG Solow variant
#   #' @description Simulates all (both primary and secondary) endogenous variables to the extended Solow growth model with endogenous technological growth.
#   #' @inheritParams SimulateBasicSolowModel
#   #' @note The structural equations to this model can be found in the vignette to this package:
#   #' \code{vignette("SolowVariants")}
#   #' @export

#   # Function ---------------------------------

#     # Initialize Simulation Table ---------------------------------
#     sim_table <- create_simulation_table(variable_encoder(meta_ESEG_variables), np)
    
#     # Fill Start Values for Period 0 ---------------------------------
#     aux_index <- which(sim_table$period == 0)
#     sim_table[[aux_index, "L"]] <- startvals$L
#     sim_table[[aux_index, "K"]] <- startvals$K
#     sim_table[[aux_index, "Y"]] <- ESEG_MF_Y(sim_table[["K"]][[which(sim_table$period == 0)]],
#                                            sim_table[["L"]][[which(sim_table$period == 0)]],
#                                            paragrid[["alpha"]][[which(paragrid$period == 0)]],
#                                            paragrid[["phi"]][[which(paragrid$period == 0)]])
    
#     # Computing Variables after Period 0 ---------------------------------
#     for (i in 1:np){
#         # i <- 1
#         # print(i)
#         aux_index <- which(sim_table$period == i)
#         sim_table[[aux_index, "L"]] <- ESEG_MF_LN(paragrid[["n"]][[which(paragrid$period == i-1)]],
#                                                 sim_table[["L"]][[which(sim_table$period == i-1)]])
#         sim_table[[aux_index, "K"]] <- ESEG_MF_KN(paragrid[["s"]][[which(paragrid$period == i-1)]],
#                                                 sim_table[["Y"]][[which(sim_table$period == i-1)]],
#                                                 paragrid[["delta"]][[which(paragrid$period == i-1)]],
#                                                 sim_table[["K"]][[which(sim_table$period == i-1)]])
#         sim_table[[aux_index, "Y"]] <- ESEG_MF_Y(sim_table[["K"]][[aux_index]],
#                                                  sim_table[["L"]][[aux_index]],
#                                                  paragrid[["alpha"]][[aux_index]],
#                                                  paragrid[["phi"]][[aux_index]])
#     }
    
#     # Computing Additional Variables ---------------------------------
    
#     remaining_vars_to_compute_bool <- names(sim_table) %in% c("period", "L", "K", "Y")
    
#     sim_table <- add_var_computer(sim_table, remaining_vars_to_compute_bool, paragrid, "special", "ESEG")
    
#     return(sim_table)
# }
# # Working for phi << 1 but not for phi ~ 1 (not sure why)

# # # Testing
# # phi <- 0.9999
# # n <- 0
# # delta <- 0.15
# # s <- 0.2
# # 
# # 
# # testnamel <- c("alpha", "phi", "delta", "n", "s")
# # testivl <- c(1/3, phi, delta, n, s)
# # testpfcl <- c(NA,NA,NA, NA, NA)
# # testnvl <- c(NA, NA, NA, NA, NA)
# # np <- 200
# # testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
# # paragrid <- testgridalt
# # startvals <- list(K = 1, L = 1)
# # testsimulation <- SimulateExtendedSolowModelEndogenousGrowth(testgridalt, np,startvals)
# # 
# # source("HelperFunctions.R")
# # 
# # (1 + n)^(1/(1- phi)) > 1- delta
# # (testsimulation[["TFP"]][[201]] - testsimulation[["TFP"]][[200]])/testsimulation[["TFP"]][[200]]
# # ESEG_SS_gYpW(n, phi, s, testsimulation[["TFP"]][[201]], delta)
# # 
# # simulation_correctness_checker(testsimulation[nrow(testsimulation), ],
# #                                paragrid[nrow(paragrid), ],
# #                                "ESEG")

# # VisualiseSimulation(testsimulation, variable_encoder("Capital Stock per Worker"), "free")

