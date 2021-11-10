ESSROLTab <-
  tabPanel("Extended Solow Model (Scarce Resources: Oil and Land)", fluid = TRUE, sidebarLayout(
    # Sidebar Panel  ---------------------------------
    sidebarPanel(
      width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height:90%;padding-bottom:100px;",
      fluidRow(
        column(
          width = 6,
          # Variable Selector ---------------------------------
          titlePanel("Variables"),
          checkboxGroupInput("ESSROL_vtv",
            label = "",
            choices = meta_ESSROL_variables,
            selected = meta_ESSROL_variables[1:5]
          ),
          hr(),
          # Scale Selector ---------------------------------
          selectInput("ESSROL_scales_free_or_fixed", label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
          hr()
        ),
        column(
          width = 6,
          # Periods ---------------------------------
          numericInput("ESSROL_nperiods_selected", "Periods", 200, step = 20),
          hr(),
          # Starting Values ---------------------------------
          titlePanel("Starting Values of Stocks"),
          # StartingValuesCodeAutoFillLineIndexer
          numericInput("ESSROL_initval_A", "Initial Value of Total Factor Productivity", 1),
          numericInput("ESSROL_initval_K", "Initial Value of Physical Capital", 1),
          numericInput("ESSROL_initval_L", "Initial Value of Labor", 1),
          numericInput("ESSROL_initval_R", "Initial Value of Resource Stock (e.g. Oil)", 1),

          # Parameters ---------------------------------
          titlePanel("Parameter Values"),
          # ParameterCodeAutoFillLineIndexer
          # sectiontitle ---------------------------------
          numericInput("ESSROL_initparam_alpha", "Alpha", 2 / 5, step = 0.05),
          checkboxInput("ESSROL_changeinparam_alpha", "Change in Alpha?"),
          conditionalPanel(
            condition = "input.ESSROL_changeinparam_alpha == true",
            numericInput("ESSROL_pc_alpha_period", "Period of Change in Alpha", 50, min = 0),
            numericInput("ESSROL_pc_alpha_newval", "New Value of Alpha", 3 / 5, step = 0.05)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSROL_initparam_beta", "Beta", 2 / 5, step = 0.05),
          checkboxInput("ESSROL_changeinparam_beta", "Change in Beta?"),
          conditionalPanel(
            condition = "input.ESSROL_changeinparam_beta == true",
            numericInput("ESSROL_pc_beta_period", "Period of Change in Beta", 50, min = 0),
            numericInput("ESSROL_pc_beta_newval", "New Value of Beta", 3 / 5, step = 0.05)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSROL_initparam_kappa", "Kappa", 2 / 5, step = 0.05),
          checkboxInput("ESSROL_changeinparam_kappa", "Change in Kappa?"),
          conditionalPanel(
            condition = "input.ESSROL_changeinparam_kappa == true",
            numericInput("ESSROL_pc_kappa_period", "Period of Change in Kappa", 50, min = 0),
            numericInput("ESSROL_pc_kappa_newval", "New Value of Kappa", 3 / 5, step = 0.05)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSROL_initparam_delta", "Delta", 0.15, step = 0.05),
          checkboxInput("ESSROL_changeinparam_delta", "Change in Delta?"),
          conditionalPanel(
            condition = "input.ESSROL_changeinparam_delta == true",
            numericInput("ESSROL_pc_delta_period", "Period of Change in Delta", 50, min = 0),
            numericInput("ESSROL_pc_delta_newval", "New Value of Delta", 0.3, step = 0.05)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSROL_initparam_popgrowth", "Population Growth", 0.01, step = 0.01),
          checkboxInput("ESSROL_changeinparam_popgrowth", "Change in Population Growth?"),
          conditionalPanel(
            condition = "input.ESSROL_changeinparam_popgrowth == true",
            numericInput("ESSROL_pc_popgrowth_period", "Period of Change in Population Growth", 50, min = 0),
            numericInput("ESSROL_pc_popgrowth_newval", "New Value of Population Growth", 0.05, step = 0.01)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSROL_initparam_savings", "Savings Rate", 0.2, step = 0.05),
          checkboxInput("ESSROL_changeinparam_savings", "Change in Savings Rate?"),
          conditionalPanel(
            condition = "input.ESSROL_changeinparam_savings == true",
            numericInput("ESSROL_pc_savings_period", "Period of Change in Savings Rate", 50, min = 0),
            numericInput("ESSROL_pc_savings_newval", "New Value of Savings Rate", 0.3, step = 0.05)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSROL_initparam_energyconsumption", "Energy Consupmtion", 0.05, step = 0.05),
          checkboxInput("ESSROL_changeinparam_energyconsumption", "Change in Energy Consupmtion?"),
          conditionalPanel(
            condition = "input.ESSROL_changeinparam_energyconsumption == true",
            numericInput("ESSROL_pc_energyconsumption_period", "Period of Change in Energy Consupmtion", 50, min = 0),
            numericInput("ESSROL_pc_energyconsumption_newval", "New Value of Energy Consupmtion", 0.1, step = 0.05)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSROL_initparam_tfpgrowth", "TFP Growth", 0.02, step = 0.01),
          checkboxInput("ESSROL_changeinparam_tfpgrowth", "Change in TFP Growth?"),
          conditionalPanel(
            condition = "input.ESSROL_changeinparam_tfpgrowth == true",
            numericInput("ESSROL_pc_tfpgrowth_period", "Period of Change in TFP Growth", 50, min = 0),
            numericInput("ESSROL_pc_tfpgrowth_newval", "New Value of TFP Growth", 0.05, step = 0.01)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSROL_initparam_land", "Land", 1, step = 1),
          checkboxInput("ESSROL_changeinparam_land", "Change in Land?"),
          conditionalPanel(
            condition = "input.ESSROL_changeinparam_land == true",
            numericInput("ESSROL_pc_land_period", "Period of Change in Land", 50, min = 0),
            numericInput("ESSROL_pc_land_newval", "New Value of Land", 3, step = 1)
          ),
          hr()
        )
      )
    ),
    # Main Panel  ---------------------------------
    mainPanel(
      # Model Equations  ---------------------------------
      titlePanel("Model Equations"),
      withMathJax(),
      # insert math here
      '$$
\\\\begin{aligned}
Y_t &= K_t^\\\\alpha  * (A_t * L_t)^{(1- \\\\beta)} * X^\\\\kappa * E_t^\\\\varepsilon : \\\\alpha + \\\\beta  + \\\\kappa + \\\\varepsilon = 1 \\\\\\\\
E_t &= s_ER_t\\\\\\\\
R_t &= R_{t-1} - E_{t-1}\\\\\\\\
K_{t+1} &= s_KY_t + (1-\\\\delta)K_{t} \\\\\\\\
L_{t+1}&=(1+n)L_t \\\\\\\\
A_{t+1}&=(1+g)A_t \\\\\\\\
\\\\end{aligned}
$$',
      # Visualisation  ---------------------------------
      # textOutput("test"),
      titlePanel("Simulation"),
      plotOutput("ESSROL_Viz", height = "1000px"),
      # Model Simulation Data ---------------------------------
      titlePanel("Simulation Data"),
      dataTableOutput("ESSROL_Data"),
      # Correctness Checker ---------------------------------
      titlePanel("How does the simulation compare to the theoretic steady state values?"),
      dataTableOutput("ESSROL_Correctness_Table")
    )
  ))
