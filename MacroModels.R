# Set Path
# setwd("/Users/sebastianbehrens/Documents/GitHub/SolowVariants")
# getwd()






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
library(R.utils)
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

source("HelperFunctions.R")
source("SimulationFunctions/BasicSolowModel.R")
source("SimulationFunctions/GeneralSolowModel.R")
source("SimulationFunctions/ExtendedSolowModelSOE.R")

# Meta Information =================================
meta_BS_parameters <- c("TFP", "alpha", "delta", "savings rate", "population growth") # ac for available changes (referring to changes in parameters)
meta_GS_parameters <- c("g", "alpha", "delta", "savings rate", "population growth")
meta_ESSOE_parameters <- c("TFP", "alpha", "delta", "savings rate", "population growth")
meta_ESHK_parameters <- c("alpha", "phi", "n", "g", "sK", "sH", "delta")
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
               ),
               p('This app is directly accompanying the book ', a(href = 'https://swisscovery.slsp.ch/discovery/fulldisplay?docid=alma991170526913405501&context=L&vid=41SLSP_NETWORK:VU1_UNION&lang=de&search_scope=DN_and_CI&adaptor=Local%20Search%20Engine&isFrbr=true&tab=41SLSP_NETWORK&query=any,contains,Introducing%20Advanced%20Macroeconomics:%20Growth%20and%20Business%20Cycles%20by%20Sorensen%20and%20Whitta-Jacobsen&sortby=date_d&facet=frbrgroupid,include,9040471419498156407&offset=0', 'Introducing Advanced Macroeconomics: Growth and Business Cycles by Sorensen and Whitta-Jacobsen', .noWS = "outside"), '.', .noWS = c("after-begin", "before-end"))
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
                                       selectInput("BS_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
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
                                       numericInput("BS_nperiods_selected", "Periods", 200, step = 20),
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
                                       numericInput("BS_initparam_alpha", "Alpha", 1/3, step = 0.05),
                                       checkboxInput("BS_changeinparam_alpha", "Change in Alpha?"),
                                       conditionalPanel(
                                         condition = "input.BS_changeinparam_alpha == true", 
                                         numericInput("BS_pc_alpha_period", "Period of Change in Alpha", 10, min = 0, max = 50),
                                         numericInput("BS_pc_alpha_newval", "New Value of Alpha", 0.5, step = 0.05)),
                                       hr(),
        # Delta ---------------------------------
                                       numericInput("BS_initparam_delta", "Delta", 0.1, step = 0.05),
                                       checkboxInput("BS_changeinparam_delta", "Change in Delta?"),
                                       conditionalPanel(
                                         condition = "input.BS_changeinparam_delta == true", 
                                         numericInput("BS_pc_delta_period", "Period of Change in Delta", 10, min = 0, max = 50),
                                         numericInput("BS_pc_delta_newval", "New Value of Delta", 0.5, step = 0.05)),
                                       hr(),
        # Savings Rate ---------------------------------
                                       numericInput("BS_initparam_savings", "Savings Rate", 0.22, step = 0.05),
                                       checkboxInput("BS_changeinparam_savings", "Change in Savings Rate?"),
                                       conditionalPanel(
                                         condition = "input.BS_changeinparam_savings == true", 
                                         numericInput("BS_pc_savings_period", "Period of Change in Savings Rate", 10, min = 0, max = 50),
                                         numericInput("BS_pc_savings_newval", "New Value of Savings Rate", 0.5, step = 0.05)),
                                       hr(),
        # Population Growth ---------------------------------
                                       numericInput("BS_initparam_popgrowth", "Population Growth", 0.005, step = 0.005),
                                       checkboxInput("BS_changeinparam_popgrowth", "Change in Population Growth?"),
                                       conditionalPanel(
                                         condition = "input.BS_changeinparam_popgrowth == true", 
                                         numericInput("BS_pc_popgrowth_period", "Period of Change in Population Growth", 10, min = 0, max = 50),
                                         numericInput("BS_pc_popgrowth_newval", "New Value of Population Growth", 0.2, step = 0.05)),
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
                 dataTableOutput("BS_Data"),
      # Correctness Checker ---------------------------------
      titlePanel("How does the simulation compare to the theoretic steady state values?"),
      dataTableOutput("BS_Correctness_Table")
               )  
               )
               ),
    # General Solow Model ---------------------------------
      tabPanel("General Solow Model", fluid = TRUE,
               sidebarLayout(
      # Sidebar Panel  ---------------------------------
                 sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height: 90%;",
                              fluidRow(
                                column(width = 6,
        # Variable Selector ---------------------------------
                                       titlePanel("Variables"),
                                       checkboxGroupInput("GS_vtv", 
                                                          label = "",
                                                          choices = meta_GS_variables, 
                                                          selected = meta_GS_variables[1:5]),
                                       hr(),
        # Scale Selector ---------------------------------
                                       selectInput("GS_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                                       hr(),
        # Starting Values ---------------------------------
                                       titlePanel("Starting Values of Stocks"),
                                       numericInput("GS_initval_L", "Initial Value of Labor Stock", 10),
                                       numericInput("GS_initval_K", "Initial Value of Capital Stock", 10),
                                       numericInput("GS_initval_A", "Initial Value of TFP", 10)
                                ),
                                column(width = 6,
        # Parameters ---------------------------------
                                       titlePanel("Parameter Values"),
        # Periods ---------------------------------
                                       numericInput("GS_nperiods_selected", "Periods", 200, step = 20),
                                       hr(),
        # TFP ---------------------------------
                                       numericInput("GS_initparam_g", "g", 0.1, step = 0.05),
        ## Remark: Exogeneous Shocks in GSM to be added
                                       checkboxInput("GS_changeinparam_g", "Change in g?"),
                                       conditionalPanel(
                                         condition = "input.GS_changeinparam_g == true",
                                         numericInput("GS_pc_g_period", "Period of Change in g", 10, min = 0, max = 50),
                                         numericInput("GS_pc_g_newval", "New Value of g", 0.3, step = 0.05)),
                                       hr(),
        # Alpha ---------------------------------
                                       numericInput("GS_initparam_alpha", "Alpha", 0.3, step = 0.05),
                                       checkboxInput("GS_changeinparam_alpha", "Change in Alpha?"),
                                       conditionalPanel(
                                         condition = "input.GS_changeinparam_alpha == true", 
                                         numericInput("GS_pc_alpha_period", "Period of Change in Alpha", 10, min = 0, max = 50),
                                         numericInput("GS_pc_alpha_newval", "New Value of Alpha", 0.5, step = 0.05)),
                                       hr(),
        # Delta ---------------------------------
                                       numericInput("GS_initparam_delta", "Delta", 0.1, step = 0.05),
                                       checkboxInput("GS_changeinparam_delta", "Change in Delta?"),
                                       conditionalPanel(
                                         condition = "input.GS_changeinparam_delta == true", 
                                         numericInput("GS_pc_delta_period", "Period of Change in Delta", 10, min = 0, max = 50),
                                         numericInput("GS_pc_delta_newval", "New Value of Delta", 0.5, step = 0.05)),
                                       hr(),
        # Savings Rate ---------------------------------
                                       numericInput("GS_initparam_savings", "Savings Rate", 0.1, step = 0.05),
                                       checkboxInput("GS_changeinparam_savings", "Change in Savings Rate?"),
                                       conditionalPanel(
                                         condition = "input.GS_changeinparam_savings == true", 
                                         numericInput("GS_pc_savings_period", "Period of Change in Savings Rate", 10, min = 0, max = 50),
                                         numericInput("GS_pc_savings_newval", "New Value of Savings Rate", 0.5, step = 0.05)),
                                       hr(),
        # Population Growth ---------------------------------
                                       numericInput("GS_initparam_popgrowth", "Population Growth", 0.1, step = 0.05),
                                       checkboxInput("GS_changeinparam_popgrowth", "Change in Population Growth?"),
                                       conditionalPanel(
                                         condition = "input.GS_changeinparam_popgrowth == true", 
                                         numericInput("GS_pc_popgrowth_period", "Period of Change in Population Growth", 10, min = 0, max = 50),
                                         numericInput("GS_pc_popgrowth_newval", "New Value of Population Growth", 0.2, step = 0.05)),
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
Y_t &= K_t^\\alpha (A_tL_t)^{1-\\alpha} \\\\
r_t &= \\alpha \\left(\\frac{K_t}{A_tL_t}\\right)^{\\alpha -1}\\\\
w_t &= (1-\\alpha) \\left(\\frac{K_t}{A_tL_t}\\right)^\\alpha A_t\\\\
S_t &= sY_t \\\\
K_{t+1}&= sY_t + (1-\\delta)K_t \\\\
L_{t+1}&=(1+n)L_t \\\\
A_{t+1} &= (1 + g)*A_t
\\end{aligned}
$$'),
        # Visualisation  ---------------------------------
                   # textOutput("test"),
                   titlePanel("Simulation"),
                   plotOutput("GS_Viz", height = "1000px"),
        # Model Simulation Data ---------------------------------
                   titlePanel("Simulation Data"),
                   dataTableOutput("GS_Data"),
        # Correctness Checker ---------------------------------
                  titlePanel("How does the simulation compare to the theoretic steady state values?"),
                  dataTableOutput("GS_Correctness_Table")
                 )  
               )
      ),
    # Extended Solow Model (Small Open Economy) ---------------------------------
      tabPanel("Extended Solow Model (Small Open Economy)", fluid = TRUE,
               sidebarLayout(
      # Sidebar Panel  ---------------------------------
                 sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height: 90%;",
                              fluidRow(
                                column(width = 6,
        # Variable Selector ---------------------------------
                                       titlePanel("Variables"),
                                       checkboxGroupInput("ESSOE_vtv", 
                                                          label = "",
                                                          choices = meta_ESSOE_variables, 
                                                          selected = meta_ESSOE_variables[1:5]),
                                       hr(),
        # Scale Selector ---------------------------------
                                       selectInput("ESSOE_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                                       hr(),
        # Starting Values ---------------------------------
                                       titlePanel("Starting Values of Stocks"),
                                       numericInput("ESSOE_initval_L", "Initial Value of Labor Stock", 10),
                                       numericInput("ESSOE_initval_V", "Initial Value of National Wealth", 45)
                                ),
                                column(width = 6,
        # Parameters ---------------------------------
                                       titlePanel("Parameter Values"),
        # Periods ---------------------------------
                                       numericInput("ESSOE_nperiods_selected", "Periods", 200, step = 20),
                                       hr(),
        # TFP ---------------------------------
                                       numericInput("ESSOE_initval_B", "Initial Value of Technology", 5),
                                       checkboxInput("ESSOE_changeinparam_tfp", "Change in TFP?"),
                                       conditionalPanel(
                                         condition = "input.ESSOE_changeinparam_tfp == true", 
                                         numericInput("ESSOE_pc_tfp_period", "Period of Change in TFP", 10, min = 0, max = 50),
                                         numericInput("ESSOE_pc_tfp_newval", "New Value of TFP", 20)),
                                       hr(),
        # Alpha ---------------------------------
                                       numericInput("ESSOE_initparam_alpha", "Alpha", 0.3, step = 0.05),
                                       checkboxInput("ESSOE_changeinparam_alpha", "Change in Alpha?"),
                                       conditionalPanel(
                                         condition = "input.ESSOE_changeinparam_alpha == true", 
                                         numericInput("ESSOE_pc_alpha_period", "Period of Change in Alpha", 10, min = 0, max = 50),
                                         numericInput("ESSOE_pc_alpha_newval", "New Value of Alpha", 0.5, step = 0.05)),
                                       hr(),
        # Real Interest Rate ---------------------------------
                                       numericInput("ESSOE_initparam_realint", "Real Interest Rate", 0.1, step = 0.05),
                                       checkboxInput("ESSOE_changeinparam_realint", "Change in the Real Interest Rate?"),
                                       conditionalPanel(
                                         condition = "input.ESSOE_changeinparam_realint == true", 
                                         numericInput("ESSOE_pc_realint_period", "Period of Change in the Real Interest Rate", 10, min = 0, max = 50),
                                         numericInput("ESSOE_pc_realint_newval", "New Value of the Real Interest Rate", 0.5, step = 0.05)),
                                       hr(),
        # Savings Rate ---------------------------------
                                       numericInput("ESSOE_initparam_savings", "Savings Rate", 0.1, step = 0.05),
                                       checkboxInput("ESSOE_changeinparam_savings", "Change in Savings Rate?"),
                                       conditionalPanel(
                                         condition = "input.ESSOE_changeinparam_savings == true", 
                                         numericInput("ESSOE_pc_savings_period", "Period of Change in Savings Rate", 10, min = 0, max = 50),
                                         numericInput("ESSOE_pc_savings_newval", "New Value of Savings Rate", 0.5, step = 0.05)),
                                       hr(),
        # Population Growth ---------------------------------
                                       numericInput("ESSOE_initparam_popgrowth", "Population Growth", 0.1, step = 0.05),
                                       checkboxInput("ESSOE_changeinparam_popgrowth", "Change in Population Growth?"),
                                       conditionalPanel(
                                         condition = "input.ESSOE_changeinparam_popgrowth == true", 
                                         numericInput("ESSOE_pc_popgrowth_period", "Period of Change in Population Growth", 10, min = 0, max = 50),
                                         numericInput("ESSOE_pc_popgrowth_newval", "New Value of Population Growth", 0.2, step = 0.05)),
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
Y_n &= Y_t + \\bar{r}F_t \\\\
V_t &= K_t + F_t\\\\
r_t &= \\alpha B \\left(\\frac{K_t}{L_t}\\right)^{\\alpha -1}\\\\
w_t &= (1-\\alpha) B \\left(\\frac{K_t}{L_t}\\right)^\\alpha \\\\
S_t &= sY_t \\\\
S_t &= V_{t+1} - V_t\\\\
L_{t+1}&=(1+n)L_t \\\\
\\end{aligned}$$'),
        # Visualisation  ---------------------------------
                 # textOutput("test"),
                 titlePanel("Simulation"),
                 plotOutput("ESSOE_Viz", height = "1000px"),
        # Model Simulation Data ---------------------------------
                 titlePanel("Simulation Data"),
                 dataTableOutput("ESSOE_Data"),
        # Correctness Checker ---------------------------------
      titlePanel("How does the simulation compare to the theoretic steady state values?"),
      dataTableOutput("ESSOE_Correctness_Table"),
      "Remark!\n",
      "The stability condition (for this to make sense), the following condition has to be fulfilled: s * r < n.",
      
      "\nFor more on this read IAM, page 103-104."
               )  
               )),
    # Extended Solow Model (Human Capital) ---------------------------------
      tabPanel("Extended Solow Model (Human Capital)", fluid = TRUE,
               # paste here
               ),
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
    VisualiseSimulation(BS_aux_data(), BS_vtv_select_encoded(), input$BS_scales_free_or_fixed)
      })
    
    BS_aux_correcttable <- reactive({
      simulation_correctness_checker(BS_aux_data()[nrow(BS_aux_data()), ],
                                     BS_parametergrid()[nrow(BS_parametergrid()), ],
                                               "BS")
    })
    output$BS_Correctness_Table <- renderDataTable({
      BS_aux_correcttable()
    })
    # General Solow Growth Model =================================
      # Parameter Grid ---------------------------------
    
    GS_parametergrid <- reactive({
        # Names of Parameters ---------------------------------
      GS_parameternames <- c("g", "alpha", "delta", "n", "s")
        # Periods of Changes ---------------------------------
      GS_parameterchange_period <- c(if(input$GS_changeinparam_g) input$GS_pc_g_period else NA, 
                                     if(input$GS_changeinparam_alpha) input$GS_pc_alpha_period else NA,
                                     if(input$GS_changeinparam_delta) input$GS_pc_delta_period else NA, 
                                     if(input$GS_changeinparam_popgrowth) input$GS_pc_popgrowth_period else NA, 
                                     if(input$GS_changeinparam_savings) input$GS_pc_savings_period else NA)
        # Starting Values of Parameters ---------------------------------
      GS_parameterchange_valuebefore <- c(input$GS_initparam_g,
                                          input$GS_initparam_alpha,
                                          input$GS_initparam_delta,
                                          input$GS_initparam_popgrowth,
                                          input$GS_initparam_savings
      )
        # Values of Parameters after Change ---------------------------------
      GS_parameterchange_valueafter <- c(if(input$GS_changeinparam_g) input$GS_pc_g_newval else NA,
                                         if(input$GS_changeinparam_alpha) input$GS_pc_alpha_newval else NA,
                                         if(input$GS_changeinparam_delta) input$GS_pc_delta_newval else NA, 
                                         if(input$GS_changeinparam_popgrowth) input$GS_pc_popgrowth_newval else NA,
                                         if(input$GS_changeinparam_savings) input$GS_pc_savings_newval else NA)
        # Creating the Grid ---------------------------------
      create_parameter_grid(
        GS_parameternames,
        GS_parameterchange_valuebefore,
        GS_parameterchange_period,
        GS_parameterchange_valueafter,
        input$GS_nperiods_selected
      )
      
    })
    
    GS_vtv_select_encoded <- reactive({
      variable_encoder(input$GS_vtv)
    })
    
    GS_vtv_processed_sim <- reactive({
      aux <- GS_vtv_processed_encoded()
      aux_non_standard_detect <- aux %in% c("L", "K", "Y", "TFP")
      aux[!aux_non_standard_detect]
    })
    # output$test <- renderText({output$plot_height})
    
    GS_aux_data <- reactive({
      SimulateGeneralSolowModel(GS_parametergrid(), input$GS_nperiods_selected,
                              list(K = input$GS_initval_K, L = input$GS_initval_K, A = input$GS_initval_A))
    })
    
    output$GS_Data <- renderDataTable({GS_aux_data() %>% mutate_all(round, digits = 3)})
    
    output$GS_Viz <- renderPlot({
      VisualiseSimulation(GS_aux_data(), GS_vtv_select_encoded(), input$GS_scales_free_or_fixed)
    })
    
    GS_aux_correcttable <- reactive({
      simulation_correctness_checker(GS_aux_data()[nrow(GS_aux_data()), ],
                                     GS_parametergrid()[nrow(GS_parametergrid()), ],
                                     "GS")
    })
    output$GS_Correctness_Table <- renderDataTable({
      GS_aux_correcttable()
    })
    # Extended Solow Growth Model — Small Open Economy =================================
    ESSOE_parametergrid <- reactive({
        # Names of Parameters ---------------------------------
      ESSOE_parameternames <- c("B", "alpha", "r", "n", "s")
        # Periods of Changes ---------------------------------
      ESSOE_parameterchange_period <- c(if(input$ESSOE_changeinparam_tfp) input$ESSOE_pc_tfp_period else NA, 
                if(input$ESSOE_changeinparam_alpha) input$ESSOE_pc_alpha_period else NA,
                if(input$ESSOE_changeinparam_realint) input$ESSOE_pc_realint_period else NA, 
                if(input$ESSOE_changeinparam_popgrowth) input$ESSOE_pc_popgrowth_period else NA, 
                if(input$ESSOE_changeinparam_savings) input$ESSOE_pc_savings_period else NA)
        # Starting Values of Parameters ---------------------------------
      ESSOE_parameterchange_valuebefore <- c(input$ESSOE_initval_B,
                                  input$ESSOE_initparam_alpha,
                                  input$ESSOE_initparam_realint,
                                  input$ESSOE_initparam_popgrowth,
                                  input$ESSOE_initparam_savings
                                  )
        # Values of Parameters after Change ---------------------------------
      ESSOE_parameterchange_valueafter <- c(if(input$ESSOE_changeinparam_tfp) input$ESSOE_pc_tfp_newval else NA,
               if(input$ESSOE_changeinparam_alpha) input$ESSOE_pc_alpha_newval else NA,
               if(input$ESSOE_changeinparam_realint) input$ESSOE_pc_realint_newval else NA, 
               if(input$ESSOE_changeinparam_popgrowth) input$ESSOE_pc_popgrowth_newval else NA,
               if(input$ESSOE_changeinparam_savings) input$ESSOE_pc_savings_newval else NA)
        # Creating the Grid ---------------------------------
      create_parameter_grid(
        ESSOE_parameternames,
        ESSOE_parameterchange_valuebefore,
        ESSOE_parameterchange_period,
        ESSOE_parameterchange_valueafter,
        input$ESSOE_nperiods_selected
      )
      
      })
    # Encoding the selected Variables (for use in visualise function) ---------------------------------
    ESSOE_vtv_select_encoded <- reactive({
      variable_encoder(input$ESSOE_vtv)
    })
    # unnecessary ---------------------------------
    ESSOE_vtv_processed_sim <- reactive({
      aux <- ESSOE_vtv_processed_encoded()
      aux_non_standard_detect <- aux %in% c("L", "K", "Y")
      aux[!aux_non_standard_detect]
    })
    # output$test <- renderText({output$plot_height})
    # Simulating the Economy ---------------------------------
    ESSOE_aux_data <- reactive({
      SimulateExtendedSolowModelSmallOpenEconomy(ESSOE_parametergrid(), input$ESSOE_nperiods_selected,
                              list(L = input$ESSOE_initval_L, V = input$ESSOE_initval_V))
    })
    # Rendering the Simulation as a table ---------------------------------
    output$ESSOE_Data <- renderDataTable({ESSOE_aux_data() %>% mutate_all(round, digits = 3)})
    # Visualising the Simulation (the selected variables respectively) ---------------------------------
    output$ESSOE_Viz <- renderPlot({
    VisualiseSimulation(ESSOE_aux_data(), ESSOE_vtv_select_encoded(), input$ESSOE_scales_free_or_fixed)
      })
    
    ESSOE_aux_correcttable <- reactive({
      simulation_correctness_checker(ESSOE_aux_data()[nrow(ESSOE_aux_data()), ],
                                     ESSOE_parametergrid()[nrow(ESSOE_parametergrid()), ],
                                     "ESSOE")
    })
    output$ESSOE_Correctness_Table <- renderDataTable({
      ESSOE_aux_correcttable()
    })
    
    
    
    
    
    
    
    
    # to be taken out when app is published
    session$onSessionEnded(stopApp)
  }
)
