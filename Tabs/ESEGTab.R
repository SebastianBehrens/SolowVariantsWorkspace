ESEGTab <-
  tabItem(
    "ESEG",
    sidebarLayout(
      # Sidebar Panel  ---------------------------------
      sidebarPanel(
        width = 2,
        # Variable Selector ---------------------------------
        titlePanel("Variables"),
        checkboxGroupInput("ESEG_vtv",
          label = "",
          choices = getModelVars("ESEG"),
          selected = getModelVars("ESEG")[1:5]
        ),
        hr(),
        # Periods ---------------------------------
        titlePanel("Number of Periods"),
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
hr(),




        # Scale Selector ---------------------------------
        titlePanel("Misc. Settings"),
        selectInput("ESEG_scales_free_or_fixed", label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
        hr()
      ),
      # Main Panel  ---------------------------------
      mainPanel(
        h1("The Extended Solow Model with Endogenous Growth", align = "center"),
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:5px;background-color:#538cb8;border-radius:50px;opacity:1;">'),
        HTML('<div style="height:50px"></div>'),
        # Model Equations  ---------------------------------
        h2("Model Equations", align = "center"),
        HTML('<div style="height:10px"></div>'),
        withMathJax(),
        'a) Semi-Endogenous Growth $$\\begin{aligned} Y_t &= K_t^\\alpha (AL_t)^{1-\\alpha} \\\\ A_t &= K_t^\\phi \\\\ K_{t+1}&= sY_t + (1-\\delta)K_t \\\\ L_{t+1}&=(1+n)L_t \\\\ \\end{aligned}$$  b) Fully Endogenous Growth $$\\begin{aligned} Y_t &= AK_t : A = L^{(1- \\alpha)}\\\\ K_{t+1}&= sY_t + (1-\\delta)K_t \\\\ L_{t+1}&=(1+n)L_t \\quad \\text{ where } n = 0  \\end{aligned}$$',
        # Visualisation  ---------------------------------
        # textOutput("test"),
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Simulation Visualised", align = "center"),
        HTML('<div style="height:20px"></div>'),
        plotOutput("ESEG_Viz", height = "1000px"),
        # Correctness Checker ---------------------------------
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Economy in Steady State?", align = "center"),
        HTML('<div style="height:20px"></div>'),
        dataTableOutput("ESEG_Correctness_Table"),
        # Model Simulation Data ---------------------------------
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Simulation Data", align = "center"),
        HTML('<div style="height:20px"></div>'),
        dataTableOutput("ESEG_Data")
      )
    )
  )
