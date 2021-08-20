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
                            checkboxGroupInput("ESSRO_vtv", 
                                               label = "",
                                               choices = meta_ESSRO_variables, 
                                               selected = meta_ESSRO_variables[1:5]),
                            hr(),
                            # Scale Selector ---------------------------------
                            selectInput("ESSRO_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                            hr(),
                            # Starting Values ---------------------------------
                            titlePanel("Starting Values of Stocks"),
                            # StartingValuesCodeAutoFillLineIndexer
numericInput("ESSRO_initval_A", "Initial Value of _____________", 5),
numericInput("ESSRO_initval_K", "Initial Value of _____________", 5),
numericInput("ESSRO_initval_L", "Initial Value of _____________", 5),
numericInput("ESSRO_initval_R", "Initial Value of _____________", 5),
                     ),
                     column(width = 6,
                            # Parameters ---------------------------------
                            titlePanel("Parameter Values"),
                            # Periods ---------------------------------
                            numericInput("ESSRO_nperiods_selected", "Periods", 200, step = 20),
                            hr(),
                            # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_alpha", "Alpha", 0.3, step = 0.05),
checkboxInput("ESSRO_changeinparam_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_alpha == true", 
    numericInput("ESSRO_pc_alpha_period", "Period of Change in Alpha", 10, min = 0, max = 50),
    numericInput("ESSRO_pc_alpha_newval", "New Value of Alpha", 0.4, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_beta", "Beta", 0.3, step = 0.05),
checkboxInput("ESSRO_changeinparam_beta", "Change in Beta?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_beta == true", 
    numericInput("ESSRO_pc_beta_period", "Period of Change in Beta", 10, min = 0, max = 50),
    numericInput("ESSRO_pc_beta_newval", "New Value of Beta", 0.4, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_popgrowth", "Population Growth", 0.3, step = 0.05),
checkboxInput("ESSRO_changeinparam_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_popgrowth == true", 
    numericInput("ESSRO_pc_popgrowth_period", "Period of Change in Population Growth", 10, min = 0, max = 50),
    numericInput("ESSRO_pc_popgrowth_newval", "New Value of Population Growth", 0.4, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_tfpgrowth", "TFP Growth", 0.3, step = 0.05),
checkboxInput("ESSRO_changeinparam_tfpgrowth", "Change in TFP Growth?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_tfpgrowth == true", 
    numericInput("ESSRO_pc_tfpgrowth_period", "Period of Change in TFP Growth", 10, min = 0, max = 50),
    numericInput("ESSRO_pc_tfpgrowth_newval", "New Value of TFP Growth", 0.4, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_energyconsumption", "Energy Consupmtion", 0.3, step = 0.05),
checkboxInput("ESSRO_changeinparam_energyconsumption", "Change in Energy Consupmtion?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_energyconsumption == true", 
    numericInput("ESSRO_pc_energyconsumption_period", "Period of Change in Energy Consupmtion", 10, min = 0, max = 50),
    numericInput("ESSRO_pc_energyconsumption_newval", "New Value of Energy Consupmtion", 0.4, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_savings", "Savings Rate", 0.3, step = 0.05),
checkboxInput("ESSRO_changeinparam_savings", "Change in Savings Rate?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_savings == true", 
    numericInput("ESSRO_pc_savings_period", "Period of Change in Savings Rate", 10, min = 0, max = 50),
    numericInput("ESSRO_pc_savings_newval", "New Value of Savings Rate", 0.4, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_delta", "Delta", 0.3, step = 0.05),
checkboxInput("ESSRO_changeinparam_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_delta == true", 
    numericInput("ESSRO_pc_delta_period", "Period of Change in Delta", 10, min = 0, max = 50),
    numericInput("ESSRO_pc_delta_newval", "New Value of Delta", 0.4, step = 0.05)),
hr(),



                            
                            # removecomma
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
        plotOutput("ESSRO_Viz", height = "1000px"),
        # Model Simulation Data ---------------------------------
        titlePanel("Simulation Data"),
        dataTableOutput("ESSRO_Data"),
        # Correctness Checker ---------------------------------
        titlePanel("How does the simulation compare to the theoretic steady state values?"),
        dataTableOutput("ESSRO_Correctness_Table")
    )  
)),
##########
           Part: B
##########
ESSRO_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESSRO_parameternames <- # replace on own — vector of parameters belong here (as supplied to the createpartb function)
  # Periods of Changes ---------------------------------
  ESSRO_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$ESSRO_changeinparam_alpha) input$ESSRO_pc_alpha_period else NA, 
if(input$ESSRO_changeinparam_beta) input$ESSRO_pc_beta_period else NA, 
if(input$ESSRO_changeinparam_popgrowth) input$ESSRO_pc_popgrowth_period else NA, 
if(input$ESSRO_changeinparam_tfpgrowth) input$ESSRO_pc_tfpgrowth_period else NA, 
if(input$ESSRO_changeinparam_energyconsumption) input$ESSRO_pc_energyconsumption_period else NA, 
if(input$ESSRO_changeinparam_savings) input$ESSRO_pc_savings_period else NA, 
if(input$ESSRO_changeinparam_delta) input$ESSRO_pc_delta_period else NA, 
    # removecomma
    )
  # Starting Values of Parameters ---------------------------------
  ESSRO_parameterchange_valuebefore <- c(
    # auxspot2
input$ESSRO_initval_alpha,
input$ESSRO_initval_beta,
input$ESSRO_initval_popgrowth,
input$ESSRO_initval_tfpgrowth,
input$ESSRO_initval_energyconsumption,
input$ESSRO_initval_savings,
input$ESSRO_initval_delta,
    # removecomma
  )
  # Values of Parameters after Change ---------------------------------
  ESSRO_parameterchange_valueafter <- c(
    # auxspot3
if(input$ESSRO_changeinparam_alpha) input$ESSRO_pc_alpha_newval else NA,
if(input$ESSRO_changeinparam_beta) input$ESSRO_pc_beta_newval else NA,
if(input$ESSRO_changeinparam_popgrowth) input$ESSRO_pc_popgrowth_newval else NA,
if(input$ESSRO_changeinparam_tfpgrowth) input$ESSRO_pc_tfpgrowth_newval else NA,
if(input$ESSRO_changeinparam_energyconsumption) input$ESSRO_pc_energyconsumption_newval else NA,
if(input$ESSRO_changeinparam_savings) input$ESSRO_pc_savings_newval else NA,
if(input$ESSRO_changeinparam_delta) input$ESSRO_pc_delta_newval else NA,
    # removecomma
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    ESSRO_parameternames,
    ESSRO_parameterchange_valuebefore,
    ESSRO_parameterchange_period,
    ESSRO_parameterchange_valueafter,
    input$ESSRO_nperiods_selected
  )
  
})
##########
           Part: C
##########
list(
  #auxspot1
R = input$ESSRO_initval_R,
L = input$ESSRO_initval_L,
K = input$ESSRO_initval_K,
A = input$ESSRO_initval_A,
  # removecomma
)
##########
           Part: D
##########
ESSRO_vtv_select_encoded <- reactive({
  variable_encoder(input$ESSRO_vtv)
})

ESSRO_aux_data <- reactive({
    SimulateExtendedSolowModelScarceResourceOil(ESSRO_parametergrid(), input$ESSRO_nperiods_selected,
                                           list(K = input$ESSRO_initval_K, L = input$ESSRO_initval_K, A = input$ESSRO_initval_A, H = input$ESSRO_initval_H))
})

output$ESSRO_Data <- renderDataTable({ESSRO_aux_data() %>% mutate_all(round, digits = 3)})

output$ESSRO_Viz <- renderPlot({
    VisualiseSimulation(ESSRO_aux_data(), ESSRO_vtv_select_encoded(), input$ESSRO_scales_free_or_fixed)
})

ESSRO_aux_correcttable <- reactive({
    simulation_correctness_checker(ESSRO_aux_data()[nrow(ESSRO_aux_data()), ],
                                   ESSRO_parametergrid()[nrow(ESSRO_parametergrid()), ],
                                   "ESSRO")
})
output$ESSRO_Correctness_Table <- renderDataTable({
    ESSRO_aux_correcttable()
})
