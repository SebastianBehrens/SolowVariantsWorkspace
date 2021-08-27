# Automating Page Creation in Shiny App Macro Models
# Sketch on How To ---------------------------------
# A: Create Sidebar Panel
# 1. Fill parameter slots
# - get parameter name
#[- translator function for n => popgrowth (g => tfpgrowth, ...)]
# - create code for startvalue, change in parameter true or false, change in parameter new value, change in parameter period of change
# B: Create Parameter Grid
# 1. get parameter name
# 2. fill in 
# C: Create List with Start Values
# 2. Fill start value slots
# - get input "A"
# - create the entry in the list with the abbreviation
# D: Fill in Model Abbreviation to Serverside Simulation Part
# - find replace for identifying string


# 00 ---------------------------------
# Create duplicate of templates as new directory for new creation 
# setwd("..")
# getwd()
setwd("/Users/sebastianbehrens/Documents/GitHub/SolowVariants")
source("HelperFunctions.R")
library(dplyr)
library(readr)
library(styler)
# library(connect)
# install.packages("connect")
# A ---------------------------------
createpartA <- function(parameternames, new_abbreviation, startvars){
    # this function creates the sidebar 
    code_template <- readLines("PartASnippet.R")
    
    counter <- 1
    for(aux_parameter in rev(parameternames)){
        aux_parameter_code <- code_template
        
        aux_parameter_code <- gsub(pattern = "ESHC", replace = new_abbreviation, x = aux_parameter_code)
        aux_parameter_code <- gsub(pattern = "phi", replace = partAhelper_1(aux_parameter), x = aux_parameter_code)
        aux_parameter_code <- gsub(pattern = "Phi", replace = partAhelper_2(aux_parameter), x = aux_parameter_code)
        aux_parameter_code <- gsub(pattern = "auxinitval", replace = pageCreationHelper_initval(aux_parameter), x = aux_parameter_code)
        aux_parameter_code <- gsub(pattern = "auxstep", replace = pageCreationHelper_step(aux_parameter), x = aux_parameter_code)
        aux_parameter_code <- gsub(pattern = "auxnewval", replace = pageCreationHelper_newval(aux_parameter), x = aux_parameter_code)
        if(counter == 1){
            # gsub("a", "b", "ababab")
            aux_parameter_code[[8]] <- gsub(pattern = "),", replace = ")", x = aux_parameter_code[[8]])
            counter <- counter + 1
        }
        line_number_to_write_to <- grep("ParameterCodeAutoFillLineIndexer", read_lines("TemplatePartA.R"))
        writeLines(c(read_lines("TemplatePartA.R", n_max = line_number_to_write_to), aux_parameter_code, read_lines("TemplatePartA.R", skip = line_number_to_write_to)), con="TemplatePartA.R")
        writeLines(gsub(pattern = "ESHC", replace = new_abbreviation, x = read_lines("TemplatePartA.R")), "TemplatePartA.R")
        writeLines(gsub(pattern = "panetitle", replace = pageCreationHelper_paneltitle(new_abbreviation), x = read_lines("TemplatePartA.R")), "TemplatePartA.R")
        
    }
    createpartE(startvars, new_abbreviation)
    
    
    
    
}

