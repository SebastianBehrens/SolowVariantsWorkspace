##########
           Part: A
##########
tabPanel("panetitle", fluid = TRUE, sidebarLayout(
    # Sidebar Panel  ---------------------------------
    sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height: 90%;",
                 fluidRow(
                     column(width = 6,
                            # Variable Selector ---------------------------------
                            titlePanel("Variables"),
                            checkboxGroupInput("ESSRL_vtv", 
                                               label = "",
                                               choices = meta_ESSRL_variables, 
                                               selected = meta_ESSRL_variables[1:5]),
                            hr(),
                            # Scale Selector ---------------------------------
                            selectInput("ESSRL_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                            hr(),
                            # Starting Values ---------------------------------
                            titlePanel("Starting Values of Stocks"),
                            # StartingValuesCodeAutoFillLineIndexer
numericInput("ESSRL_initval_A", "Initial Value of _____________", 5),
numericInput("ESSRL_initval_K", "Initial Value of _____________", 5),
numericInput("ESSRL_initval_L", "Initial Value of _____________", 5),
                     ),
                     column(width = 6,
                            # Parameters ---------------------------------
                            titlePanel("Parameter Values"),
                            # Periods ---------------------------------
                            numericInput("ESSRL_nperiods_selected", "Periods", 200, step = 20),
                            hr(),
                            # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ESSRL_initparam_alpha", "Alpha", 0.3, step = 0.05),
checkboxInput("ESSRL_changeinparam_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ESSRL_changeinparam_alpha == true", 
    numericInput("ESSRL_pc_alpha_period", "Period of Change in Alpha", 10, min = 0, max = 50),
    numericInput("ESSRL_pc_alpha_newval", "New Value of Alpha", 0.4, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRL_initparam_beta", "Beta", 0.3, step = 0.05),
checkboxInput("ESSRL_changeinparam_beta", "Change in Beta?"),
conditionalPanel(
    condition = "input.ESSRL_changeinparam_beta == true", 
    numericInput("ESSRL_pc_beta_period", "Period of Change in Beta", 10, min = 0, max = 50),
    numericInput("ESSRL_pc_beta_newval", "New Value of Beta", 0.4, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRL_initparam_kappa", "Kappa", 0.3, step = 0.05),
checkboxInput("ESSRL_changeinparam_kappa", "Change in Kappa?"),
conditionalPanel(
    condition = "input.ESSRL_changeinparam_kappa == true", 
    numericInput("ESSRL_pc_kappa_period", "Period of Change in Kappa", 10, min = 0, max = 50),
    numericInput("ESSRL_pc_kappa_newval", "New Value of Kappa", 0.4, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRL_initparam_delta", "Delta", 0.3, step = 0.05),
checkboxInput("ESSRL_changeinparam_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.ESSRL_changeinparam_delta == true", 
    numericInput("ESSRL_pc_delta_period", "Period of Change in Delta", 10, min = 0, max = 50),
    numericInput("ESSRL_pc_delta_newval", "New Value of Delta", 0.4, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRL_initparam_popgrowth", "Population Growth", 0.3, step = 0.05),
checkboxInput("ESSRL_changeinparam_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ESSRL_changeinparam_popgrowth == true", 
    numericInput("ESSRL_pc_popgrowth_period", "Period of Change in Population Growth", 10, min = 0, max = 50),
    numericInput("ESSRL_pc_popgrowth_newval", "New Value of Population Growth", 0.4, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRL_initparam_savings", "Savings Rate", 0.3, step = 0.05),
checkboxInput("ESSRL_changeinparam_savings", "Change in Savings Rate?"),
conditionalPanel(
    condition = "input.ESSRL_changeinparam_savings == true", 
    numericInput("ESSRL_pc_savings_period", "Period of Change in Savings Rate", 10, min = 0, max = 50),
    numericInput("ESSRL_pc_savings_newval", "New Value of Savings Rate", 0.4, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRL_initparam_tfpgrowth", "TFP Growth", 0.3, step = 0.05),
checkboxInput("ESSRL_changeinparam_tfpgrowth", "Change in TFP Growth?"),
conditionalPanel(
    condition = "input.ESSRL_changeinparam_tfpgrowth == true", 
    numericInput("ESSRL_pc_tfpgrowth_period", "Period of Change in TFP Growth", 10, min = 0, max = 50),
    numericInput("ESSRL_pc_tfpgrowth_newval", "New Value of TFP Growth", 0.4, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRL_initparam_land", "Land", 0.3, step = 0.05),
checkboxInput("ESSRL_changeinparam_land", "Change in Land?"),
conditionalPanel(
    condition = "input.ESSRL_changeinparam_land == true", 
    numericInput("ESSRL_pc_land_period", "Period of Change in Land", 10, min = 0, max = 50),
    numericInput("ESSRL_pc_land_newval", "New Value of Land", 0.4, step = 0.05)),
hr()
                     )
                 )),
    # Main Panel  ---------------------------------
    mainPanel(
        # Model Equations  ---------------------------------
        titlePanel("Model Equations"),
        withMathJax(),
# insert math here        
        p('insertmathhere'),
        # Visualisation  ---------------------------------
        # textOutput("test"),
        titlePanel("Simulation"),
        plotOutput("ESSRL_Viz", height = "1000px"),
        # Model Simulation Data ---------------------------------
        titlePanel("Simulation Data"),
        dataTableOutput("ESSRL_Data"),
        # Correctness Checker ---------------------------------
        titlePanel("How does the simulation compare to the theoretic steady state values?"),
        dataTableOutput("ESSRL_Correctness_Table")
    )  
)),
##########
           Part: B
##########
ESSRL_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESSRL_parameternames <- # replace on own — vector of parameters belong here (as supplied to the createpartb function)
  # Periods of Changes ---------------------------------
  ESSRL_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$ESSRL_changeinparam_alpha) input$ESSRL_pc_alpha_period else NA, 
if(input$ESSRL_changeinparam_beta) input$ESSRL_pc_beta_period else NA, 
if(input$ESSRL_changeinparam_kappa) input$ESSRL_pc_kappa_period else NA, 
if(input$ESSRL_changeinparam_delta) input$ESSRL_pc_delta_period else NA, 
if(input$ESSRL_changeinparam_popgrowth) input$ESSRL_pc_popgrowth_period else NA, 
if(input$ESSRL_changeinparam_savings) input$ESSRL_pc_savings_period else NA, 
if(input$ESSRL_changeinparam_tfpgrowth) input$ESSRL_pc_tfpgrowth_period else NA, 
if(input$ESSRL_changeinparam_land) input$ESSRL_pc_land_period else NA
    )
  # Starting Values of Parameters ---------------------------------
  ESSRL_parameterchange_valuebefore <- c(
    # auxspot2
input$ESSRL_initparam_alpha,
input$ESSRL_initparam_beta,
input$ESSRL_initparam_kappa,
input$ESSRL_initparam_delta,
input$ESSRL_initparam_popgrowth,
input$ESSRL_initparam_savings,
input$ESSRL_initparam_tfpgrowth,
input$ESSRL_initparam_land
  )
  # Values of Parameters after Change ---------------------------------
  ESSRL_parameterchange_valueafter <- c(
    # auxspot3
if(input$ESSRL_changeinparam_alpha) input$ESSRL_pc_alpha_newval else NA,
if(input$ESSRL_changeinparam_beta) input$ESSRL_pc_beta_newval else NA,
if(input$ESSRL_changeinparam_kappa) input$ESSRL_pc_kappa_newval else NA,
if(input$ESSRL_changeinparam_delta) input$ESSRL_pc_delta_newval else NA,
if(input$ESSRL_changeinparam_popgrowth) input$ESSRL_pc_popgrowth_newval else NA,
if(input$ESSRL_changeinparam_savings) input$ESSRL_pc_savings_newval else NA,
if(input$ESSRL_changeinparam_tfpgrowth) input$ESSRL_pc_tfpgrowth_newval else NA,
if(input$ESSRL_changeinparam_land) input$ESSRL_pc_land_newval else NA
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    ESSRL_parameternames,
    ESSRL_parameterchange_valuebefore,
    ESSRL_parameterchange_period,
    ESSRL_parameterchange_valueafter,
    input$ESSRL_nperiods_selected
  )
  
})
##########
           Part: C
##########
list(
  #auxspot1
L = input$ESSRL_initval_L,
K = input$ESSRL_initval_K,
A = input$ESSRL_initval_A
)
##########
           Part: D
##########
ESSRL_vtv_select_encoded <- reactive({
  variable_encoder(input$ESSRL_vtv)
})

ESSRL_aux_data <- reactive({
    SimulateExtendedSolowModelScarceResourceLand(ESSRL_parametergrid(), input$ESSRL_nperiods_selected,
                                                 list(
                                                   #auxspot1
                                                   L = input$ESSRL_initval_L,
                                                   K = input$ESSRL_initval_K,
                                                   A = input$ESSRL_initval_A
                                                 ))
})

output$ESSRL_Data <- renderDataTable({ESSRL_aux_data() %>% mutate_all(round, digits = 3)})

output$ESSRL_Viz <- renderPlot({
    VisualiseSimulation(ESSRL_aux_data(), ESSRL_vtv_select_encoded(), input$ESSRL_scales_free_or_fixed)
})

ESSRL_aux_correcttable <- reactive({
    simulation_correctness_checker(ESSRL_aux_data()[nrow(ESSRL_aux_data()), ],
                                   ESSRL_parametergrid()[nrow(ESSRL_parametergrid()), ],
                                   "ESSRL")
})
output$ESSRL_Correctness_Table <- renderDataTable({
    ESSRL_aux_correcttable()
})
