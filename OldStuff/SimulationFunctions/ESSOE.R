# ### 3.0 Basic Solow Growth Model #############################

# # Meta-Information All Variables =================================
# meta_ESSOE_variables <-
#     c(
#         "Capital Stock",
#         "Labor Stock",
#         "Output",
        
#         "Capital Stock per Worker",
#         "Output per Worker",
        
#         "Capital Stock per Effective Worker",
#         "Output per Effective Worker",
        
#         "Wage Rate",
#         "Rental Rate",
        
#         "National Output",
#         "National Wealth",
#         "National Wealth per Worker",
#         "Net Foreign Assets",
#         "Net Foreign Assets per Worker",
#         "National Savings",
        
#         "Log of Output",
#         "Log of Output per Worker",
#         "Log of Output per Effective Worker",
        
#         "Log of Capital Stock",
#         "Log of Capital Stock per Worker",
#         "Log of Capital Stock per Effective Worker",
        
#         "Growth Rate of Output",
#         "Growth Rate of Output per Worker",
#         "Growth Rate of Output per Effective Worker",
        
#         "Growth Rate of Capital Stock",
#         "Growth Rate of Capital Stock per Worker",
#         "Growth Rate of Capital Stock per Effective Worker"
        
#     )

# SimulateExtendedSolowModelSmallOpenEconomy <- function(paragrid, np, startvals){

#   # Roxygen Header ---------------------------------
#   #' @title Simulates the ESSOE Solow variant
#   #' @description Simulates all (both primary and secondary) endogenous variables to the extended Solow growth model for the small open economy.
#   #' @inheritParams SimulateBasicSolowModel
#   #' @note The structural equations to this model can be found in the vignette to this package:
#   #' \code{vignette("SolowVariants")}
#   #' @export

#   # Function ---------------------------------
    
#     # Load Basic Model Functions ---------------------------------
#     source("ModelFunctions/ESSOEModelFunctions.R")
    
#     # Initialize Simulation Table ---------------------------------
#     sim_table <- create_simulation_table(variable_encoder(meta_ESSOE_variables), np)
#     # Fill Start Values for Period 0 ---------------------------------
#     aux_index <- which(sim_table$period == 0)
#     sim_table[[aux_index, "L"]] <- startvals$L
#     sim_table[[aux_index, "K"]] <- ESSOE_MF_K(paragrid[[aux_index, "r"]],
#                                               paragrid[[aux_index, "alpha"]],
#                                               paragrid[[aux_index, "B"]],
#                                               sim_table[[aux_index, "L"]])
    
#     sim_table[[aux_index, "V"]] <- startvals$V
    
#     sim_table[[aux_index, "F"]] <- ESSOE_MF_F(sim_table[[aux_index, "V"]],
#                                               sim_table[[aux_index, "K"]])
    
#     sim_table[[aux_index, "Y"]] <- ESSOE_MF_Y(paragrid[[aux_index, "B"]], 
#                                            sim_table[[aux_index, "K"]], 
#                                            sim_table[[aux_index, "L"]], 
#                                            paragrid[["alpha"]][[which(paragrid$period == 0)]])
    
#     sim_table[[aux_index, "Yn"]] <- ESSOE_MF_Yn(sim_table[[aux_index, "Y"]], 
#                                                 paragrid[[aux_index, "r"]], 
#                                                 sim_table[[aux_index, "F"]])
#     # Computing Variables after Period 0 ---------------------------------
#     for (i in 1:np){
#         # i <- 1
#         aux_index <- which(sim_table$period == i)
#         # VN for V next since in period 0 only the initial values are computed. every iteration 
#         #                starts with computing the start values of V (the most important 'path defining' variable)
#         sim_table[[aux_index, "V"]] <- ESSOE_MF_VN(sim_table[[aux_index - 1, "Yn"]], 
#                                                    paragrid[[aux_index - 1, "s"]],
#                                                    sim_table[[aux_index - 1, "V"]])
        
#         sim_table[[aux_index, "L"]] <- ESSOE_MF_LN(paragrid[[aux_index - 1, "n"]],
#                                                 sim_table[[aux_index - 1, "L"]])
        
#         sim_table[[aux_index, "K"]] <- ESSOE_MF_K(paragrid[[aux_index, "r"]],
#                                                   paragrid[[aux_index, "alpha"]],
#                                                   paragrid[[aux_index, "B"]],
#                                                   sim_table[[aux_index, "L"]])
        
#         sim_table[[aux_index, "F"]] <- ESSOE_MF_F(sim_table[[aux_index, "V"]],
#                                                   sim_table[[aux_index, "K"]])
        
#         sim_table[[aux_index, "Y"]] <- ESSOE_MF_Y(paragrid[[aux_index, "B"]], 
#                                                sim_table[[aux_index, "K"]],
#                                                sim_table[[aux_index, "L"]],
#                                                paragrid[[aux_index, "alpha"]])
        
#         sim_table[[aux_index, "Yn"]] <- ESSOE_MF_Yn(sim_table[[aux_index, "Y"]], 
#                                                     paragrid[[aux_index, "r"]],
#                                                     sim_table[[aux_index, "F"]])
        
#     }
    
#     # Computing Additional Variables ---------------------------------
    
#     remaining_vars_to_compute_bool <- names(sim_table) %in% c("period", "L", "K", "Y", "V", "F", "Yn")
    
#     sim_table <- add_var_computer(sim_table, remaining_vars_to_compute_bool, paragrid, "exo", "ESSOE")
#     # View(sim_table)
#     return(sim_table)
# }

# # Testing
# # testnamel <- c("B", "alpha", "n", "s", "r")
# # testivl <- c(5, 1/3,0.1, 0.1, 0.05)
# # testpfcl <- c(NA,NA,NA, NA, NA)
# # testnvl <- c(NA, NA, NA, NA, NA)
# # np <- 100
# # testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
# # paragrid <- testgridalt
# # startvals <- list(L = 1, V = 30)
# # testsimulation <- SimulateExtendedSolowModelSmallOpenEconomy(testgridalt, np,startvals)
# # simulation_correctness_checker(testsimulation[nrow(testsimulation), ],
# #                                paragrid[nrow(paragrid), ],
# #                                "ESSOE")
# # 
# # ESSOE_SS_VpW <- function(s, n, r, w){(s/(n- s * r)) * w}
# # ESSOE_SS_VpW(paragrid[[nrow(paragrid), "s"]],
# #              paragrid[[nrow(paragrid), "n"]],
# #              paragrid[[nrow(paragrid), "r"]],
# #              testsimulation[[nrow(testsimulation), "WR"]])
# # 
# # testsimulation[nrow(testsimulation), "VpW"]
# # View(testsimulation)
# # VisualiseSimulation(testsimulation, variable_encoder(meta_ESSOE_variables), "free")
