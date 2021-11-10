ESHCTab <- 
    tabPanel("Extended Solow Model with Human Capital", fluid = TRUE, sidebarLayout(
    # Sidebar Panel  ---------------------------------
    sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height:90%;padding-bottom:100px;",
                 fluidRow(
                     column(width = 6,
                            # Variable Selector ---------------------------------
                            titlePanel("Variables"),
                            checkboxGroupInput("ESHC_vtv", 
                                               label = "",
                                               choices = getModelVars("ESHC"), 
                                               selected = getModelVars("ESHC")[1:5]
                            ),
                            hr(),
                            # Scale Selector ---------------------------------
                            selectInput("ESHC_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                            hr()
                     ),
                     column(width = 6,
                            # Periods ---------------------------------
                            numericInput("ESHC_nperiods_selected", "Periods", 200, step = 20),
                            hr(),
                            # Starting Values ---------------------------------
                            titlePanel("Starting Values of Stocks"),
                            # StartingValuesCodeAutoFillLineIndexer
numericInput("ESHC_initval_A", "Initial Value of Total Factor Productivity", 1),
numericInput("ESHC_initval_K", "Initial Value of Physical Capital", 1),
numericInput("ESHC_initval_L", "Initial Value of Labor", 1),
numericInput("ESHC_initval_H", "Initial Value of Human Capital", 1),
                            
                            # Parameters ---------------------------------
                            titlePanel("Parameter Values"),
                            # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ESHC_initparam_alpha", "Alpha", 1/3, step = 0.05),
checkboxInput("ESHC_changeinparam_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ESHC_changeinparam_alpha == true", 
    numericInput("ESHC_pc_alpha_period", "Period of Change in Alpha", 50, min = 0),
    numericInput("ESHC_pc_alpha_newval", "New Value of Alpha", 3/5, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESHC_initparam_phi", "Phi", 1/6, step = 0.05),
checkboxInput("ESHC_changeinparam_phi", "Change in Phi?"),
conditionalPanel(
    condition = "input.ESHC_changeinparam_phi == true", 
    numericInput("ESHC_pc_phi_period", "Period of Change in Phi", 50, min = 0),
    numericInput("ESHC_pc_phi_newval", "New Value of Phi", 3/5, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESHC_initparam_popgrowth", "Population Growth", 0.01, step = 0.01),
checkboxInput("ESHC_changeinparam_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ESHC_changeinparam_popgrowth == true", 
    numericInput("ESHC_pc_popgrowth_period", "Period of Change in Population Growth", 50, min = 0),
    numericInput("ESHC_pc_popgrowth_newval", "New Value of Population Growth", 0.05, step = 0.01)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESHC_initparam_tfpgrowth", "TFP Growth", 0.02, step = 0.01),
checkboxInput("ESHC_changeinparam_tfpgrowth", "Change in TFP Growth?"),
conditionalPanel(
    condition = "input.ESHC_changeinparam_tfpgrowth == true", 
    numericInput("ESHC_pc_tfpgrowth_period", "Period of Change in TFP Growth", 50, min = 0),
    numericInput("ESHC_pc_tfpgrowth_newval", "New Value of TFP Growth", 0.05, step = 0.01)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESHC_initparam_sK", "Savings Rate to Physical Capital", 0.1, step = 0.05),
checkboxInput("ESHC_changeinparam_sK", "Change in Savings Rate to Physical Capital?"),
conditionalPanel(
    condition = "input.ESHC_changeinparam_sK == true", 
    numericInput("ESHC_pc_sK_period", "Period of Change in Savings Rate to Physical Capital", 50, min = 0),
    numericInput("ESHC_pc_sK_newval", "New Value of Savings Rate to Physical Capital", 0.2, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESHC_initparam_sH", "Savings Rate to Human Capital", 0.1, step = 0.05),
checkboxInput("ESHC_changeinparam_sH", "Change in Savings Rate to Human Capital?"),
conditionalPanel(
    condition = "input.ESHC_changeinparam_sH == true", 
    numericInput("ESHC_pc_sH_period", "Period of Change in Savings Rate to Human Capital", 50, min = 0),
    numericInput("ESHC_pc_sH_newval", "New Value of Savings Rate to Human Capital", 0.2, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESHC_initparam_delta", "Delta", 0.15, step = 0.05),
checkboxInput("ESHC_changeinparam_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.ESHC_changeinparam_delta == true", 
    numericInput("ESHC_pc_delta_period", "Period of Change in Delta", 50, min = 0),
    numericInput("ESHC_pc_delta_newval", "New Value of Delta", 0.3, step = 0.05)),
hr()



                            
                     )
                 )),
    # Main Panel  ---------------------------------
    mainPanel(
        # Model Equations  ---------------------------------
        titlePanel("Model Equations"),
        withMathJax(),
        '$$ \\begin{aligned} Y_t &= K_t^\\alpha * H_t^\\phi * (A_t * L_t)^{(1- \\alpha - \\phi)} \\\\ K_{t+1} &= s_KY_t + (1-\\delta)K_{t} \\\\ H_{t+1} &= s_HY_t + (1-\\delta)H_{t} \\\\ L_{t+1}&=(1+n)L_t \\\\ A_{t+1}&=(1+g)A_t \\\\ \\end{aligned} $$',
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
    )
    )
