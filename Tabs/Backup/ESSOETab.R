ESSOETab <-
  tabPanel("Extended Solow Model (Small Open Economy)", fluid = TRUE, sidebarLayout(
    # Sidebar Panel  ---------------------------------
    sidebarPanel(
      width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height:90%;padding-bottom:100px;",
      fluidRow(
        column(
          width = 6,
          # Variable Selector ---------------------------------
          titlePanel("Variables"),
          checkboxGroupInput("ESSOE_vtv",
            label = "",
            choices = meta_ESSOE_variables,
            selected = meta_ESSOE_variables[1:5]
          ),
          hr(),
          # Scale Selector ---------------------------------
          selectInput("ESSOE_scales_free_or_fixed", label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
          hr()
        ),
        column(
          width = 6,
          # Periods ---------------------------------
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
            numericInput("ESSOE_pc_TFP_newval", "New Value of TFP", 3, step = 1)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSOE_initparam_alpha", "Alpha", 2 / 5, step = 0.05),
          checkboxInput("ESSOE_changeinparam_alpha", "Change in Alpha?"),
          conditionalPanel(
            condition = "input.ESSOE_changeinparam_alpha == true",
            numericInput("ESSOE_pc_alpha_period", "Period of Change in Alpha", 50, min = 0),
            numericInput("ESSOE_pc_alpha_newval", "New Value of Alpha", 3 / 5, step = 0.05)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSOE_initparam_popgrowth", "Population Growth", 0.01, step = 0.01),
          checkboxInput("ESSOE_changeinparam_popgrowth", "Change in Population Growth?"),
          conditionalPanel(
            condition = "input.ESSOE_changeinparam_popgrowth == true",
            numericInput("ESSOE_pc_popgrowth_period", "Period of Change in Population Growth", 50, min = 0),
            numericInput("ESSOE_pc_popgrowth_newval", "New Value of Population Growth", 0.05, step = 0.01)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSOE_initparam_savings", "Savings Rate", 0.2, step = 0.05),
          checkboxInput("ESSOE_changeinparam_savings", "Change in Savings Rate?"),
          conditionalPanel(
            condition = "input.ESSOE_changeinparam_savings == true",
            numericInput("ESSOE_pc_savings_period", "Period of Change in Savings Rate", 50, min = 0),
            numericInput("ESSOE_pc_savings_newval", "New Value of Savings Rate", 0.3, step = 0.05)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSOE_initparam_realint", "Real Interest Rate", 0.03, step = 0.01),
          checkboxInput("ESSOE_changeinparam_realint", "Change in Real Interest Rate?"),
          conditionalPanel(
            condition = "input.ESSOE_changeinparam_realint == true",
            numericInput("ESSOE_pc_realint_period", "Period of Change in Real Interest Rate", 50, min = 0),
            numericInput("ESSOE_pc_realint_newval", "New Value of Real Interest Rate", 0.05, step = 0.01)
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
Y_t &= BK_t^\\\\\\\\alpha L_t^{1-\\\\\\\\alpha} \\\\\\\\\\\\\\\\
Y_n &= Y_t + \\\\\\\\bar{r}F_t \\\\\\\\\\\\\\\\
V_t &= K_t + F_t\\\\\\\\\\\\\\\\
r_t &= \\\\\\\\alpha B \\\\\\\\left(\\\\\\\\frac{K_t}{L_t}\\\\\\\\right)^{\\\\\\\\alpha -1}\\\\\\\\\\\\\\\\
w_t &= (1-\\\\\\\\alpha) B \\\\\\\\left(\\\\\\\\frac{K_t}{L_t}\\\\\\\\right)^\\\\\\\\alpha \\\\\\\\\\\\\\\\
S_t &= sY_t \\\\\\\\\\\\\\\\
S_t &= V_{t+1} - V_t\\\\\\\\\\\\\\\\
L_{t+1}&=(1+n)L_t \\\\\\\\\\\\\\\\
\\\\\\\\end{aligned}
$$',
      # Visualisation  ---------------------------------
      # textOutput("test"),
      titlePanel("Simulation"),
      plotOutput("ESSOE_Viz", height = "1000px"),
      # Model Simulation Data ---------------------------------
      titlePanel("Simulation Data"),
      dataTableOutput("ESSOE_Data"),
      # Correctness Checker ---------------------------------
      titlePanel("How does the simulation compare to the theoretic steady state values?"),
      dataTableOutput("ESSOE_Correctness_Table")
    )
  ))
