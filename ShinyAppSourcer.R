getShinyPart <- function(kind, which, n_ModelComparison=0) {
    # kind for "server" or "tab"
    # which for the abbreviation of the respective part
    
    # stitches path to source file together and then returns the shiny frontend ui code. (for comparison tab (kind "D") all 'parts' returned but only the conditionally triggered one actually appearing.)

    if (kind %in% c("S", "T", "D")) {} else {
        stop("The entered value for 'kind' in getShinyPart() is not defined.")
    }
    if(kind == "D" && n_ModelComparison == 0){stop("When using 'D' in getShinyPart() make sure to deliver an appropriate value to n_ModelComparison")}
    source_part1 <- if(kind == "T"){"Tabs"}else if(kind == "S"){"ServerParts"}else if(kind == "D"){"DynamicInterfaces"}
    source_part2 <- if(kind == "T"){"Tab.R"}else if(kind == "S"){"Server.R"}else if(kind == "D"){"DynamicInterface.R"}
    path_to_source <- paste0(
        source_part1, 
        "/", 
        ifelse(kind == "D", paste0("Group", n_ModelComparison, "/"), ""),
        which, 
        source_part2
    )
    
    if(kind == "T"){
        source(path_to_source)
        return(get(paste0(which, "Tab")))
    }else if(kind == "S"){
        # source(path_to_source, local = TRUE)
    }else if(kind == "D"){
        source(path_to_source)
        return(get(paste0(which, "DynamicInterface")))
    }
}

# getShinyPart("D", "GS", 1)

# kind <- "D"
# which <- "GS"
# n_ModelComparison <- 1
getVariablesAvailableToBeVisualised <- function(ModelCode1,
                                                ModelCode2){

  
  variables1 <- getModelVars(ModelCode1)
  variables2 <- getModelVars(ModelCode2)
  shared_variables <- intersect(variables1, variables2)
  return(shared_variables)
}