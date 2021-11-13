GSTab <-
  tabPanel("General Solow Model", fluid = TRUE, sidebarLayout(
    # Sidebar Panel  ---------------------------------
    sidebarPanel(
      width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height:90%;padding-bottom:100px;",
      fluidRow(
        column(
          width = 6,
          # Variable Selector ---------------------------------
          titlePanel("Variables"),
          checkboxGroupInput("GS_vtv",
            label = "",
            choices = meta_GS_variables,
            selected = meta_GS_variables[1:5]
          ),
          hr(),
          # Scale Selector ---------------------------------
          selectInput("GS_scales_free_or_fixed", label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
          hr()
        ),
        column(
          width = 6,
          # Periods ---------------------------------
          numericInput("GS_nperiods_selected", "Periods", 200, step = 20),
          hr(),
          # Starting Values ---------------------------------
          titlePanel("Starting Values of Stocks"),
          # StartingValuesCodeAutoFillLineIndexer
          numericInput("GS_initval_A", "Initial Value of Total Factor Productivity", 1),
          numericInput("GS_initval_K", "Initial Value of Physical Capital", 1),
          numericInput("GS_initval_L", "Initial Value of Labor", 1),

          # Parameters ---------------------------------
          titlePanel("Parameter Values"),
          # ParameterCodeAutoFillLineIndexer
          # sectiontitle ---------------------------------
          numericInput("GS_initparam_tfpgrowth", "TFP Growth", 0.02, step = 0.01),
          checkboxInput("GS_changeinparam_tfpgrowth", "Change in TFP Growth?"),
          conditionalPanel(
            condition = "input.GS_changeinparam_tfpgrowth == true",
            numericInput("GS_pc_tfpgrowth_period", "Period of Change in TFP Growth", 50, min = 0),
            numericInput("GS_pc_tfpgrowth_newval", "New Value of TFP Growth", 0.05, step = 0.01)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("GS_initparam_alpha", "Alpha", 2 / 5, step = 0.05),
          checkboxInput("GS_changeinparam_alpha", "Change in Alpha?"),
          conditionalPanel(
            condition = "input.GS_changeinparam_alpha == true",
            numericInput("GS_pc_alpha_period", "Period of Change in Alpha", 50, min = 0),
            numericInput("GS_pc_alpha_newval", "New Value of Alpha", 3 / 5, step = 0.05)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("GS_initparam_delta", "Delta", 0.15, step = 0.05),
          checkboxInput("GS_changeinparam_delta", "Change in Delta?"),
          conditionalPanel(
            condition = "input.GS_changeinparam_delta == true",
            numericInput("GS_pc_delta_period", "Period of Change in Delta", 50, min = 0),
            numericInput("GS_pc_delta_newval", "New Value of Delta", 0.3, step = 0.05)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("GS_initparam_popgrowth", "Population Growth", 0.01, step = 0.01),
          checkboxInput("GS_changeinparam_popgrowth", "Change in Population Growth?"),
          conditionalPanel(
            condition = "input.GS_changeinparam_popgrowth == true",
            numericInput("GS_pc_popgrowth_period", "Period of Change in Population Growth", 50, min = 0),
            numericInput("GS_pc_popgrowth_newval", "New Value of Population Growth", 0.05, step = 0.01)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("GS_initparam_savings", "Savings Rate", 0.2, step = 0.05),
          checkboxInput("GS_changeinparam_savings", "Change in Savings Rate?"),
          conditionalPanel(
            condition = "input.GS_changeinparam_savings == true",
            numericInput("GS_pc_savings_period", "Period of Change in Savings Rate", 50, min = 0),
            numericInput("GS_pc_savings_newval", "New Value of Savings Rate", 0.3, step = 0.05)
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
\\\\\\\\begin{aligned}
Y_t &= K_t^\\\\\\\\alpha (A_tL_t)^{1-\\\\\\\\alpha} \\\\\\\\\\\\\\\\
r_t &= \\\\\\\\alpha \\\\\\\\left(\\\\\\\\frac{K_t}{A_tL_t}\\\\\\\\right)^{\\\\\\\\alpha -1}\\\\\\\\\\\\\\\\
w_t &= (1-\\\\\\\\alpha) \\\\\\\\left(\\\\\\\\frac{K_t}{A_tL_t}\\\\\\\\right)^\\\\\\\\alpha A_t\\\\\\\\\\\\\\\\
S_t &= sY_t \\\\\\\\\\\\\\\\
K_{t+1}&= sY_t + (1-\\\\\\\\delta)K_t \\\\\\\\\\\\\\\\
L_{t+1}&=(1+n)L_t \\\\\\\\\\\\\\\\
A_{t+1} &= (1 + g)*A_t
\\\\\\\\end{aligned}
$$',
      # Visualisation  ---------------------------------
      # textOutput("test"),
      titlePanel("Simulation"),
      plotOutput("GS_Viz", height = "1000px"),
      # Model Simulation Data ---------------------------------
      titlePanel("Simulation Data"),
      dataTableOutput("GS_Data"),
      # Correctness Checker ---------------------------------
      titlePanel("How does the simulation compare to the theoretic steady state values?"),
      dataTableOutput("GS_Correctness_Table")
    )
  ))
