library(shiny)
# install.packages("shinythemes")
library(plotly)
library(shinythemes)
library(DT)
# install.packages("DT")
# install.packages("MathJax")
#library()

# Plotting Setup =================================
library(tidyverse)
library(modelr)
library(ggplot2) 
library(stargazer) 

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
# Reading in Functions =================================
# getwd()
setwd("/Users/sebastianbehrens/Documents/GitHub/SolowVariants")
source("RawModelFunction.R")

# Selection Options =================================
# Basic Solow Model ---------------------------------
meta_BS_vtv <- c("Capital Stock", "Labor Stock", "Wage Rate", "Rental Rate", "Output")
meta_BS_ac <- c("TFP", "alpha", "delta", "savings rate", "population growth") # ac for available changes (referring to changes in parameters)

# Shiny App =================================
shinyApp(
  # FrontEnd =================================
  ui = fluidPage(
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
                 sidebarPanel(width = 2,
                              titlePanel("Variables"),
                              checkboxGroupInput("BS_vtv", 
                                                 label = "",
                                                 choices = meta_BS_vtv, 
                                                 selected = meta_BS_vtv),
                              
                              titlePanel("Starting Values of Stocks"),
                              numericInput("BS_initval_L", "Initial Value of Labor Stock", 10),
                              numericInput("BS_initval_K", "Initial Value of Capital Stock", 10),
                              
                              titlePanel("Parameter Values"),
                              # Periods ---------------------------------
                              numericInput("BS_initparam_periods", "Periods", 200),
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
                              ),
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
                 titlePanel("Simulation"),
                 plotOutput("BS_Viz"),
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
  # Server =================================
  server = function(input, output) {
    # Conditions for changes in Parameters ---------------------------------
    
    # Simulation of Basic Solow Model ---------------------------------
    # Presimsteps regarding parameter change ---------------------------------
    
    testgrid <- reactive({
      parameternames <- c("B", "alpha", "delta", "n", "s")
      
      pfcl <- c(if(input$BS_changeinparam_tfp) input$BS_pc_tfp_period else NA, 
                if(input$BS_changeinparam_alpha) input$BS_pc_alpha_period else NA,
                if(input$BS_changeinparam_delta) input$BS_pc_delta_period else NA, 
                if(input$BS_changeinparam_popgrowth) input$BS_pc_popgrowth_period else NA, 
                if(input$BS_changeinparam_savings) input$BS_pc_savings_period else NA)
      initialparametervalues <- c(input$BS_initval_B,
                                  input$BS_initparam_alpha,
                                  input$BS_initparam_delta,
                                  input$BS_initparam_popgrowth,
                                  input$BS_initparam_savings
                                  )
      nvl <- c(if(input$BS_changeinparam_tfp) input$BS_pc_tfp_newval else NA,
               if(input$BS_changeinparam_alpha) input$BS_pc_alpha_newval else NA,
               if(input$BS_changeinparam_delta) input$BS_pc_delta_newval else NA, 
               if(input$BS_changeinparam_popgrowth) input$BS_pc_popgrowth_newval else NA,
               if(input$BS_changeinparam_savings) input$BS_pc_savings_newval else NA)
      create_parameter_grid(
        parameternames,
        initialparametervalues,
        pfcl,
        nvl,
        input$BS_initparam_periods
      )
      
      })
    
    
    BS_aux_data <- reactive({
      SimulateBasicSolowModel(testgrid(), input$BS_initparam_periods, c(), 
                              list(K = input$BS_initval_K, L = input$BS_initval_K))
    })
    
    output$BS_Data <- renderDataTable({BS_aux_data() %>% mutate_all(round, digits = 3)})
    BS_vtv_processed <- reactive({
      case_when(
        input$BS_vtv == "Capital Stock" ~ "K",
        input$BS_vtv == "Labor Stock" ~ "L",
        input$BS_vtv == "Wage Rate" ~ "WR", 
        input$BS_vtv == "Rental Rate" ~ "RR",
        input$BS_vtv == "Output" ~ "Y"
                )
    })
    output$BS_Viz <- renderPlot({VisualiseSimulation(BS_aux_data(), BS_vtv_processed())})
    
    
    
    
  }
)
