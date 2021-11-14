ESEGCozziOneTab <-
  tabItem(
    "ESEGCozziOne",
    sidebarLayout(
      # Sidebar Panel  ---------------------------------
      sidebarPanel(
        width = 2,
        # Variable Selector ---------------------------------
        titlePanel("Variables"),
        checkboxGroupInput("ESEGCozziOne_vtv",
          label = "",
          choices = getModelVars("ESEGCozziOne"),
          selected = getModelVars("ESEGCozziOne")[1:5]
        ),
        hr(),
        # Periods ---------------------------------
        titlePanel("Number of Periods"),
        numericInput("ESEGCozziOne_nperiods_selected", "Periods", 200, step = 20),
        hr(),
        # Starting Values ---------------------------------
        titlePanel("Starting Values of Stocks"),
        # StartingValuesCodeAutoFillLineIndexer
numericInput("ESEGCozziOne_initval_A", "Initial Value of Total Factor Productivity", 1),
numericInput("ESEGCozziOne_initval_K", "Initial Value of Physical Capital", 1),
numericInput("ESEGCozziOne_initval_L", "Initial Value of Labor", 1),

        # Parameters ---------------------------------
        titlePanel("Parameter Values"),
        # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ESEGCozziOne_initparam_alpha", "Alpha", 1/3, step = 0.05),
checkboxInput("ESEGCozziOne_changeinparam_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ESEGCozziOne_changeinparam_alpha == true", 
    numericInput("ESEGCozziOne_pc_alpha_period", "Period of Change in Alpha", 50, min = 0),
    numericInput("ESEGCozziOne_pc_alpha_newval", "New Value of Alpha", 3/5, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziOne_initparam_phi", "Phi", 0.5, step = 0.05),
checkboxInput("ESEGCozziOne_changeinparam_phi", "Change in Phi?"),
conditionalPanel(
    condition = "input.ESEGCozziOne_changeinparam_phi == true", 
    numericInput("ESEGCozziOne_pc_phi_period", "Period of Change in Phi", 50, min = 0),
    numericInput("ESEGCozziOne_pc_phi_newval", "New Value of Phi", 0.7, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziOne_initparam_lambda", "Lambda", 0.9, step = 0.05),
checkboxInput("ESEGCozziOne_changeinparam_lambda", "Change in Lambda?"),
conditionalPanel(
    condition = "input.ESEGCozziOne_changeinparam_lambda == true", 
    numericInput("ESEGCozziOne_pc_lambda_period", "Period of Change in Lambda", 50, min = 0),
    numericInput("ESEGCozziOne_pc_lambda_newval", "New Value of Lambda", 0.6, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziOne_initparam_rho", "Rho", 1, step = 0.1),
checkboxInput("ESEGCozziOne_changeinparam_rho", "Change in Rho?"),
conditionalPanel(
    condition = "input.ESEGCozziOne_changeinparam_rho == true", 
    numericInput("ESEGCozziOne_pc_rho_period", "Period of Change in Rho", 50, min = 0),
    numericInput("ESEGCozziOne_pc_rho_newval", "New Value of Rho", 0.75, step = 0.1)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziOne_initparam_savings", "Savings Rate", 0.2, step = 0.05),
checkboxInput("ESEGCozziOne_changeinparam_savings", "Change in Savings Rate?"),
conditionalPanel(
    condition = "input.ESEGCozziOne_changeinparam_savings == true", 
    numericInput("ESEGCozziOne_pc_savings_period", "Period of Change in Savings Rate", 50, min = 0),
    numericInput("ESEGCozziOne_pc_savings_newval", "New Value of Savings Rate", 0.3, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziOne_initparam_sR", "Prop. Labor Force in R&D", 0.03, step = 0.05),
checkboxInput("ESEGCozziOne_changeinparam_sR", "Change in Prop. Labor Force in R&D?"),
conditionalPanel(
    condition = "input.ESEGCozziOne_changeinparam_sR == true", 
    numericInput("ESEGCozziOne_pc_sR_period", "Period of Change in Prop. Labor Force in R&D", 50, min = 0),
    numericInput("ESEGCozziOne_pc_sR_newval", "New Value of Prop. Labor Force in R&D", 0.15, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziOne_initparam_delta", "Delta", 0.15, step = 0.05),
checkboxInput("ESEGCozziOne_changeinparam_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.ESEGCozziOne_changeinparam_delta == true", 
    numericInput("ESEGCozziOne_pc_delta_period", "Period of Change in Delta", 50, min = 0),
    numericInput("ESEGCozziOne_pc_delta_newval", "New Value of Delta", 0.3, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESEGCozziOne_initparam_popgrowth", "Population Growth", 0.01, step = 0.01),
checkboxInput("ESEGCozziOne_changeinparam_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ESEGCozziOne_changeinparam_popgrowth == true", 
    numericInput("ESEGCozziOne_pc_popgrowth_period", "Period of Change in Population Growth", 50, min = 0),
    numericInput("ESEGCozziOne_pc_popgrowth_newval", "New Value of Population Growth", 0.05, step = 0.01)),
hr(),




        # Scale Selector ---------------------------------
        titlePanel("Misc. Settings"),
        selectInput("ESEGCozziOne_scales_free_or_fixed", label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
        hr()
      ),
      # Main Panel  ---------------------------------
      mainPanel(
        h1("The Extended Solow Model with Endogenous Growth (Cozzi Extension)", align = "center"),
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:5px;background-color:#538cb8;border-radius:50px;opacity:1;">'),
        HTML('<div style="height:50px"></div>'),
        # Model Equations  ---------------------------------
        h2("Model Equations", align = "center"),
        HTML('<div style="height:10px"></div>'),
        withMathJax(),
        '$$\\begin{aligned} Y_t &= K_t^\\alpha (A_tL_{Y,t})^{1-\\alpha} \\\\ A_{t+1} &= \\rho A_t s_R^\\lambda + A_t \\\\ K_{t+1}&= sY_t + (1-\\delta)K_t \\\\ L_{t+1}&=(1+n)L_t \\\\ L_t &= L_{A,t} + L_{Y,t} \\\\ L_{A, t} &= s_R * L_t \\quad \\rightarrow L_{Y,t} = (1-s_R) * L_t \\end{aligned}$$',
        # Visualisation  ---------------------------------
        # textOutput("test"),
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Simulation Visualised", align = "center"),
        HTML('<div style="height:20px"></div>'),
        plotOutput("ESEGCozziOne_Viz", height = "1000px"),
        # Correctness Checker ---------------------------------
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Economy in Steady State?", align = "center"),
        HTML('<div style="height:20px"></div>'),
        dataTableOutput("ESEGCozziOne_Correctness_Table"),
        # Model Simulation Data ---------------------------------
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Simulation Data", align = "center"),
        HTML('<div style="height:20px"></div>'),
        dataTableOutput("ESEGCozziOne_Data")
      )
    )
  )
