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



# A ---------------------------------
partAhelper_1 <- function(parameter){
    out <- case_when(
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
    out <- case_when(
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

createpartA <- function(parameternames, new_abbreviation, startvars){
        # this function creates the sidebar 
    code_template <- readLines("PartASnippet.R")
    for(aux_parameter in rev(parameternames)){
        aux_parameter_code <- code_template
        
        aux_parameter_code <- gsub(pattern = "ESHC", replace = new_abbreviation, x = aux_parameter_code)
        aux_parameter_code <- gsub(pattern = "phi", replace = partAhelper_1(aux_parameter), x = aux_parameter_code)
        aux_parameter_code <- gsub(pattern = "Phi", replace = partAhelper_2(aux_parameter), x = aux_parameter_code)
        
    line_number_to_write_to <- grep("ParameterCodeAutoFillLineIndexer", read_lines("TemplatePartA.R"))
    writeLines(c(read_lines("TemplatePartA.R", n_max = line_number_to_write_to), aux_parameter_code, read_lines("TemplatePartA.R", skip = line_number_to_write_to)), con="TemplatePartA.R")
    writeLines(gsub(pattern = "ESHC", replace = new_abbreviation, x = read_lines("TemplatePartA.R")), "TemplatePartA.R")
    }
    createpartE(startvars, new_abbreviation)
}
# createpartA(c("g", "n"), "ESSRO")

# B ---------------------------------
createpartB <- function(parameternames, new_abbreviation){
    code_template <- readLines("PartBSnippet.R")
    
    for(aux_parameter in rev(parameternames)){
        # parameternames <- c("g", "n")
        aux_template <- code_template
        aux_template <- gsub(pattern = "BS", replace = new_abbreviation, x = aux_template)
        aux_template <- gsub(pattern = "tfp", replace = partAhelper_1(aux_parameter), x = aux_template)
        
        partBhelper(aux_template[1], "auxspot1", "TemplatePartB.R")
        partBhelper(aux_template[2], "auxspot2", "TemplatePartB.R")
        partBhelper(aux_template[3], "auxspot3", "TemplatePartB.R")
    }
    writeLines(gsub(pattern = "BS", replace = new_abbreviation, x = read_lines("TemplatePartB.R")), "TemplatePartB.R")
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
createpartC <- function(starting_variables, new_abbreviation){
    for(var in starting_variables){
        aux_code <- paste(var, " = input$ESSOE_initval_", var, ",", sep = "")
        aux_code <- gsub("ESSOE", new_abbreviation, x = aux_code)
        partBhelper(aux_code, "auxspot1", "TemplatePartC.R")
    }
}
# createpartC(c("K", "L"), "ESHC")

# D ---------------------------------
createpartD <- function(new_abbreviation, new_name_of_simulation_function){
    text  <- readLines("TemplatePartD.R")
    text_modified  <- gsub(pattern = "ESHC", replace = new_abbreviation, x = text)
    text_modified  <- gsub(pattern = "SimulateExtendedSolowModelHumanCapital", replace = new_name_of_simulation_function, x = text_modified)
    writeLines(text_modified, con="TemplatePartD.R")
}


# createpartD("ESSRO", "SimulateExtendedSolowModelScarceResourceOil")
# E ---------------------------------
createpartE <- function(startingvariables, new_abbreviation){
    for(i in rev(startingvariables)){
        aux_code <- paste('numericInput("', new_abbreviation, '_initval_', i, '", "Initial Value of _____________", 5),', sep = "")
        partBhelper(aux_code, "StartingValuesCodeAutoFillLineIndexer", "TemplatePartA.R")
    }
}

# Create it all ---------------------------------
augmentShinyApp <- function(parameters, abbreviation, name_of_sim_function, startvars){
    setwd("/Users/sebastianbehrens/Documents/GitHub/SolowVariants/AutomatingPageCreation")
    system(paste("mkdir", abbreviation))
    system(paste("cp -R Template/. ", abbreviation, "/", sep = ""))
    # Changing working directory to that newly created folder
    setwd(paste(abbreviation))
    
    createpartA(parameters, abbreviation, startvars)
    createpartB(parameters, abbreviation)
    createpartC(startvars, abbreviation)
    createpartD(abbreviation, name_of_sim_function)
    for(i in c(LETTERS[1:4])){
        aux_file <- readLines("TemplatePartX.R" %>% str_replace("X", i))
        write(paste("##########"), file = "CollectionOfSnippets.R", append = T)
        write(paste("          ", "Part:", i), file = "CollectionOfSnippets.R", append = T)
        write(paste("##########"), file = "CollectionOfSnippets.R", append = T)
        write(aux_file, file = "CollectionOfSnippets.R", append = T)
    }
    file.rename("CollectionOfSnippets.R", paste(abbreviation, "CollectionOfSnippets.R", sep = ""))
    
}
# augmentShinyApp(c("g", "n", "sK"), "ESSMY", "my_custom_simulation_function", c("A", "K", "L"))
augmentShinyApp(c("alpha", "beta", "n", "g", "sE", "s", "delta"), 
                "ESSRO", 
                "SimulateExtendedSolowModelScarceResourceOil", 
                c("A", "K", "L", "R"))

# End ---------------------------------
# Return to overheading directory
setwd("..")

