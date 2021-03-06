# Basic Solow Model ---------------------------------
BSTab <- 
  tabPanel("Basic Solow Model", fluid = TRUE,
         sidebarLayout(
           # Sidebar Panel  ---------------------------------
           sidebarPanel(width = 3, style = "position:fixed;width:24%;overflow-y:scroll;max-height: 90%;padding-bottom:100px;",
                        fluidRow(
                          column(width = 6,
                                 # Variable Selector ---------------------------------
                                 titlePanel("Variables"),
                                 checkboxGroupInput("BS_vtv",
                                                    label = "",
                                                    choices = meta_BS_variables,
                                                    selected = meta_BS_variables[1:5]),
                                 hr(),
                                 # Scale Selector ---------------------------------
                                 selectInput("BS_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                                 hr(),
                                 # Starting Values ---------------------------------
                                 titlePanel("Starting Values of Stocks"),
                                 numericInput("BS_initval_L", "Initial Value of Labor Stock", 10),
                                 numericInput("BS_initval_K", "Initial Value of Capital Stock", 10)
                          ),
                          column(width = 6,
                                 # Parameters ---------------------------------
                                 titlePanel("Parameter Values"),
                                 # Periods ---------------------------------
                                 numericInput("BS_nperiods_selected", "Periods", 200, step = 20),
                                 hr(),
                                 # TFP ---------------------------------
                                 numericInput("BS_initval_B", "Initial Value of Technology", 5),
                                 checkboxInput("BS_changeinparam_tfp", "Change in TFP?"),
                                 conditionalPanel(
                                   condition = "input.BS_changeinparam_tfp == true",
                                   numericInput("BS_pc_tfp_period", "Period of Change in TFP", 10, min = 0, max = 50),
                                   numericInput("BS_pc_tfp_newval", "New Value of TFP", 20)),
                                 hr(),
                                 # Alpha ---------------------------------
                                 numericInput("BS_initparam_alpha", "Alpha", 1/3, step = 0.05),
                                 checkboxInput("BS_changeinparam_alpha", "Change in Alpha?"),
                                 conditionalPanel(
                                   condition = "input.BS_changeinparam_alpha == true",
                                   numericInput("BS_pc_alpha_period", "Period of Change in Alpha", 10, min = 0, max = 50),
                                   numericInput("BS_pc_alpha_newval", "New Value of Alpha", 0.5, step = 0.05)),
                                 hr(),
                                 # Delta ---------------------------------
                                 numericInput("BS_initparam_delta", "Delta", 0.1, step = 0.05),
                                 checkboxInput("BS_changeinparam_delta", "Change in Delta?"),
                                 conditionalPanel(
                                   condition = "input.BS_changeinparam_delta == true",
                                   numericInput("BS_pc_delta_period", "Period of Change in Delta", 10, min = 0, max = 50),
                                   numericInput("BS_pc_delta_newval", "New Value of Delta", 0.5, step = 0.05)),
                                 hr(),
                                 # Savings Rate ---------------------------------
                                 numericInput("BS_initparam_savings", "Savings Rate", 0.22, step = 0.05),
                                 checkboxInput("BS_changeinparam_savings", "Change in Savings Rate?"),
                                 conditionalPanel(
                                   condition = "input.BS_changeinparam_savings == true",
                                   numericInput("BS_pc_savings_period", "Period of Change in Savings Rate", 10, min = 0, max = 50),
                                   numericInput("BS_pc_savings_newval", "New Value of Savings Rate", 0.5, step = 0.05)),
                                 hr(),
                                 # Population Growth ---------------------------------
                                 numericInput("BS_initparam_popgrowth", "Population Growth", 0.005, step = 0.005),
                                 checkboxInput("BS_changeinparam_popgrowth", "Change in Population Growth?"),
                                 conditionalPanel(
                                   condition = "input.BS_changeinparam_popgrowth == true",
                                   numericInput("BS_pc_popgrowth_period", "Period of Change in Population Growth", 10, min = 0, max = 50),
                                   numericInput("BS_pc_popgrowth_newval", "New Value of Population Growth", 0.2, step = 0.05)),
                                 hr()
                          )
                        )),
           # Main Panel  ---------------------------------
           mainPanel(
             # Model Equations  ---------------------------------
             titlePanel("Model Equations"),
             withMathJax(),
             p('
               $$\\begin{aligned}
Y_t &= BK_t^\\alpha L_t^{1-\\alpha} \\\\
r_t &= \\alpha B \\left(\\frac{K_t}{L_t}\\right)^{\\alpha -1}\\\\
w_t &= (1-\\alpha) \\left(\\frac{K_t}{L_t}\\right)^\\alpha \\\\
S_t &= sY_t \\\\
K_{t+1}&= sY_t + (1-\\delta)K_t \\\\
L_{t+1}&=(1+n)L_t
\\end{aligned}
$$'),
             # Visualisation  ---------------------------------
             # textOutput("test"),
             titlePanel("Simulation"),
             plotOutput("BS_Viz", height = "1000px"),
             # Model Simulation Data ---------------------------------
             titlePanel("Simulation Data"),
             dataTableOutput("BS_Data"),
             # Correctness Checker ---------------------------------
             titlePanel("How does the simulation compare to the theoretic steady state values?"),
             dataTableOutput("BS_Correctness_Table")
             )
         )
)