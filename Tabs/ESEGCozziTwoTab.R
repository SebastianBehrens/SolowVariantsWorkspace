ESEGCozziTwoTab <- 
    tabPanel("Extended Solow Model (Endogenous Growth Cozzi Hybrid Model)", fluid = TRUE, sidebarLayout(
    # Sidebar Panel  ---------------------------------
    sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height:90%;padding-bottom:100px;",
                 fluidRow(
                     column(width = 6,
                            # Variable Selector ---------------------------------
                            titlePanel("Variables"),
                            checkboxGroupInput("ESEGCozziTwo_vtv", 
                                               label = "",
                                               choices = getModelVars("ESEGCozziTwo"), 
                                               selected = getModelVars("ESEGCozziTwo")[1:5]
                            ),
                            hr(),
                            # Scale Selector ---------------------------------
                            selectInput("ESEGCozziTwo_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                            hr()
                     ),
                     column(width = 6,
                            # Periods ---------------------------------
                            numericInput("ESEGCozziTwo_nperiods_selected", "Periods", 200, step = 20),
                            hr(),
                            # Starting Values ---------------------------------
                            titlePanel("Starting Values of Stocks"),
                            # StartingValuesCodeAutoFillLineIndexer
numericInput("ESEGCozziTwo_initval_A", "Initial Value of Total Factor Productivity", 1),
numericInput("ESEGCozziTwo_initval_K", "Initial Value of Physical Capital", 1),
numericInput("ESEGCozziTwo_initval_L", "Initial Value of Labor", 1),
                            
                            # Parameters ---------------------------------
                            titlePanel("Parameter Values"),
                            # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ESEGCozziTwo_initparam_alpha", "Alpha", 1/3, step = 0.05),
checkboxInput("ESEGCozziTwo_changeinparam_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ESEGCozziTwo_changeinparam_alpha == true", 
    numericInput("ESEGCozziTwo_pc_alpha_period", "Period of Change in Alpha", 50, min = 0),
    numericInput("ESEGCozziTwo_pc_alpha_newval", "New Value of Alpha", 3/5, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziTwo_initparam_phi", "Phi", 0.5, step = 0.05),
checkboxInput("ESEGCozziTwo_changeinparam_phi", "Change in Phi?"),
conditionalPanel(
    condition = "input.ESEGCozziTwo_changeinparam_phi == true", 
    numericInput("ESEGCozziTwo_pc_phi_period", "Period of Change in Phi", 50, min = 0),
    numericInput("ESEGCozziTwo_pc_phi_newval", "New Value of Phi", 0.7, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziTwo_initparam_lambda", "lambda", 0.9, step = 0.05),
checkboxInput("ESEGCozziTwo_changeinparam_lambda", "Change in lambda?"),
conditionalPanel(
    condition = "input.ESEGCozziTwo_changeinparam_lambda == true", 
    numericInput("ESEGCozziTwo_pc_lambda_period", "Period of Change in lambda", 50, min = 0),
    numericInput("ESEGCozziTwo_pc_lambda_newval", "New Value of lambda", 0.6, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziTwo_initparam_rho", "Rho", 1, step = 0.1),
checkboxInput("ESEGCozziTwo_changeinparam_rho", "Change in Rho?"),
conditionalPanel(
    condition = "input.ESEGCozziTwo_changeinparam_rho == true", 
    numericInput("ESEGCozziTwo_pc_rho_period", "Period of Change in Rho", 50, min = 0),
    numericInput("ESEGCozziTwo_pc_rho_newval", "New Value of Rho", 0.75, step = 0.1)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziTwo_initparam_savings", "Savings Rate", 0.2, step = 0.05),
checkboxInput("ESEGCozziTwo_changeinparam_savings", "Change in Savings Rate?"),
conditionalPanel(
    condition = "input.ESEGCozziTwo_changeinparam_savings == true", 
    numericInput("ESEGCozziTwo_pc_savings_period", "Period of Change in Savings Rate", 50, min = 0),
    numericInput("ESEGCozziTwo_pc_savings_newval", "New Value of Savings Rate", 0.3, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziTwo_initparam_sR", "Prop. Labor Force in R&D", 0.03, step = 0.05),
checkboxInput("ESEGCozziTwo_changeinparam_sR", "Change in Prop. Labor Force in R&D?"),
conditionalPanel(
    condition = "input.ESEGCozziTwo_changeinparam_sR == true", 
    numericInput("ESEGCozziTwo_pc_sR_period", "Period of Change in Prop. Labor Force in R&D", 50, min = 0),
    numericInput("ESEGCozziTwo_pc_sR_newval", "New Value of Prop. Labor Force in R&D", 0.15, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziTwo_initparam_delta", "Delta", 0.15, step = 0.05),
checkboxInput("ESEGCozziTwo_changeinparam_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.ESEGCozziTwo_changeinparam_delta == true", 
    numericInput("ESEGCozziTwo_pc_delta_period", "Period of Change in Delta", 50, min = 0),
    numericInput("ESEGCozziTwo_pc_delta_newval", "New Value of Delta", 0.3, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziTwo_initparam_popgrowth", "Population Growth", 0.01, step = 0.01),
checkboxInput("ESEGCozziTwo_changeinparam_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ESEGCozziTwo_changeinparam_popgrowth == true", 
    numericInput("ESEGCozziTwo_pc_popgrowth_period", "Period of Change in Population Growth", 50, min = 0),
    numericInput("ESEGCozziTwo_pc_popgrowth_newval", "New Value of Population Growth", 0.05, step = 0.01)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziTwo_initparam_k", "k", 0.5, step = 0.05),
checkboxInput("ESEGCozziTwo_changeinparam_k", "Change in k?"),
conditionalPanel(
    condition = "input.ESEGCozziTwo_changeinparam_k == true", 
    numericInput("ESEGCozziTwo_pc_k_period", "Period of Change in k", 50, min = 0),
    numericInput("ESEGCozziTwo_pc_k_newval", "New Value of k", 0.75, step = 0.05)),
hr()



                            
                     )
                 )),
    # Main Panel  ---------------------------------
    mainPanel(
        # Model Equations  ---------------------------------
        titlePanel("Model Equations"),
        withMathJax(),
        '$$\\begin{aligned} Y_t &= K_t^\\alpha (A_tL_{Y,t})^{1-\\alpha} \\\\ A_{t+1} &= k\\rho  A_t^\\phi L_{A,t}^\\lambda + (1-k)\\rho A_t s_R^\\lambda + A_t \\\\ K_{t+1}&= sY_t + (1-\\delta)K_t \\\\ L_{t+1}&=(1+n)L_t \\\\ L_t &= L_{A,t} + L_{Y,t} \\\\ L_{A, t} &= s_R * L_t (\\rightarrow L_{Y,t} = (1-s_R * L_t)) \\end{aligned}$$',
        # Visualisation  ---------------------------------
        # textOutput("test"),
        titlePanel("Simulation"),
        plotOutput("ESEGCozziTwo_Viz", height = "1000px"),
        # Model Simulation Data ---------------------------------
        titlePanel("Simulation Data"),
        dataTableOutput("ESEGCozziTwo_Data"),
        # Correctness Checker ---------------------------------
        titlePanel("How does the simulation compare to the theoretic steady state values?"),
        dataTableOutput("ESEGCozziTwo_Correctness_Table")
    )  
    )
    )