# B ---------------------------------
createpartB <- function(parameternames, new_abbreviation){
    code_template <- readLines("PartBSnippet.R")
    counter <- 1
    
    for(aux_parameter in rev(parameternames)){
        # parameternames <- c("g", "n")
        aux_template <- code_template
        aux_template <- gsub(pattern = "BS", replace = new_abbreviation, x = aux_template)
        aux_template <- gsub(pattern = "tfp", replace = partAhelper_1(aux_parameter), x = aux_template)
        if(counter == 1){
            aux_template <- gsub(",", "", aux_template)
            counter <- counter + 1
        }
        partBhelper(aux_template[1], "auxspot1", "TemplatePartB.R")
        partBhelper(aux_template[2], "auxspot2", "TemplatePartB.R")
        partBhelper(aux_template[3], "auxspot3", "TemplatePartB.R")
    }
    writeLines(gsub(pattern = "BS", replace = new_abbreviation, x = read_lines("TemplatePartB.R")), "TemplatePartB.R")
    
    # fill in vector of all starting variables
    writeLines(gsub(pattern = "auxparameternamevector", replace = getRequiredParams_as_string(new_abbreviation), x = read_lines("TemplatePartB.R")), "TemplatePartB.R")
    # removing comma before closing parenthesis (syntax error) — not working — doing manually for now.
    # final_template_version <- read_lines("TemplatePartB.R")
    # final_template_version_modified <- gsub(pattern = ",$", replace = "", x = final_template_version)
    # writeLines(final_template_version_modified, con="TemplatePartB.R")
}
partBhelper <- function(string_to_write, location_index_string, target_file_name){
    aux_linenumber_to_write_to <- grep(location_index_string, read_lines(target_file_name))
    writeLines(c(read_lines(target_file_name, n_max = aux_linenumber_to_write_to), string_to_write, read_lines(target_file_name, skip = aux_linenumber_to_write_to)), con=target_file_name)
}
# createpartB(c("g", "n"), "ESSRO")
# C ---------------------------------
# starting_variables <- getRequiredStartingValues("ESSOE")
# new_abbreviation <- "ESSOE"
createpartC <- function(starting_variables, new_abbreviation){
    counter <- 1
    for(var in starting_variables){
        aux_code <- paste(var, " = input$ESSOE_initval_", var, ",", sep = "")
        aux_code <- gsub("ESSOE", new_abbreviation, x = aux_code)
        if(counter == 1){
            aux_code <- gsub(",", "", aux_code)
            counter <- counter + 1
        }
        partBhelper(aux_code, "auxspot1", "TemplatePartC.R")
    }
}
# createpartC(c("K", "L"), "ESHC")

# D ---------------------------------
createpartD <- function(new_abbreviation, new_name_of_simulation_function){
    text  <- readLines("TemplatePartD.R")
    text_modified  <- gsub(pattern = "ESHC", replace = new_abbreviation, x = text)
    text_modified  <- gsub(pattern = "SimulateExtendedSolowModelHumanCapital", replace = new_name_of_simulation_function, x = text_modified)
    partC <- readLines("TemplatePartC.R")
    partC_modified <- partC[-2] %>% paste(collapse = "")
    text_modified <- gsub(pattern = "InitialValueListCodeAutoFillLineIndexer", replace = partC_modified, x = text_modified)
    writeLines(text_modified, con="TemplatePartD.R")
    style_file("TemplatePartD.R", transformers = tidyverse_style(strict = TRUE))
}


# createpartD("ESSROL", getSimFunction("ESSROL"))
# new_name_of_simulation_function <- getSimFunction("ESSROL")
# new_abbreviation <- "ESSROL"
# E ---------------------------------
createpartE <- function(startingvariables, new_abbreviation){
    # counter <- 1
    for(i in rev(startingvariables)){
        aux_code <- paste('numericInput("', new_abbreviation, '_initval_', i, '", "Initial Value of auxfullname", 1),', sep = "")
        aux_code <- gsub("auxfullname", pageCreationHelper_fullname_of_intival_variable_abbreviation(i), x = aux_code)
        # if(counter == 1){
        #     aux_code <- gsub(pattern = "),", replace = ")", x = aux_code)
        #     counter <- counter + 1
        # }
        partBhelper(aux_code, "StartingValuesCodeAutoFillLineIndexer", "TemplatePartA.R")
    }
}

