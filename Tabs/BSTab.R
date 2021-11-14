BSTab <-
  tabItem(
    "BS",
    sidebarLayout(
      # Sidebar Panel  ---------------------------------
      sidebarPanel(
        width = 2,
        # Variable Selector ---------------------------------
        titlePanel("Variables"),
        checkboxGroupInput("BS_vtv",
          label = "",
          choices = getModelVars("BS"),
          selected = getModelVars("BS")[1:5]
        ),
        hr(),
        # Periods ---------------------------------
        titlePanel("Number of Periods"),
        numericInput("BS_nperiods_selected", "Periods", 200, step = 20),
        hr(),
        # Starting Values ---------------------------------
        titlePanel("Starting Values of Stocks"),
        # StartingValuesCodeAutoFillLineIndexer
numericInput("BS_initval_K", "Initial Value of Physical Capital", 1),
numericInput("BS_initval_L", "Initial Value of Labor", 1),

        # Parameters ---------------------------------
        titlePanel("Parameter Values"),
        # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("BS_initparam_TFP", "TFP", 1, step = 1),
checkboxInput("BS_changeinparam_TFP", "Change in TFP?"),
conditionalPanel(
    condition = "input.BS_changeinparam_TFP == true", 
    numericInput("BS_pc_TFP_period", "Period of Change in TFP", 50, min = 0),
    numericInput("BS_pc_TFP_newval", "New Value of TFP", 3, step = 1)),
hr(),



# sectiontitle ---------------------------------
numericInput("BS_initparam_alpha", "Alpha", 1/3, step = 0.05),
checkboxInput("BS_changeinparam_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.BS_changeinparam_alpha == true", 
    numericInput("BS_pc_alpha_period", "Period of Change in Alpha", 50, min = 0),
    numericInput("BS_pc_alpha_newval", "New Value of Alpha", 3/5, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("BS_initparam_delta", "Delta", 0.15, step = 0.05),
checkboxInput("BS_changeinparam_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.BS_changeinparam_delta == true", 
    numericInput("BS_pc_delta_period", "Period of Change in Delta", 50, min = 0),
    numericInput("BS_pc_delta_newval", "New Value of Delta", 0.3, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("BS_initparam_popgrowth", "Population Growth", 0.01, step = 0.01),
checkboxInput("BS_changeinparam_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.BS_changeinparam_popgrowth == true", 
    numericInput("BS_pc_popgrowth_period", "Period of Change in Population Growth", 50, min = 0),
    numericInput("BS_pc_popgrowth_newval", "New Value of Population Growth", 0.05, step = 0.01)),
hr(),



# sectiontitle ---------------------------------
numericInput("BS_initparam_savings", "Savings Rate", 0.2, step = 0.05),
checkboxInput("BS_changeinparam_savings", "Change in Savings Rate?"),
conditionalPanel(
    condition = "input.BS_changeinparam_savings == true", 
    numericInput("BS_pc_savings_period", "Period of Change in Savings Rate", 50, min = 0),
    numericInput("BS_pc_savings_newval", "New Value of Savings Rate", 0.3, step = 0.05)),
hr(),




        # Scale Selector ---------------------------------
        titlePanel("Misc. Settings"),
        selectInput("BS_scales_free_or_fixed", label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
        hr()
      ),
      # Main Panel  ---------------------------------
      mainPanel(
        h1("The Basic Solow Model", align = "center"),
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:5px;background-color:#538cb8;border-radius:50px;opacity:1;">'),
        HTML('<div style="height:50px"></div>'),
        # Model Equations  ---------------------------------
        h2("Model Equations", align = "center"),
        HTML('<div style="height:10px"></div>'),
        withMathJax(),
        '$$ \\begin{aligned} Y_t &= BK_t^\\alpha L_t^{1-\\alpha} \\\\ r_t &= \\alpha B \\left(\\frac{K_t}{L_t}\\right)^{\\alpha -1}\\\\ w_t &= (1-\\alpha) \\left(\\frac{K_t}{L_t}\\right)^\\alpha \\\\ S_t &= sY_t \\\\ K_{t+1}&= sY_t + (1-\\delta)K_t \\\\ L_{t+1}&=(1+n)L_t \\end{aligned} $$  ',
        # Visualisation  ---------------------------------
        # textOutput("test"),
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Simulation Visualised", align = "center"),
        HTML('<div style="height:20px"></div>'),
        plotOutput("BS_Viz", height = "1000px"),
        # Correctness Checker ---------------------------------
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Economy in Steady State?", align = "center"),
        HTML('<div style="height:20px"></div>'),
        dataTableOutput("BS_Correctness_Table"),
        # Model Simulation Data ---------------------------------
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Simulation Data", align = "center"),
        HTML('<div style="height:20px"></div>'),
        dataTableOutput("BS_Data")
      )
    )
  )
