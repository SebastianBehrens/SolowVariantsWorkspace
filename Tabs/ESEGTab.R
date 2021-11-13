ESEGTab <- 
    tabPanel("Extended Solow Model (Endogenous Growth)", fluid = TRUE, sidebarLayout(
    # Sidebar Panel  ---------------------------------
    sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height:90%;padding-bottom:100px;",
                 fluidRow(
                     column(width = 6,
                            # Variable Selector ---------------------------------
                            titlePanel("Variables"),
                            checkboxGroupInput("ESEG_vtv", 
                                               label = "",
                                               choices = getModelVars("ESEG"), 
                                               selected = getModelVars("ESEG")[1:5]
                            ),
                            hr(),
                            # Scale Selector ---------------------------------
                            selectInput("ESEG_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                            hr()
                     ),
                     column(width = 6,
                            # Periods ---------------------------------
                            numericInput("ESEG_nperiods_selected", "Periods", 200, step = 20),
                            hr(),
                            # Starting Values ---------------------------------
                            titlePanel("Starting Values of Stocks"),
                            # StartingValuesCodeAutoFillLineIndexer
numericInput("ESEG_initval_K", "Initial Value of Physical Capital", 1),
numericInput("ESEG_initval_L", "Initial Value of Labor", 1),
                            
                            # Parameters ---------------------------------
                            titlePanel("Parameter Values"),
                            # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ESEG_initparam_alpha", "Alpha", 1/3, step = 0.05),
checkboxInput("ESEG_changeinparam_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ESEG_changeinparam_alpha == true", 
    numericInput("ESEG_pc_alpha_period", "Period of Change in Alpha", 50, min = 0),
    numericInput("ESEG_pc_alpha_newval", "New Value of Alpha", 3/5, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEG_initparam_phi", "Phi", 0.5, step = 0.05),
checkboxInput("ESEG_changeinparam_phi", "Change in Phi?"),
conditionalPanel(
    condition = "input.ESEG_changeinparam_phi == true", 
    numericInput("ESEG_pc_phi_period", "Period of Change in Phi", 50, min = 0),
    numericInput("ESEG_pc_phi_newval", "New Value of Phi", 0.7, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEG_initparam_savings", "Savings Rate", 0.2, step = 0.05),
checkboxInput("ESEG_changeinparam_savings", "Change in Savings Rate?"),
conditionalPanel(
    condition = "input.ESEG_changeinparam_savings == true", 
    numericInput("ESEG_pc_savings_period", "Period of Change in Savings Rate", 50, min = 0),
    numericInput("ESEG_pc_savings_newval", "New Value of Savings Rate", 0.3, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEG_initparam_delta", "Delta", 0.15, step = 0.05),
checkboxInput("ESEG_changeinparam_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.ESEG_changeinparam_delta == true", 
    numericInput("ESEG_pc_delta_period", "Period of Change in Delta", 50, min = 0),
    numericInput("ESEG_pc_delta_newval", "New Value of Delta", 0.3, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEG_initparam_popgrowth", "Population Growth", 0.01, step = 0.01),
checkboxInput("ESEG_changeinparam_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ESEG_changeinparam_popgrowth == true", 
    numericInput("ESEG_pc_popgrowth_period", "Period of Change in Population Growth", 50, min = 0),
    numericInput("ESEG_pc_popgrowth_newval", "New Value of Population Growth", 0.05, step = 0.01)),
hr()



                            
                     )
                 )),
    # Main Panel  ---------------------------------
    mainPanel(
        # Model Equations  ---------------------------------
        titlePanel("Model Equations"),
        withMathJax(),
        'a) Semi-Endogenous Growth $$\\begin{aligned} Y_t &= K_t^\\alpha (AL_t)^{1-\\alpha} \\\\ A_t &= K_t^\\phi \\\\ K_{t+1}&= sY_t + (1-\\delta)K_t \\\\ L_{t+1}&=(1+n)L_t \\\\ \\end{aligned}$$  b) Fully Endogenous Growth $$\\begin{aligned} Y_t &= AK_t : A = L^{(1- \\alpha)}\\\\ K_{t+1}&= sY_t + (1-\\delta)K_t \\\\ L_{t+1}&=(1+n)L_t \\quad \\text{ where } n = 0  \\end{aligned}$$',
        # Visualisation  ---------------------------------
        # textOutput("test"),
        titlePanel("Simulation"),
        plotOutput("ESEG_Viz", height = "1000px"),
        # Model Simulation Data ---------------------------------
        titlePanel("Simulation Data"),
        dataTableOutput("ESEG_Data"),
        # Correctness Checker ---------------------------------
        titlePanel("How does the simulation compare to the theoretic steady state values?"),
        dataTableOutput("ESEG_Correctness_Table")
    )  
    )
    )