# Create it all ---------------------------------
createPage <- function(parameters, abbreviation, name_of_sim_function, startvars){
    # Create new folder and set as directory ---------------------------------
    setwd("/Users/sebastianbehrens/Documents/GitHub/SolowVariants/PageCreation")
    system(paste("mkdir", abbreviation))
    system(paste("cp -R Template/. ", abbreviation, "/", sep = ""))
    setwd(paste(abbreviation))
    # Execute all sub steps ---------------------------------
    createpartA(parameters, abbreviation, startvars)
    
    # finish the tab file
    # style it properly
    style_file("TemplatePartA.R", transformers = tidyverse_style(strict = TRUE))
    # save under xxxTab.R
    file.rename("TemplatePartA.R", paste(abbreviation, "Tab.R", sep = ""))
    
    createpartB(parameters, abbreviation)
    createpartC(startvars, abbreviation)
    createpartD(abbreviation, name_of_sim_function)
    write(readLines("TemplatePartD.R"), file = "TemplatePartB.R", append = TRUE)
    file.rename("TemplatePartB.R", paste(abbreviation, "Server.R", sep = ""))
    # move xxxTab.R file to correct location
    from_string <- paste0(abbreviation, "Server.R")
    to_string <- paste0("../../ServerParts/", abbreviation, "Server.R")
    system(paste("mv ", from_string, to_string))
    # move xxxServer.R file to correct location
    from_string <- paste0(abbreviation, "Tab.R")
    to_string <- paste0("../../Tabs/", abbreviation, "Tab.R")
    system(paste("mv ", from_string, to_string))
    # delete files other than xxxServer.R and xxxTab.R
    aux <- list.files()
    aux_indicator <- aux %in% c(paste0(abbreviation, "Server.R"),
                                paste0(abbreviation, "Tab.R"))
    unlink(aux[!aux_indicator])
    
    
    
}

setwd("/Users/sebastianbehrens/Documents/GitHub/SolowVariants")
source("HelperFunctions.R")
#  ==================================================================
# 
# all_abbrevs <- c("BS", "GS", "ESSOE", "ESHC", "ESSRO", "ESSRL", "ESSROL")
# all_abbrevs <- c("ESSRL")
# for(i in all_abbrevs){
#     aux_params <- getRequiredParams(i)
#     aux_simfun <- getSimFunction(i)
#     aux_initvals <- getRequiredStartingValues(i)
#     createPage(aux_params,
#                i,
#                aux_simfun,
#                aux_initvals)
# }
#  ==================================================================
# createPage(c("g", "n", "sK"), "ESSMY", "my_custom_simulation_function", c("A", "K", "L"))
# parameters <- c("g", "n", "sK")
# abbreviation <- "ESSMY"
# name_of_sim_function <- "my_custom_simulation_function"
# startvars <- c("A", "K", "L")

# value <- readline(prompt = "Enter something ")
# createPage(c("alpha", "beta", "n", "g", "sE", "s", "delta"), 
#                 "ESSRO", 
#                 "SimulateExtendedSolowModelScarceResourceOil", 
#                 c("A", "K", "L", "R"))
# createPage(c("alpha", "beta", "kappa", "delta", "n", "s", "g", "X"), 
#                 "ESSRL", 
#                 "SimulateExtendedSolowModelScarceResourceLand", 
#                 c("A", "K", "L"))
# createPage(c("alpha", "beta", "kappa", "delta", "n", "s", "sE", "g", "X"), 
#                 "ESSROL", 
#                 "SimulateExtendedSolowModelScarceResourceOilAndLand", 
#                 c("A", "K", "L"))
# createPage( c("alpha", "beta", "kappa", "delta", "n", "s", "sE", "g", "X"),
#                 "ESSROL",
#                 "SimulateExtendedSolowModelScarceResourceOilAndLand",
#                 c("A", "K", "L"))

# End ---------------------------------
# Return to overheading directory
# setwd("..")

# Using the above code to generate all the parameter input interfaces when comparing models =================================

