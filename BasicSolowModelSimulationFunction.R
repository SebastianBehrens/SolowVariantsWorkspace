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
    
    # Basic Model Functions ---------------------------------
    BS_MF_KN <- function(s, Y, delta, K){s * Y + (1-delta)*K}
    BS_MF_LN <- function(n, L){(1+n) * L}
    BS_MF_RR <- function(B, K, L, alpha){alpha * B * (K/L)^(alpha - 1)}
    BS_MF_WR <- function(B, K, L, alpha){(1-alpha) * B * (K/L)^alpha}
    BS_MF_Y <- function(B, K, L, alpha){B * K^alpha * L^(1-alpha)}
    
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
    
    remaining_vars_to_compute <- names(sim_table) %in% c("period", "L", "K", "Y")
    
    for(i in names(sim_table)[!remaining_vars_to_compute]){
        # Variants of Output
        if(i == "YpW"){sim_table[["YpW"]] <- sim_table[["Y"]]/sim_table[["L"]]}
        if(i == "YpEW"){sim_table["YpEW"] <- sim_table[["Y"]]/(paragrid[["B"]] * sim_table[["L"]])}
        # Logarithmised Variants
        if(i == "logY"){sim_table[["logY"]] <- sim_table[["Y"]] %>% log()}
        if(i == "logYpW"){sim_table[["logYpW"]] <- sim_table[["YpW"]] %>% log()}
        if(i == "logYpEW"){sim_table[["logYpEW"]] <- sim_table[["YpEW"]] %>% log()}
        # Variants of Growth
        if(i == "gY"){sim_table[["gY"]] <- log(sim_table[["Y"]]) - log(lag(sim_table[["Y"]]))}
        if(i == "gYpW"){sim_table[["gYpW"]] <- log(sim_table[["YpW"]]) - log(lag(sim_table[["YpW"]]))}
        if(i == "gYpEW"){sim_table[["gYpEW"]] <- log(sim_table[["YpEW"]]) - log(lag(sim_table[["YpEW"]]))}
        # Wage Rate
        if(i == "WR"){
            sim_table[["WR"]] <- BS_MF_WR(
                paragrid[["B"]],
                sim_table[["K"]],
                sim_table[["L"]],
                paragrid[["alpha"]])
        }
        # Rental Rate
        if(i == "RR"){sim_table[["RR"]] <- BS_MF_RR(
            paragrid[["B"]],
            sim_table[["K"]],
            sim_table[["L"]],
            paragrid[["alpha"]])
        }
        
    }
    return(sim_table)
}