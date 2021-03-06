ESSOETab <-
  tabItem(
    "ESSOE",
    sidebarLayout(
      # Sidebar Panel  ---------------------------------
      sidebarPanel(
        width = 2,
        # Variable Selector ---------------------------------
        titlePanel("Variables"),
        checkboxGroupInput("ESSOE_vtv",
          label = "",
          choices = getModelVars("ESSOE"),
          selected = getModelVars("ESSOE")[1:5]
        ),
        hr(),
        # Periods ---------------------------------
        titlePanel("Number of Periods"),
        numericInput("ESSOE_nperiods_selected", "Periods", 200, step = 20),
        hr(),
        # Starting Values ---------------------------------
        titlePanel("Starting Values of Stocks"),
        # StartingValuesCodeAutoFillLineIndexer
numericInput("ESSOE_initval_L", "Initial Value of Labor", 1),
numericInput("ESSOE_initval_V", "Initial Value of National Wealth", 1),

        # Parameters ---------------------------------
        titlePanel("Parameter Values"),
        # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ESSOE_initparam_TFP", "TFP", 1, step = 1),
checkboxInput("ESSOE_changeinparam_TFP", "Change in TFP?"),
conditionalPanel(
    condition = "input.ESSOE_changeinparam_TFP == true", 
    numericInput("ESSOE_pc_TFP_period", "Period of Change in TFP", 50, min = 0),
    numericInput("ESSOE_pc_TFP_newval", "New Value of TFP", 3, step = 1)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSOE_initparam_alpha", "Alpha", 1/3, step = 0.05),
checkboxInput("ESSOE_changeinparam_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ESSOE_changeinparam_alpha == true", 
    numericInput("ESSOE_pc_alpha_period", "Period of Change in Alpha", 50, min = 0),
    numericInput("ESSOE_pc_alpha_newval", "New Value of Alpha", 3/5, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSOE_initparam_popgrowth", "Population Growth", 0.01, step = 0.01),
checkboxInput("ESSOE_changeinparam_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ESSOE_changeinparam_popgrowth == true", 
    numericInput("ESSOE_pc_popgrowth_period", "Period of Change in Population Growth", 50, min = 0),
    numericInput("ESSOE_pc_popgrowth_newval", "New Value of Population Growth", 0.05, step = 0.01)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSOE_initparam_savings", "Savings Rate", 0.2, step = 0.05),
checkboxInput("ESSOE_changeinparam_savings", "Change in Savings Rate?"),
conditionalPanel(
    condition = "input.ESSOE_changeinparam_savings == true", 
    numericInput("ESSOE_pc_savings_period", "Period of Change in Savings Rate", 50, min = 0),
    numericInput("ESSOE_pc_savings_newval", "New Value of Savings Rate", 0.3, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSOE_initparam_realint", "Real Interest Rate", 0.03, step = 0.01),
checkboxInput("ESSOE_changeinparam_realint", "Change in Real Interest Rate?"),
conditionalPanel(
    condition = "input.ESSOE_changeinparam_realint == true", 
    numericInput("ESSOE_pc_realint_period", "Period of Change in Real Interest Rate", 50, min = 0),
    numericInput("ESSOE_pc_realint_newval", "New Value of Real Interest Rate", 0.05, step = 0.01)),
hr(),




        # Scale Selector ---------------------------------
        titlePanel("Misc. Settings"),
        selectInput("ESSOE_scales_free_or_fixed", label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
        hr()
      ),
      # Main Panel  ---------------------------------
      mainPanel(
        h1("The Extended Solow Model for the Small Open Economy", align = "center"),
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:5px;background-color:#538cb8;border-radius:50px;opacity:1;">'),
        HTML('<div style="height:50px"></div>'),
        # Model Equations  ---------------------------------
        h2("Model Equations", align = "center"),
        HTML('<div style="height:10px"></div>'),
        withMathJax(),
        '$$ \\begin{aligned} Y_t &= BK_t^\\alpha L_t^{1-\\alpha} \\\\ Y_n &= Y_t + \\bar{r}F_t \\\\ V_t &= K_t + F_t\\\\ r_t &= \\alpha B \\left(\\frac{K_t}{L_t}\\right)^{\\alpha -1}\\\\ w_t &= (1-\\alpha) B \\left(\\frac{K_t}{L_t}\\right)^\\alpha \\\\ S_t &= sY_t \\\\ S_t &= V_{t+1} - V_t\\\\ L_{t+1}&=(1+n)L_t \\\\ \\end{aligned} $$',
        # Visualisation  ---------------------------------
        # textOutput("test"),
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Simulation Visualised", align = "center"),
        HTML('<div style="height:20px"></div>'),
        plotOutput("ESSOE_Viz", height = "1000px"),
        # Correctness Checker ---------------------------------
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Economy in Steady State?", align = "center"),
        HTML('<div style="height:20px"></div>'),
        dataTableOutput("ESSOE_Correctness_Table"),
        # Model Simulation Data ---------------------------------
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Simulation Data", align = "center"),
        HTML('<div style="height:20px"></div>'),
        dataTableOutput("ESSOE_Data")
      )
    )
  )
