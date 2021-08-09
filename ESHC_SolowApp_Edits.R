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
                            selectInput("ESHC_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                            hr(),
                            # Starting Values ---------------------------------
                            titlePanel("Starting Values of Stocks"),
                            numericInput("ESHC_initval_L", "Initial Value of Labor Stock", 5),
                            numericInput("ESHC_initval_K", "Initial Value of Physical Capital", 5),
                            numericInput("ESHC_initval_H", "Initial Value of Human Capital", 5),
                            numericInput("ESHC_initval_A", "Initial Value of TFP", 5)
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
                            hr(),
                            # TFP Growth ---------------------------------
                            numericInput("ESHC_initparam_tfpgrowth", "Population Growth", 0.02, step = 0.01),
                            checkboxInput("ESHC_changeinparam_tfpgrowth", "Change in Population Growth?"),
                            conditionalPanel(
                                condition = "input.ESHC_changeinparam_tfpgrowth == true", 
                                numericInput("ESHC_pc_tfpgrowth_period", "Period of Change in TFP Growth", 10, min = 0, max = 50),
                                numericInput("ESHC_pc_tfpgrowth_newval", "New Value of TFP Growth", 0.2, step = 0.05)),
                            hr(),
                            # Delta ---------------------------------
                            numericInput("ESHC_initparam_delta", "Delta", 0.02, step = 0.01),
                            checkboxInput("ESHC_changeinparam_delta", "Change in Delta?"),
                            conditionalPanel(
                                condition = "input.ESHC_changeinparam_delta == true", 
                                numericInput("ESHC_pc_delta_period", "Period of Change in Delta", 10, min = 0, max = 50),
                                numericInput("ESHC_pc_delta_newval", "New Value of Delta", 0.2, step = 0.05)),
                            hr(),
                            # Real Interest Rate ---------------------------------
                            numericInput("ESHC_initparam_realint", "Real Interest Rate", 0.1, step = 0.05),
                            checkboxInput("ESHC_changeinparam_realint", "Change in the Real Interest Rate?"),
                            conditionalPanel(
                                condition = "input.ESHC_changeinparam_realint == true", 
                                numericInput("ESHC_pc_realint_period", "Period of Change in the Real Interest Rate", 10, min = 0, max = 50),
                                numericInput("ESHC_pc_realint_newval", "New Value of the Real Interest Rate", 0.5, step = 0.05)),
                            hr(),
                            # Savings Rate — Human Capital ---------------------------------
                            numericInput("ESHC_initparam_sH", "Savings Rate to Human Capital", 0.1, step = 0.05),
                            checkboxInput("ESHC_changeinparam_sH", "Change in Savings Rate to Human Capital?"),
                            conditionalPanel(
                                condition = "input.ESHC_changeinparam_sH == true", 
                                numericInput("ESHC_pc_sH_period", "Period of Change in Savings Rate to Human Capital", 10, min = 0, max = 50),
                                numericInput("ESHC_pc_sH_newval", "New Value of Savings Rate to Human Capital", 0.5, step = 0.05)),
                            hr(),
                            # Savings Rate — Physical Capital ---------------------------------
                            numericInput("ESHC_initparam_sK", "Savings Rate", 0.1, step = 0.05),
                            checkboxInput("ESHC_changeinparam_sK", "Change in Savings Rate to Physical Capital?"),
                            conditionalPanel(
                                condition = "input.ESHC_changeinparam_sK == true", 
                                numericInput("ESHC_pc_sK_period", "Period of Change in Savings Rate to Physical Capital", 10, min = 0, max = 50),
                                numericInput("ESHC_pc_sK_newval", "New Value of Savings Rate to Physical Capital", 0.5, step = 0.05)),
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
Y_t &= K_t^\\alpha * H_t^\\phi * (A_t * L_t)^{(1- \\alpha - \\phi)} \\\\
K_{t+1} &= s_KY_t + (1-\\delta)K_{t} \\\\
H_{t+1} &= s_HY_t + (1-\\delta)H_{t} \\\\
L_{t+1}&=(1+n)L_t \\\\
A_{t+1}&=(1+g)A_t \\\\
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









# Names of Parameters ---------------------------------
ESHC_parameternames <- c("alpha", "phi", "n", "g", "sK", "sH", "delta")
# Periods of Changes ---------------------------------
ESHC_parameterchange_period <- c(if(input$ESHC_changeinparam_alpha) input$ESHC_pc_alpha_period else NA, 
                               if(input$ESHC_changeinparam_phi) input$ESHC_pc_phi_period else NA,
                               if(input$ESHC_changeinparam_popgrowth) input$ESHC_pc_popgrowth_period else NA, 
                               if(input$ESHC_changeinparam_tfpgrowth) input$ESHC_pc_tfpgrowth_period else NA, 
                               if(input$ESHC_changeinparam_sK) input$ESHC_pc_sK_period else NA,
                               if(input$ESHC_changeinparam_sH) input$ESHC_pc_sH_period else NA,
                               if(input$ESHC_changeinparam_delta) input$ESHC_pc_delta_period else NA)
# Starting Values of Parameters ---------------------------------
ESHC_parameterchange_valuebefore <- c(input$ESHC_initparam_alpha,
                                    input$ESHC_initparam_phi,
                                    input$ESHC_initparam_popgrowth,
                                    input$ESHC_initparam_tfpgrowth,
                                    input$ESHC_initparam_sK,
                                    input$ESHC_initparam_sH,
                                    input$ESHC_initparam_delta)
# Values of Parameters after Change ---------------------------------
ESHC_parameterchange_valueafter <-c(if(input$ESHC_changeinparam_alpha) input$ESHC_pc_alpha_newval else NA, 
                                    if(input$ESHC_changeinparam_phi) input$ESHC_pc_phi_newval else NA,
                                    if(input$ESHC_changeinparam_popgrowth) input$ESHC_pc_popgrowth_newval else NA, 
                                    if(input$ESHC_changeinparam_tfpgrowth) input$ESHC_pc_tfpgrowth_newval else NA, 
                                    if(input$ESHC_changeinparam_sK) input$ESHC_pc_sK_newval else NA,
                                    if(input$ESHC_changeinparam_sH) input$ESHC_pc_sH_newval else NA,
                                    if(input$ESHC_changeinparam_delta) input$ESHC_pc_delta_newval else NA)
# Creating the Grid ---------------------------------
create_parameter_grid(
    ESHC_parameternames,
    ESHC_parameterchange_valuebefore,
    ESHC_parameterchange_period,
    ESHC_parameterchange_valueafter,
    input$ESHC_nperiods_selected
)















ESHC_vtv_select_encoded <- reactive({
    variable_encoder(input$ESHC_vtv)
})

ESHC_aux_data <- reactive({
    SimulateExtendedSolowModelHumanCapital(ESHC_parametergrid(), input$ESHC_nperiods_selected,
                            list(K = input$ESHC_initval_K, L = input$ESHC_initval_K, A = input$ESHC_initval_A, H = input$ESHC_initval_H))
})

output$ESHC_Data <- renderDataTable({ESHC_aux_data() %>% mutate_all(round, digits = 3)})

output$ESHC_Viz <- renderPlot({
    VisualiseSimulation(ESHC_aux_data(), ESHC_vtv_select_encoded(), input$ESHC_scales_free_or_fixed)
})

ESHC_aux_correcttable <- reactive({
    simulation_correctness_checker(ESHC_aux_data()[nrow(ESHC_aux_data()), ],
                                   ESHC_parametergrid()[nrow(ESHC_parametergrid()), ],
                                   "ESHC")
})
output$ESHC_Correctness_Table <- renderDataTable({
    ESHC_aux_correcttable()
})