pageCreationHelper_initval <- function(parameter){
    out <- case_when(
        parameter == "B"~ "1", 
        parameter == "alpha"~ "2/5", 
        parameter == "beta"~ "2/5", 
        parameter == "kappa"~ "2/5", 
        parameter == "phi"~ "2/5", 
        parameter == "s"~ "0.2",
        parameter == "sK"~ "0.1",
        parameter == "sH"~ "0.1",
        parameter == "n"~ "0.01",
        parameter == "r"~ "0.03",
        parameter == "g"~ "0.02",
        parameter == "sE"~ "0.05",
        parameter == "X"~ "1",
        parameter == "delta"~ "0.15",
        TRUE ~ "NA")
    if(out == "NA"){
        warning(paste("Parameter translation for", parameter, "not yet created. Create it in pageCreationHelper_initval to continue."))
    }
    return(out)
}

pageCreationHelper_step <- function(parameter){
    out <- case_when(
        parameter == "B"~ "1", 
        parameter == "alpha"~ "0.05", 
        parameter == "beta"~ "0.05", 
        parameter == "kappa"~ "0.05", 
        parameter == "phi"~ "0.05", 
        parameter == "s"~ "0.05",
        parameter == "sK"~ "0.05",
        parameter == "sH"~ "0.05",
        parameter == "n"~ "0.01",
        parameter == "r"~ "0.01",
        parameter == "g"~ "0.01",
        parameter == "sE"~ "0.05",
        parameter == "X"~ "1",
        parameter == "delta"~ "0.05",
        TRUE ~ "NA")
    if(out == "NA"){
        warning(paste("Parameter translation for", parameter, "not yet created. Create it in pageCreationHelper_initval to continue."))
    }
    return(out)
}

pageCreationHelper_newval <- function(parameter){
    out <- case_when(
        parameter == "B"~ "3", 
        parameter == "alpha"~ "3/5", 
        parameter == "beta"~ "3/5", 
        parameter == "kappa"~ "3/5", 
        parameter == "phi"~ "3/5", 
        parameter == "s"~ "0.3",
        parameter == "sK"~ "0.2",
        parameter == "sH"~ "0.2",
        parameter == "n"~ "0.05",
        parameter == "r"~ "0.05",
        parameter == "g"~ "0.05",
        parameter == "sE"~ "0.1",
        parameter == "X"~ "3",
        parameter == "delta"~ "0.3",
        TRUE ~ "NA")
    if(out == "NA"){
        warning(paste("Parameter translation for", parameter, "not yet created. Create it in pageCreationHelper_initval to continue."))
    }
    return(out)
}
pageCreationHelper_fullname_of_intival_variable_abbreviation <- function(variable){
    out <- case_when(
        variable == "A" ~ "Total Factor Productivity",
        variable == "K" ~ "Physical Capital",
        variable == "L" ~ "Labor",
        variable == "H" ~ "Human Capital",
        variable == "R" ~ "Resource Stock (e.g. Oil)",
        variable == "V" ~ "National Wealth",
        TRUE ~ "NA")
    if(out == "NA"){
        warning(paste("Parameter translation for", parameter, "not yet created. Create it in pageCreationHelper_fullname_of_intival_variable_abbreviation to continue."))
    }
    return(out)
}

pageCreationHelper_paneltitle <- function(ModelCode) {
    out <- case_when(
        ModelCode == "BS" ~ "Basic Solow Model",
        ModelCode == "GS" ~ "General Solow Model",
        ModelCode == "ESSOE" ~ "Extended Solow Model (Small Open Economy)",
        ModelCode == "ESSRL" ~ "Extended Solow Model (Scarce Resource: Land)",
        ModelCode == "ESSRO" ~ "Extended Solow Model (Scarce Resource: Oil)",
        ModelCode == "ESSROL" ~ "Extended Solow Model (Scarce Resources: Oil and Land)",
        ModelCode == "ESHC" ~ "Extended Solow Model with Human Capital",
        TRUE ~ "NaN"
    )
    if (out == "NaN") {
        warning("The entered shortcode for a model variant does not exist.")
    }
    return(out)
}
pageCreationHelper_modelmath <- function(ModelCode) {
  path <- paste0("../ModelMath/", ModelCode, "ModelMath.Rmd")
  aux_modelmath <- readLines(path) %>% paste(collapse = " ")
  return(aux_modelmath)
}

