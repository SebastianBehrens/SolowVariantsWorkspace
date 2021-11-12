## Setup =================================
# Clean Start ---------------------------------
# rm(list = ls())

# Set Path
setwd("/Users/sebastianbehrens/Documents/GitHub/SolowVariantsWorkspace")
# getwd()

####################################
# Remark: simulation_correctness checker underwent a change in setup! Change the function calls to incorporate the SolowVariant package as published on github.
####################################



# Loading Libraries ---------------------------------

# temporarily abandoned package managing function

# detach_package <- function(pkg, character.only = FALSE)
# {
#   if(!character.only)
#   {
#     pkg <- deparse(substitute(pkg))
#   }
#   search_item <- paste("package", pkg, sep = ":")
#   while(search_item %in% search())
#   {
#     detach(search_item, unload = TRUE, character.only = TRUE)
#   }
# }

# detach_package("broom", TRUE)
# broom::augment()
# package_organiser("broom")


# package_organiser <- function(string){
#   if(!require(string, character.only = TRUE)){
#   install.packages(string)
#   library(string, character.only = TRUE)
# }else{
#   library(string, character.only = TRUE)
# }
# }
# #


library(SolowVariants)
library(tidyverse)
library(shiny)
library(hexbin)
library(plotly)
library(shinythemes)
library(DT)
# library(tidyverse)
# library(modelr)
# library(ggplot2)
# library(stargazer)
# library(R.utils)
# library(reactlog)
# reactlog_enable()




# ggplot2 Setup ---------------------------------
set_default_theme()

# Sourcing Simulation Functions and Helper Functions ---------------------------------
source("CompareModels.R")
source("AdditionalHelperFunctions.R")

# Essential Sourcing Function ---------------------------------
source("ShinyAppSourcer.R")

# Shiny App =================================
shinyApp(
  ui = fluidPage(
    # tags$head(
    #   tags$style(
    #     "#inTabset {
    #     position: fixed;
    #     width: 100%;
    #     background-color: white;
    #     top: 0;
    #     }",
    #     ".tab-content  {
    #     margin-top: 80px;
    #   }"
    #   )
    # ),
    theme = shinytheme("cerulean"),
    titlePanel("Solow Growth Models in Macroeconomic Theory"),
    # Loading Tabs ---------------------------------
    tabsetPanel(type = "pills",
                # id = "inTabset",
      getShinyPart("T", "StartPage"),
      getShinyPart("T", "BS"),
      getShinyPart("T", "GS"),
      getShinyPart("T", "ESSOE"),
      getShinyPart("T", "ESHC"),
      getShinyPart("T", "ESSRO"),
      getShinyPart("T", "ESSRL"),
      getShinyPart("T", "ESSROL"),
      getShinyPart("T", "ESEG"),
      getShinyPart("T", "ESEGRomer"),
      getShinyPart("T", "ESEGCozziOne"),
      # getShinyPart("T", "ESEGCozziTwo"),
      getShinyPart("T", "Comparison")
    )
  ),
  server = function(input, output, session) {
    # getShinyPart("S", "BS")
    source("ServerParts/BSServer.R", local = TRUE)
    source("ServerParts/GSServer.R", local = TRUE)
    source("ServerParts/ESSOEServer.R", local = TRUE)
    source("ServerParts/ESHCServer.R", local = TRUE)
    source("ServerParts/ESSROServer.R", local = TRUE)
    source("ServerParts/ESSRLServer.R", local = TRUE)
    source("ServerParts/ESSROLServer.R", local = TRUE)
    source("ServerParts/ESEGServer.R", local = TRUE)
    source("ServerParts/ESEGRomerServer.R", local = TRUE)
    source("ServerParts/ESEGCozziOneServer.R", local = TRUE)
    # source("ServerParts/ESEGCozziTwoServer.R", local = TRUE)
    source("ServerParts/ComparisonServer.R", local = TRUE)

    # to be taken out when app is published
    session$onSessionEnded(stopApp)
  }
)

