sidebarLayout(
    # Sidebar Panel  ---------------------------------
    sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height: 90%;",
                 fluidRow(
                     column(width = 6,
                            # Variable Selector ---------------------------------
                            titlePanel("Variables"),
                            checkboxGroupInput("ESHC_vtv", 
                                               label = "",
                                               choices = meta_ESHC_variables, 
                                               selected = meta_ESHC_variables[1:5]),
                            hr(),
                            # Scale Selector ---------------------------------
                            selectInput("ESSOE_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                            hr(),
                            # Starting Values ---------------------------------
                            titlePanel("Starting Values of Stocks"),
                            numericInput("ESHC_initval_L", "Initial Value of Labor Stock", 10),
                            numericInput("ESHC_initval_V", "Initial Value of National Wealth", 45)
                     ),
                     column(width = 6,
                            # Parameters ---------------------------------
                            titlePanel("Parameter Values"),
                            # Periods ---------------------------------
                            numericInput("ESHC_nperiods_selected", "Periods", 200, step = 20),
                            hr(),
                            # Alpha ---------------------------------
                            numericInput("ESHC_initparam_alpha", "Alpha", 0.3, step = 0.05),
                            checkboxInput("ESHC_changeinparam_alpha", "Change in Alpha?"),
                            conditionalPanel(
                                condition = "input.ESHC_changeinparam_alpha == true", 
                                numericInput("ESHC_pc_alpha_period", "Period of Change in Alpha", 10, min = 0, max = 50),
                                numericInput("ESHC_pc_alpha_newval", "New Value of Alpha", 0.5, step = 0.05)),
                            hr(),
                            # Phi ---------------------------------
                            numericInput("ESHC_initparam_phi", "Phi", 0.3, step = 0.05),
                            checkboxInput("ESHC_changeinparam_phi", "Change in Phi?"),
                            conditionalPanel(
                                condition = "input.ESHC_changeinparam_phi == true", 
                                numericInput("ESHC_pc_phi_period", "Period of Change in Phi", 10, min = 0, max = 50),
                                numericInput("ESHC_pc_phi_newval", "New Value of Phi", 0.5, step = 0.05)),
                            hr(),
                            # Population Growth ---------------------------------
                            numericInput("ESHC_initparam_popgrowth", "Population Growth", 0.1, step = 0.05),
                            checkboxInput("ESHC_changeinparam_popgrowth", "Change in Population Growth?"),
                            conditionalPanel(
                                condition = "input.ESHC_changeinparam_popgrowth == true", 
                                numericInput("ESHC_pc_popgrowth_period", "Period of Change in Population Growth", 10, min = 0, max = 50),
                                numericInput("ESHC_pc_popgrowth_newval", "New Value of Population Growth", 0.2, step = 0.05)),
                            hr()
                            # TFP Growth ---------------------------------
                            numericInput("ESHC_initparam_tfpgrowth", "Population Growth", 0.1, step = 0.05),
                            checkboxInput("ESHC_changeinparam_tfpgrowth", "Change in Population Growth?"),
                            conditionalPanel(
                                condition = "input.ESHC_changeinparam_tfpgrowth == true", 
                                numericInput("ESHC_pc_tfpgrowth_period", "Period of Change in TFP Growth", 10, min = 0, max = 50),
                                numericInput("ESHC_pc_tfpgrowth_newval", "New Value of Population Growth", 0.2, step = 0.05)),
                            hr()
                            # Real Interest Rate ---------------------------------
                            numericInput("ESHC_initparam_realint", "Real Interest Rate", 0.1, step = 0.05),
                            checkboxInput("ESHC_changeinparam_realint", "Change in the Real Interest Rate?"),
                            conditionalPanel(
                                condition = "input.ESHC_changeinparam_realint == true", 
                                numericInput("ESHC_pc_realint_period", "Period of Change in the Real Interest Rate", 10, min = 0, max = 50),
                                numericInput("ESHC_pc_realint_newval", "New Value of the Real Interest Rate", 0.5, step = 0.05)),
                            hr(),
                            # Savings Rate ---------------------------------
                            numericInput("ESHC_initparam_savings", "Savings Rate", 0.1, step = 0.05),
                            checkboxInput("ESHC_changeinparam_savings", "Change in Savings Rate?"),
                            conditionalPanel(
                                condition = "input.ESHC_changeinparam_savings == true", 
                                numericInput("ESHC_pc_savings_period", "Period of Change in Savings Rate", 10, min = 0, max = 50),
                                numericInput("ESHC_pc_savings_newval", "New Value of Savings Rate", 0.5, step = 0.05)),
                            hr(),
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
Y_t &= BK_t^\\alpha L_t^{1-\\alpha} \\\\
Y_n &= Y_t + \\bar{r}F_t \\\\
V_t &= K_t + F_t\\\\
r_t &= \\alpha B \\left(\\frac{K_t}{L_t}\\right)^{\\alpha -1}\\\\
w_t &= (1-\\alpha) B \\left(\\frac{K_t}{L_t}\\right)^\\alpha \\\\
S_t &= sY_t \\\\
S_t &= V_{t+1} - V_t\\\\
L_{t+1}&=(1+n)L_t \\\\
\\end{aligned}$$'),
        # Visualisation  ---------------------------------
        # textOutput("test"),
        titlePanel("Simulation"),
        plotOutput("ESHC_Viz", height = "1000px"),
        # Model Simulation Data ---------------------------------
        titlePanel("Simulation Data"),
        dataTableOutput("ESHC_Data"),
        # Correctness Checker ---------------------------------
        titlePanel("How does the simulation compare to the theoretic steady state values?"),
        dataTableOutput("ESHC_Correctness_Table")
    )  
)