createSingleParameterInterface <- function(parameternames, new_abbreviation){
    # this function creates the sidebar 
    code_template <- readLines("PartASnippet.R")
    for(aux_parameter in rev(parameternames)){
        aux_parameter_code <- code_template
        
        aux_parameter_code <- gsub(pattern = "ESHC", replace = new_abbreviation, x = aux_parameter_code)
        aux_parameter_code <- gsub(pattern = "phi", replace = partAhelper_1(aux_parameter), x = aux_parameter_code)
        aux_parameter_code <- gsub(pattern = "Phi", replace = partAhelper_2(aux_parameter), x = aux_parameter_code)
        aux_parameter_code <- gsub(pattern = "auxinitval", replace = pageCreationHelper_initval(aux_parameter), x = aux_parameter_code)
        aux_parameter_code <- gsub(pattern = "auxstep", replace = pageCreationHelper_step(aux_parameter), x = aux_parameter_code)
        aux_parameter_code <- gsub(pattern = "auxnewval", replace = pageCreationHelper_newval(aux_parameter), x = aux_parameter_code)
        line_number_to_write_to <- grep("ParameterCodeAutoFillLineIndexer", read_lines("TemplatePartA.R"))
        writeLines(c(read_lines("TemplatePartA.R", n_max = line_number_to_write_to), aux_parameter_code, read_lines("TemplatePartA.R", skip = line_number_to_write_to)), con="TemplatePartA.R")
        writeLines(gsub(pattern = "ESHC", replace = new_abbreviation, x = read_lines("TemplatePartA.R")), "TemplatePartA.R")
    }
}

createInitValInterface <- function(startingvariables, new_abbreviation, n_ModelComparison){
    for(i in rev(startingvariables)){
        aux_code <- paste('numericInput("', "ComparingModels", n_ModelComparison, "_", new_abbreviation, '_initval_', i, '", "Initial Value of auxfullname", 1),', sep = "")
        aux_code <- gsub("auxfullname", pageCreationHelper_fullname_of_intival_variable_abbreviation(i), x = aux_code)
        partBhelper(aux_code, "StartingValuesCodeAutoFillLineIndexer", "TemplatePartA.R")
    }
}
# 
createParameterInterface <- function(parameters, ModelCode, number){
    setwd("/Users/sebastianbehrens/Documents/GitHub/SolowVariants/TabCreation")
    system(paste0("mkdir ", "DynamicInterface", ModelCode))
    system(paste0("cp -R DynamicInterfaceTemplate/. ", "DynamicInterface", ModelCode, "/"))
    # Changing working directory to that newly created folder
    setwd(paste0("DynamicInterface",ModelCode))
    parameters <- getRequiredParams(aux_ModelCode)
    # ModelCode <- "BS"
    
    
    createSingleParameterInterface(parameters, ModelCode)
    createInitValInterface(getRequiredStartingValues(ModelCode), ModelCode, number)
    writeLines(gsub(pattern = "BS", replace = ModelCode, x = read_lines("TemplatePartA.R")), "TemplatePartA.R")
    if(number == 2){
        writeLines(gsub(pattern = "1", replace = "2", x = read_lines("TemplatePartA.R")), "TemplatePartA.R")
        
    }
    
    from_string <- "TemplatePartA.R"
    to_string <- paste0("../../DynamicInterfaces/Group", number, "/", ModelCode, "DynamicInterface.R")
    system(paste("mv ", from_string, to_string))
    
}
# aux_ModelCode <- "ESHC"
# createParameterInterface(getRequiredParams(aux_ModelCode), aux_ModelCode, 2)

# aux_ModelCode <- "ESHC"
# createParameterInterface(getRequiredParams(aux_ModelCode), aux_ModelCode, 2)

for(variant in c("ESSROL")){
  for(group in c(1,2)){
    createParameterInterface(getRequiredParams(variant), variant, group)
}
}

