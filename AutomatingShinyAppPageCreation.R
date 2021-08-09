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
setwd("AutomatingPageCreation")

string_for_new_folder <- "ESSRO"

# Creating new folder (copying template folder)
system(paste("mkdir", string_for_new_folder))
system(paste("cp -R Template/. ", string_for_new_folder, "/", sep = ""))
# Changing working directory to that newly created folder
setwd(paste(string_for_new_folder))
# A ---------------------------------
createpartA <- function(parameternames){
    for(aux_parameter in parameternames){
        # create sidebarentry
        # create grid - startval
        
        # create grid - change true or false
        # create grid - period of change
        # create grid - newval
        
        
    }
}

# D ---------------------------------
createpartD <- function(new_abbreviation, new_name_of_simulation_function){
    text  <- readLines("TemplatePartD.R")
    text_modified  <- gsub(pattern = "ESHC", replace = new_abbreviation, x = text)
    text_modified  <- gsub(pattern = "SimulateExtendedSolowModelHumanCapital", replace = new_name_of_simulation_function, x = text_modified)
    writeLines(text_modified, con="TemplatePartD.R")
}


createpartD("ESSRO", "SimulateExtendedSolowModelScarceResourceOil")




# End ---------------------------------
# Return to overheading directory
setwd("..")

