# ESSRL_parametergrid <- reactive({
#     # Names of Parameters ---------------------------------
#     ESSRL_parameternames <- c("alpha", "beta", "kappa", "delta", "n", "s", "g", "X")
#     # Periods of Changes ---------------------------------
#     ESSRL_parameterchange_period <- c(
#         # auxspot1 (first spot to fill in the code for dynamically created code)
#         if(input$ESSRL_changeinparam_alpha) input$ESSRL_pc_alpha_period else NA, 
#         if(input$ESSRL_changeinparam_beta) input$ESSRL_pc_beta_period else NA, 
#         if(input$ESSRL_changeinparam_kappa) input$ESSRL_pc_kappa_period else NA, 
#         if(input$ESSRL_changeinparam_delta) input$ESSRL_pc_delta_period else NA, 
#         if(input$ESSRL_changeinparam_popgrowth) input$ESSRL_pc_popgrowth_period else NA, 
#         if(input$ESSRL_changeinparam_savings) input$ESSRL_pc_savings_period else NA, 
#         if(input$ESSRL_changeinparam_tfpgrowth) input$ESSRL_pc_tfpgrowth_period else NA, 
#         if(input$ESSRL_changeinparam_land) input$ESSRL_pc_land_period else NA
#     )
#     # Starting Values of Parameters ---------------------------------
#     ESSRL_parameterchange_valuebefore <- c(
#         # auxspot2
#         input$ESSRL_initparam_alpha,
#         input$ESSRL_initparam_beta,
#         input$ESSRL_initparam_kappa,
#         input$ESSRL_initparam_delta,
#         input$ESSRL_initparam_popgrowth,
#         input$ESSRL_initparam_savings,
#         input$ESSRL_initparam_tfpgrowth,
#         input$ESSRL_initparam_land
#     )
#     # Values of Parameters after Change ---------------------------------
#     ESSRL_parameterchange_valueafter <- c(
#         # auxspot3
#         if(input$ESSRL_changeinparam_alpha) input$ESSRL_pc_alpha_newval else NA,
#         if(input$ESSRL_changeinparam_beta) input$ESSRL_pc_beta_newval else NA,
#         if(input$ESSRL_changeinparam_kappa) input$ESSRL_pc_kappa_newval else NA,
#         if(input$ESSRL_changeinparam_delta) input$ESSRL_pc_delta_newval else NA,
#         if(input$ESSRL_changeinparam_popgrowth) input$ESSRL_pc_popgrowth_newval else NA,
#         if(input$ESSRL_changeinparam_savings) input$ESSRL_pc_savings_newval else NA,
#         if(input$ESSRL_changeinparam_tfpgrowth) input$ESSRL_pc_tfpgrowth_newval else NA,
#         if(input$ESSRL_changeinparam_land) input$ESSRL_pc_land_newval else NA
#     )
#     # Creating the Grid ---------------------------------
#     create_parameter_grid(
#         ESSRL_parameternames,
#         ESSRL_parameterchange_valuebefore,
#         ESSRL_parameterchange_period,
#         ESSRL_parameterchange_valueafter,
#         input$ESSRL_nperiods_selected
#     )
#     
# })

# 1. create those vectors without elements
# 2. iterate over the required parameters of the model and add them to the grid-defining-vectors (NA when something does not exist) (function!)


source("AutomatingShinyAppPageCreation.R")
create_parameter_grid_advanced <- function(ModelCode, np, n_ModelComparison){
    parameternames <- getRequiredParams(ModelCode)
    # iteratively execute calls with the created strings
    parameterchange_valuebefore <- c()
    parameterchange_valueafter <- c()
    parameterchange_period <- c()
    
    for(i in parameternames){
    # create strings of parameters
        # i <- "n"
        # ModelCode <- "BS"
    string_parameterchange_indicator <- paste("ComparingModels",n_ModelComparison, "_", ModelCode, "_parameterchange_indicator_", partAhelper_1(i), sep = "")
    string_parameterchange_period <- paste("ComparingModels",n_ModelComparison, "_", ModelCode, "_parameterchange_period_", partAhelper_1(i), sep = "")
    string_parameterchange_valuebefore <- paste("ComparingModels",n_ModelComparison, "_", ModelCode, "_parameterchange_valuebefore_", partAhelper_1(i), sep = "")
    string_parameterchange_valueafter <- paste("ComparingModels",n_ModelComparison, "_", ModelCode, "_parameterchange_valueafter_", partAhelper_1(i), sep = "")
    
        
        parameterchange_period <- doCall(paste("c(parameterchange_period, if(input$", string_parameterchange_indicator,") input$", string_parameterchange_period," else NA)", sep = ""))
        parameterchange_valuebefore <- doCall(paste("c(string_parameterchange_valuebefore, input$", string_parameterchange_valuebefore, ")", sep = ""))
        parameterchange_valueafter <- doCall(paste("c(string_parameterchange_valueafter, if(input$", string_parameterchange_indicator,") input$", string_parameterchange_valueafter," else NA)", sep = ""))
    }
    
    create_parameter_grid(getRequiredParams(ModelCode),
                          parameterchange_valuebefore,
                          paraeterchange_period,
                          paramterchange_valueafter,
                          np)
}

getRequiredParams <- function(ModelCode){
    out <- if(ModelCode == "BS"){ 
        out <- c("B", "alpha", "delta", "n", "s")
        }else if(ModelCode == "GS"){
        out <- c("g", "alpha", "delta", "n", "s")
        }else if(ModelCode == "ESSOE"){
        out <- c("B", "alpha", "n", "s", "r")
        }else if(ModelCode == "ESSRL"){
            out <- c("alpha", "beta", "kappa", "delta", "n", "s", "g", "X")
        }else if(ModelCode == "ESSRO"){
            out <- c("alpha", "beta", "n", "g", "sE", "s", "delta")
        }else if(ModelCode == "ESSROL"){
            out <- c("alpha", "beta", "kappa", "delta", "n", "s", "sE", "g", "X")
        }else if(ModelCode == "ESHC"){
            out <- c("alpha", "phi", "n", "g", "sK", "sH", "delta")
        }else(
            out <- NaN
        )
    if(is.na(out)){warning("The entered shortcode for a model variant does not exist.")}
    return(out)
}


# copied to compare models