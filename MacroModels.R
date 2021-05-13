# Loading Libraries =================================

# package_organiser <- function(string){
#   if(!require(string, character.only = TRUE)){
#   install.packages(string)
#   library(string, character.only = TRUE)
# }else{
#   library(string, character.only = TRUE)
# }
# }
# 


library(tidyverse)
library(shiny)
library(hexbin)
library(plotly)
library(shinythemes)
library(DT)
library(tidyverse)
library(modelr)
library(ggplot2) 
library(stargazer) 

# Plotting Setup =================================

theme_set(
  theme_classic() + 
    theme(
      axis.ticks.length = unit(-0.25, "cm"),
      axis.text.x = element_text(margin = unit(c(0.4,0,0,0), "cm")),
      axis.text.y = element_text(margin = unit(c(0,0.4,0,0), "cm")),
      axis.line = element_blank(),
      panel.grid.major.y = element_line(linetype = 2),
      plot.title = element_text(hjust = 0.5),
      text = element_text(family = "serif"),
      legend.justification = c("right", "top"),
      # legend.position = c(1, 1),
      legend.position = c(.98, .98),
      legend.background = element_rect(fill = NA, color = "black"),
      panel.border = element_rect(fill = NA, size = 1.25),
      strip.text = element_text(size = 12)
      # legend.margin = margin(6, 10, 6, 6)
      # legend.box.background = element_rect(colour = "black")
    )
  
)
# Reading Files =================================

# setwd("/Users/sebastianbehrens/Documents/GitHub/SolowVariants")
source("HelperFunctions.R")
source("BasicSolowModelSimulationFunction.R")

# Meta Information =================================
meta_BS_parameters <- c("TFP", "alpha", "delta", "savings rate", "population growth") # ac for available changes (referring to changes in parameters)

