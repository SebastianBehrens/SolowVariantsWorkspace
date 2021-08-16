tabPanel("panetitle", fluid = TRUE, sidebarLayout(
    # Sidebar Panel  ---------------------------------
    sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height: 90%;",
                 fluidRow(
                     column(width = 6,
                            # Variable Selector ---------------------------------
                            titlePanel("Variables"),
                            checkboxGroupInput("ESHC_vtv", 
                                               label = "",
                                               choices = meta_ESHC_variables, 
                                               selected = meta_ESHC_variables[1:5]),
                            hr(),
                            # Scale Selector ---------------------------------
                            selectInput("ESHC_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                            hr(),
                            # Starting Values ---------------------------------
                            titlePanel("Starting Values of Stocks"),
                            # StartingValuesCodeAutoFillLineIndexer
numericInput("ComparingModels1_ESHC_initval_A", "Initial Value of _____________", 5),
numericInput("ComparingModels1_ESHC_initval_K", "Initial Value of _____________", 5),
numericInput("ComparingModels1_ESHC_initval_L", "Initial Value of _____________", 5),
numericInput("ComparingModels1_ESHC_initval_H", "Initial Value of _____________", 5),
                     ),
                     column(width = 6,
                            # Parameters ---------------------------------
                            titlePanel("Parameter Values"),
                            # Periods ---------------------------------
                            numericInput("ESHC_nperiods_selected", "Periods", 200, step = 20),
                            hr(),
                            # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ComparingModels_ESHC_parameterchange_valuebefore_alpha", "Alpha", 0.3, step = 0.05),
checkboxInput("ComparingModels_ESHC_parameterchange_indicator_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ComparingModels_ESHC_parameterchange_indicator_alpha == true", 
    numericInput("ComparingModels_ESHC_parameterchange_period_alpha", "Period of Change in Alpha", 10, min = 0, max = 50),
    numericInput("ComparingModels_ESHC_parameterchange_valueafter_alpha", "New Value of Alpha", 0.4, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels_ESHC_parameterchange_valuebefore_phi", "Phi", 0.3, step = 0.05),
checkboxInput("ComparingModels_ESHC_parameterchange_indicator_phi", "Change in Phi?"),
conditionalPanel(
    condition = "input.ComparingModels_ESHC_parameterchange_indicator_phi == true", 
    numericInput("ComparingModels_ESHC_parameterchange_period_phi", "Period of Change in Phi", 10, min = 0, max = 50),
    numericInput("ComparingModels_ESHC_parameterchange_valueafter_phi", "New Value of Phi", 0.4, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels_ESHC_parameterchange_valuebefore_popgrowth", "Population Growth", 0.3, step = 0.05),
checkboxInput("ComparingModels_ESHC_parameterchange_indicator_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ComparingModels_ESHC_parameterchange_indicator_popgrowth == true", 
    numericInput("ComparingModels_ESHC_parameterchange_period_popgrowth", "Period of Change in Population Growth", 10, min = 0, max = 50),
    numericInput("ComparingModels_ESHC_parameterchange_valueafter_popgrowth", "New Value of Population Growth", 0.4, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels_ESHC_parameterchange_valuebefore_tfpgrowth", "TFP Growth", 0.3, step = 0.05),
checkboxInput("ComparingModels_ESHC_parameterchange_indicator_tfpgrowth", "Change in TFP Growth?"),
conditionalPanel(
    condition = "input.ComparingModels_ESHC_parameterchange_indicator_tfpgrowth == true", 
    numericInput("ComparingModels_ESHC_parameterchange_period_tfpgrowth", "Period of Change in TFP Growth", 10, min = 0, max = 50),
    numericInput("ComparingModels_ESHC_parameterchange_valueafter_tfpgrowth", "New Value of TFP Growth", 0.4, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels_ESHC_parameterchange_valuebefore_sK", "Savings Rate to Physical Capital", 0.3, step = 0.05),
checkboxInput("ComparingModels_ESHC_parameterchange_indicator_sK", "Change in Savings Rate to Physical Capital?"),
conditionalPanel(
    condition = "input.ComparingModels_ESHC_parameterchange_indicator_sK == true", 
    numericInput("ComparingModels_ESHC_parameterchange_period_sK", "Period of Change in Savings Rate to Physical Capital", 10, min = 0, max = 50),
    numericInput("ComparingModels_ESHC_parameterchange_valueafter_sK", "New Value of Savings Rate to Physical Capital", 0.4, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels_ESHC_parameterchange_valuebefore_sH", "Savings Rate to Human Capital", 0.3, step = 0.05),
checkboxInput("ComparingModels_ESHC_parameterchange_indicator_sH", "Change in Savings Rate to Human Capital?"),
conditionalPanel(
    condition = "input.ComparingModels_ESHC_parameterchange_indicator_sH == true", 
    numericInput("ComparingModels_ESHC_parameterchange_period_sH", "Period of Change in Savings Rate to Human Capital", 10, min = 0, max = 50),
    numericInput("ComparingModels_ESHC_parameterchange_valueafter_sH", "New Value of Savings Rate to Human Capital", 0.4, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels_ESHC_parameterchange_valuebefore_delta", "Delta", 0.3, step = 0.05),
checkboxInput("ComparingModels_ESHC_parameterchange_indicator_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.ComparingModels_ESHC_parameterchange_indicator_delta == true", 
    numericInput("ComparingModels_ESHC_parameterchange_period_delta", "Period of Change in Delta", 10, min = 0, max = 50),
    numericInput("ComparingModels_ESHC_parameterchange_valueafter_delta", "New Value of Delta", 0.4, step = 0.05)),
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
        plotOutput("ESHC_Viz", height = "1000px"),
        # Model Simulation Data ---------------------------------
        titlePanel("Simulation Data"),
        dataTableOutput("ESHC_Data"),
        # Correctness Checker ---------------------------------
        titlePanel("How does the simulation compare to the theoretic steady state values?"),
        dataTableOutput("ESHC_Correctness_Table")
    )  
)),
