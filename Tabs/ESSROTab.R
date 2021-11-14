ESSROTab <-
  tabItem(
    "ESSRO",
    sidebarLayout(
      # Sidebar Panel  ---------------------------------
      sidebarPanel(
        width = 2,
        # Variable Selector ---------------------------------
        titlePanel("Variables"),
        checkboxGroupInput("ESSRO_vtv",
          label = "",
          choices = getModelVars("ESSRO"),
          selected = getModelVars("ESSRO")[1:5]
        ),
        hr(),
        # Periods ---------------------------------
        titlePanel("Number of Periods"),
        numericInput("ESSRO_nperiods_selected", "Periods", 200, step = 20),
        hr(),
        # Starting Values ---------------------------------
        titlePanel("Starting Values of Stocks"),
        # StartingValuesCodeAutoFillLineIndexer
numericInput("ESSRO_initval_A", "Initial Value of Total Factor Productivity", 1),
numericInput("ESSRO_initval_K", "Initial Value of Physical Capital", 1),
numericInput("ESSRO_initval_L", "Initial Value of Labor", 1),
numericInput("ESSRO_initval_R", "Initial Value of Resource Stock (e.g. Oil)", 1),

        # Parameters ---------------------------------
        titlePanel("Parameter Values"),
        # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_alpha", "Alpha", 1/3, step = 0.05),
checkboxInput("ESSRO_changeinparam_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_alpha == true", 
    numericInput("ESSRO_pc_alpha_period", "Period of Change in Alpha", 50, min = 0),
    numericInput("ESSRO_pc_alpha_newval", "New Value of Alpha", 3/5, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_beta", "Beta", 1/3, step = 0.05),
checkboxInput("ESSRO_changeinparam_beta", "Change in Beta?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_beta == true", 
    numericInput("ESSRO_pc_beta_period", "Period of Change in Beta", 50, min = 0),
    numericInput("ESSRO_pc_beta_newval", "New Value of Beta", 3/5, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_popgrowth", "Population Growth", 0.01, step = 0.01),
checkboxInput("ESSRO_changeinparam_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_popgrowth == true", 
    numericInput("ESSRO_pc_popgrowth_period", "Period of Change in Population Growth", 50, min = 0),
    numericInput("ESSRO_pc_popgrowth_newval", "New Value of Population Growth", 0.05, step = 0.01)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_tfpgrowth", "TFP Growth", 0.02, step = 0.01),
checkboxInput("ESSRO_changeinparam_tfpgrowth", "Change in TFP Growth?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_tfpgrowth == true", 
    numericInput("ESSRO_pc_tfpgrowth_period", "Period of Change in TFP Growth", 50, min = 0),
    numericInput("ESSRO_pc_tfpgrowth_newval", "New Value of TFP Growth", 0.05, step = 0.01)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_energyconsumption", "Energy Consupmtion", 0.05, step = 0.05),
checkboxInput("ESSRO_changeinparam_energyconsumption", "Change in Energy Consupmtion?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_energyconsumption == true", 
    numericInput("ESSRO_pc_energyconsumption_period", "Period of Change in Energy Consupmtion", 50, min = 0),
    numericInput("ESSRO_pc_energyconsumption_newval", "New Value of Energy Consupmtion", 0.1, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_savings", "Savings Rate", 0.2, step = 0.05),
checkboxInput("ESSRO_changeinparam_savings", "Change in Savings Rate?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_savings == true", 
    numericInput("ESSRO_pc_savings_period", "Period of Change in Savings Rate", 50, min = 0),
    numericInput("ESSRO_pc_savings_newval", "New Value of Savings Rate", 0.3, step = 0.05)),
hr(),



# sectiontitle ---------------------------------
numericInput("ESSRO_initparam_delta", "Delta", 0.15, step = 0.05),
checkboxInput("ESSRO_changeinparam_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.ESSRO_changeinparam_delta == true", 
    numericInput("ESSRO_pc_delta_period", "Period of Change in Delta", 50, min = 0),
    numericInput("ESSRO_pc_delta_newval", "New Value of Delta", 0.3, step = 0.05)),
hr(),




        # Scale Selector ---------------------------------
        titlePanel("Misc. Settings"),
        selectInput("ESSRO_scales_free_or_fixed", label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
        hr()
      ),
      # Main Panel  ---------------------------------
      mainPanel(
        h1("The Extended Solow Model with the Scarce Resource Oil", align = "center"),
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:5px;background-color:#538cb8;border-radius:50px;opacity:1;">'),
        HTML('<div style="height:50px"></div>'),
        # Model Equations  ---------------------------------
        h2("Model Equations", align = "center"),
        HTML('<div style="height:10px"></div>'),
        withMathJax(),
        '$$ \\begin{aligned} Y_t &= K_t^\\alpha  * (A_t * L_t)^{(1- \\beta)} * E_t^\\varepsilon: \\alpha + \\beta + \\varepsilon = 1 \\\\ E_t &= s_ER_t\\\\ R_t &= R_{t-1} - E_{t-1}\\\\ K_{t+1} &= s_KY_t + (1-\\delta)K_{t} \\\\ L_{t+1}&=(1+n)L_t \\\\ A_{t+1}&=(1+g)A_t \\\\ \\end{aligned} $$',
        # Visualisation  ---------------------------------
        # textOutput("test"),
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Simulation Visualised", align = "center"),
        HTML('<div style="height:20px"></div>'),
        plotOutput("ESSRO_Viz", height = "1000px"),
        # Correctness Checker ---------------------------------
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Economy in Steady State?", align = "center"),
        HTML('<div style="height:20px"></div>'),
        dataTableOutput("ESSRO_Correctness_Table"),
        # Model Simulation Data ---------------------------------
        HTML('<div style="height:50px"></div>'),
        HTML('<hr style="height:2px;background-color:#538cb8;border-radius:50px;opacity:0.65;max-width:65%;">'),
        HTML('<div style="height:50px"></div>'),
        h2("Simulation Data", align = "center"),
        HTML('<div style="height:20px"></div>'),
        dataTableOutput("ESSRO_Data")
      )
    )
  )