### Shiny APP #############################
shinyApp(
  # FrontEnd =================================
  ui = fluidPage(
    # Meta Settings for Frontend ---------------------------------
    theme = shinytheme("cerulean"),
    titlePanel("Growth Models in Macroeconomic Theory"),
    tabsetPanel(
      # Start Page ---------------------------------
      tabPanel("Start Page", fluid = TRUE,
               h3("This Shiny App aims to do the following:"),
               tags$ul(
                 tags$li("Present macroeconomic growth models in their simplest form"), 
                 tags$li("Present simulations"), 
                 tags$li("Make the models and their inner workers more visual")
               )
               ),
      # Basic Solow Model ---------------------------------
      tabPanel("Basic Solow Model", fluid = TRUE,
               sidebarLayout(
                 # Sidebar Panel  ---------------------------------
                 sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height: 90%;",
                              fluidRow(
                                column(width = 6,
                                       # Variable Selector ---------------------------------
                                       titlePanel("Variables"),
                                       checkboxGroupInput("BS_vtv", 
                                                          label = "",
                                                          choices = meta_BS_variables, 
                                                          selected = meta_BS_variables[1:5]),
                                       hr(),
                                       # Scale Selector ---------------------------------
                                       selectInput("scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                                       hr(),
                                       # Starting Values ---------------------------------
                                       titlePanel("Starting Values of Stocks"),
                                       numericInput("BS_initval_L", "Initial Value of Labor Stock", 10),
                                       numericInput("BS_initval_K", "Initial Value of Capital Stock", 10)
                                ),
                                column(width = 6,
                                       # Parameters ---------------------------------
                                       titlePanel("Parameter Values"),
                                       # Periods ---------------------------------
                                       numericInput("BS_nperiods_selected", "Periods", 200),
                                       hr(),
                                       # TFP ---------------------------------
                                       numericInput("BS_initval_B", "Initial Value of Technology", 5),
                                       checkboxInput("BS_changeinparam_tfp", "Change in TFP?"),
                                       conditionalPanel(
                                         condition = "input.BS_changeinparam_tfp == true", 
                                         numericInput("BS_pc_tfp_period", "Period of Change in TFP", 10, min = 0, max = 50),
                                         numericInput("BS_pc_tfp_newval", "New Value of TFP", 20)),
                                       hr(),
                                       # Alpha ---------------------------------
                                       numericInput("BS_initparam_alpha", "Alpha", 0.3),
                                       checkboxInput("BS_changeinparam_alpha", "Change in Alpha?"),
                                       conditionalPanel(
                                         condition = "input.BS_changeinparam_alpha == true", 
                                         numericInput("BS_pc_alpha_period", "Period of Change in Alpha", 10, min = 0, max = 50),
                                         numericInput("BS_pc_alpha_newval", "New Value of Alpha", 0.5)),
                                       hr(),
                                       # Delta ---------------------------------
                                       numericInput("BS_initparam_delta", "Delta", 0.1),
                                       checkboxInput("BS_changeinparam_delta", "Change in Delta?"),
                                       conditionalPanel(
                                         condition = "input.BS_changeinparam_delta == true", 
                                         numericInput("BS_pc_delta_period", "Period of Change in Delta", 10, min = 0, max = 50),
                                         numericInput("BS_pc_delta_newval", "New Value of Delta", 0.5)),
                                       hr(),
                                       # Savings Rate ---------------------------------
                                       numericInput("BS_initparam_savings", "Savings Rate", 0.1),
                                       checkboxInput("BS_changeinparam_savings", "Change in Savings Rate?"),
                                       conditionalPanel(
                                         condition = "input.BS_changeinparam_savings == true", 
                                         numericInput("BS_pc_savings_period", "Period of Change in Savings Rate", 10, min = 0, max = 50),
                                         numericInput("BS_pc_savings_newval", "New Value of Savings Rate", 0.5)),
                                       hr(),
                                       # Population Growth ---------------------------------
                                       numericInput("BS_initparam_popgrowth", "Population Growth", 0.1),
                                       checkboxInput("BS_changeinparam_popgrowth", "Change in Population Growth?"),
                                       conditionalPanel(
                                         condition = "input.BS_changeinparam_popgrowth == true", 
                                         numericInput("BS_pc_popgrowth_period", "Period of Change in Population Growth", 10, min = 0, max = 50),
                                         numericInput("BS_pc_popgrowth_newval", "New Value of Population Growth", 0.2)),
                                       hr()
                                )
                              )),
                 # Main Panel  ---------------------------------
               mainPanel(
                 # Model Equations  ---------------------------------
                 titlePanel("Model Equations"),
                 withMathJax(),
                 p('
               $$
\\begin{aligned}
Y_t &= BK_t^\\alpha L_t^{1-\\alpha} \\\\
r_t &= \\alpha B \\left(\\frac{K_t}{L_t}\\right)^{\\alpha -1}\\\\
w_t &= (1-\\alpha) \\left(\\frac{K_t}{L_t}\\right)^\\alpha \\\\
S_t &= sY_t \\\\
K_{t+1}&= sY_t + (1-\\delta)K_t \\\\
L_{t+1}&=(1+n)L_t
\\end{aligned}
$$'),
                 # Visualisation  ---------------------------------
                 # textOutput("test"),
                 titlePanel("Simulation"),
                 plotOutput("BS_Viz", height = "1000px"),
                 # Model Simulation Data ---------------------------------
                 titlePanel("Simulation Data"),
                 dataTableOutput("BS_Data")
               )  
               )
               ),
      # General Solow Model ---------------------------------
      tabPanel("General Solow Model", fluid = TRUE),
      # Extended Solow Model (Small Open Economy) ---------------------------------
      tabPanel("Extended Solow Model (Small Open Economy)", fluid = TRUE),
      # Extended Solow Model (Human Capital) ---------------------------------
      tabPanel("Extended Solow Model (Human Capital)", fluid = TRUE),
      # Extended Solow Model (Scarce Resources) ---------------------------------
      tabPanel("Extended Solow Model (Scarce Resources)", fluid = TRUE),
      # Extended Solow Model (Productive Externalities) ---------------------------------
      tabPanel("Extended Solow Model (Productive Externalities)", fluid = TRUE)
      )
    
      ), 
### Server #############################
  server = function(input, output, session) {
    # Basic Solow Growth Model =================================
    # Parameter Grid ---------------------------------
    
    BS_parametergrid <- reactive({
      # Names of Parameters ---------------------------------
      BS_parameternames <- c("B", "alpha", "delta", "n", "s")
      # Periods of Changes ---------------------------------
      BS_parameterchange_period <- c(if(input$BS_changeinparam_tfp) input$BS_pc_tfp_period else NA, 
                if(input$BS_changeinparam_alpha) input$BS_pc_alpha_period else NA,
                if(input$BS_changeinparam_delta) input$BS_pc_delta_period else NA, 
                if(input$BS_changeinparam_popgrowth) input$BS_pc_popgrowth_period else NA, 
                if(input$BS_changeinparam_savings) input$BS_pc_savings_period else NA)
      # Starting Values of Parameters ---------------------------------
      BS_parameterchange_valuebefore <- c(input$BS_initval_B,
                                  input$BS_initparam_alpha,
                                  input$BS_initparam_delta,
                                  input$BS_initparam_popgrowth,
                                  input$BS_initparam_savings
                                  )
      # Values of Parameters after Change ---------------------------------
      BS_parameterchange_valueafter <- c(if(input$BS_changeinparam_tfp) input$BS_pc_tfp_newval else NA,
               if(input$BS_changeinparam_alpha) input$BS_pc_alpha_newval else NA,
               if(input$BS_changeinparam_delta) input$BS_pc_delta_newval else NA, 
               if(input$BS_changeinparam_popgrowth) input$BS_pc_popgrowth_newval else NA,
               if(input$BS_changeinparam_savings) input$BS_pc_savings_newval else NA)
      # Creating the Grid ---------------------------------
      create_parameter_grid(
        BS_parameternames,
        BS_parameterchange_valuebefore,
        BS_parameterchange_period,
        BS_parameterchange_valueafter,
        input$BS_nperiods_selected
      )
      
      })
    
    BS_vtv_select_encoded <- reactive({
      variable_encoder(input$BS_vtv)
    })
    
    BS_vtv_processed_sim <- reactive({
      aux <- BS_vtv_processed_encoded()
      aux_non_standard_detect <- aux %in% c("L", "K", "Y")
      aux[!aux_non_standard_detect]
    })
    # output$test <- renderText({output$plot_height})
    
    BS_aux_data <- reactive({
      SimulateBasicSolowModel(BS_parametergrid(), input$BS_nperiods_selected,
                              list(K = input$BS_initval_K, L = input$BS_initval_K))
    })
    
    output$BS_Data <- renderDataTable({BS_aux_data() %>% mutate_all(round, digits = 3)})
    
    output$BS_Viz <- renderPlot({
    VisualiseSimulation(BS_aux_data(), BS_vtv_select_encoded(), input$scales_free_or_fixed)
      })

    # to be taken out when app is published
    session$onSessionEnded(stopApp)
  }
)
