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

# 1.1 Simulate the Basic Solow Model =================================
SimulateBasicSolowModel <- function(paragrid, np, startvals){
    # Inputs ---------------------------------
    # paragrid for parameter grid;
    # np for number of periods;
    # vts for vars to simulat
    
    # Load Basic Model Functions ---------------------------------
    source("BSModelFunctions.R")
    
    # Initialize Simulation Table ---------------------------------
    sim_table <- create_simulation_table(variable_encoder(meta_BS_variables), np)
    
    # Fill Start Values for Period 0 ---------------------------------
    aux_index <- which(sim_table$period == 0)
    sim_table[[aux_index, "L"]] <- startvals$L
    sim_table[[aux_index, "K"]] <- startvals$K
    sim_table[[aux_index, "Y"]] <- BS_MF_Y(paragrid[["B"]][[which(paragrid$period == 0)]], 
                                           sim_table[["K"]][[which(sim_table$period == 0)]],
                                           sim_table[["L"]][[which(sim_table$period == 0)]],
                                           paragrid[["alpha"]][[which(paragrid$period == 0)]])
    
    # Computing Variables after Period 0 ---------------------------------
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
    }
    
    # Computing Additional Variables ---------------------------------
    
    remaining_vars_to_compute_bool <- names(sim_table) %in% c("period", "L", "K", "Y")
    
    sim_table <- add_var_computer(sim_table, remaining_vars_to_compute_bool, paragrid, "exo", "BS")
    
    return(sim_table)
}

# # Testing
# testnamel <- c("B", "alpha", "delta", "n", "s")
# testivl <- c(1, 1/3,0.1, 0.04, 0.23)
# testpfcl <- c(NA,NA,NA, NA, NA)
# testnvl <- c(NA, NA, NA, NA, NA)
# np <- 50
# testgridalt <- create_parameter_grid(testnamel, testivl, testpfcl, testnvl, np)
# paragrid <- testgridalt
# startvals <- list(K = 1, L = 1)
# testsimulation <- SimulateBasicSolowModel(testgridalt, np,startvals)
# # View(testsimulation)
# VisualiseSimulation(testsimulation, variable_encoder(meta_BS_variables[1:3]), "free")
