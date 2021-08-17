GSTab <- 
  
  # General Solow Model ---------------------------------
tabPanel("General Solow Model", fluid = TRUE,
         sidebarLayout(
           # Sidebar Panel  ---------------------------------
           sidebarPanel(width = 3, style = "position:fixed;width:24%;overflow-y:scroll; max-height: 90%;padding-bottom:100px;",
                        fluidRow(
                          column(width = 6,
                                 # Variable Selector ---------------------------------
                                 titlePanel("Variables"),
                                 checkboxGroupInput("GS_vtv",
                                                    label = "",
                                                    choices = meta_GS_variables,
                                                    selected = meta_GS_variables[1:5]),
                                 hr(),
                                 # Scale Selector ---------------------------------
                                 selectInput("GS_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                                 hr(),
                                 # Starting Values ---------------------------------
                                 titlePanel("Starting Values of Stocks"),
                                 numericInput("GS_initval_L", "Initial Value of Labor Stock", 10),
                                 numericInput("GS_initval_K", "Initial Value of Capital Stock", 10),
                                 numericInput("GS_initval_A", "Initial Value of TFP", 10)
                          ),
                          column(width = 6,
                                 # Parameters ---------------------------------
                                 titlePanel("Parameter Values"),
                                 # Periods ---------------------------------
                                 numericInput("GS_nperiods_selected", "Periods", 200, step = 20),
                                 hr(),
                                 # TFP ---------------------------------
                                 numericInput("GS_initparam_g", "g", 0.1, step = 0.05),
                                 ## Remark: Exogeneous Shocks in GSM to be added
                                 checkboxInput("GS_changeinparam_g", "Change in g?"),
                                 conditionalPanel(
                                   condition = "input.GS_changeinparam_g == true",
                                   numericInput("GS_pc_g_period", "Period of Change in g", 10, min = 0, max = 50),
                                   numericInput("GS_pc_g_newval", "New Value of g", 0.3, step = 0.05)),
                                 hr(),
                                 # Alpha ---------------------------------
                                 numericInput("GS_initparam_alpha", "Alpha", 0.3, step = 0.05),
                                 checkboxInput("GS_changeinparam_alpha", "Change in Alpha?"),
                                 conditionalPanel(
                                   condition = "input.GS_changeinparam_alpha == true",
                                   numericInput("GS_pc_alpha_period", "Period of Change in Alpha", 10, min = 0, max = 50),
                                   numericInput("GS_pc_alpha_newval", "New Value of Alpha", 0.5, step = 0.05)),
                                 hr(),
                                 # Delta ---------------------------------
                                 numericInput("GS_initparam_delta", "Delta", 0.1, step = 0.05),
                                 checkboxInput("GS_changeinparam_delta", "Change in Delta?"),
                                 conditionalPanel(
                                   condition = "input.GS_changeinparam_delta == true",
                                   numericInput("GS_pc_delta_period", "Period of Change in Delta", 10, min = 0, max = 50),
                                   numericInput("GS_pc_delta_newval", "New Value of Delta", 0.5, step = 0.05)),
                                 hr(),
                                 # Savings Rate ---------------------------------
                                 numericInput("GS_initparam_savings", "Savings Rate", 0.1, step = 0.05),
                                 checkboxInput("GS_changeinparam_savings", "Change in Savings Rate?"),
                                 conditionalPanel(
                                   condition = "input.GS_changeinparam_savings == true",
                                   numericInput("GS_pc_savings_period", "Period of Change in Savings Rate", 10, min = 0, max = 50),
                                   numericInput("GS_pc_savings_newval", "New Value of Savings Rate", 0.5, step = 0.05)),
                                 hr(),
                                 # Population Growth ---------------------------------
                                 numericInput("GS_initparam_popgrowth", "Population Growth", 0.1, step = 0.05),
                                 checkboxInput("GS_changeinparam_popgrowth", "Change in Population Growth?"),
                                 conditionalPanel(
                                   condition = "input.GS_changeinparam_popgrowth == true",
                                   numericInput("GS_pc_popgrowth_period", "Period of Change in Population Growth", 10, min = 0, max = 50),
                                   numericInput("GS_pc_popgrowth_newval", "New Value of Population Growth", 0.2, step = 0.05)),
                                 hr()
                          )
                        )),
           # Main Panel  ---------------------------------
           mainPanel(
             # Model Equations  ---------------------------------
             titlePanel("Model Equations"),
             withMathJax(),
             p('
               $$
\\begin{aligned}
Y_t &= K_t^\\alpha (A_tL_t)^{1-\\alpha} \\\\
r_t &= \\alpha \\left(\\frac{K_t}{A_tL_t}\\right)^{\\alpha -1}\\\\
w_t &= (1-\\alpha) \\left(\\frac{K_t}{A_tL_t}\\right)^\\alpha A_t\\\\
S_t &= sY_t \\\\
K_{t+1}&= sY_t + (1-\\delta)K_t \\\\
L_{t+1}&=(1+n)L_t \\\\
A_{t+1} &= (1 + g)*A_t
\\end{aligned}
$$'),
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
         )
)