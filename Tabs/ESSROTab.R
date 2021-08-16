ESSROTab <- 
  # Extended Solow Model (Scarce Resources — Oil) ---------------------------------
  tabPanel("Extended Solow Model (Scarce Resources — Oil)", fluid = TRUE,  sidebarLayout(
    # Sidebar Panel  ---------------------------------
    sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height: 90%;",
                 fluidRow(
                   column(width = 6,
                          # Variable Selector ---------------------------------
                          titlePanel("Variables"),
                          checkboxGroupInput("ESSRO_vtv",
                                             label = "",
                                             choices = meta_ESSRO_variables,
                                             selected = meta_ESSRO_variables[1:5]),
                          hr(),
                          # Periods ---------------------------------
                          numericInput("ESSRO_nperiods_selected", "Periods", 200, step = 20),
                          hr(),
                          # Scale Selector ---------------------------------
                          selectInput("ESSRO_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                          hr(),
                          # Starting Values ---------------------------------
                          titlePanel("Starting Values of Stocks"),
                          # StartingValuesCodeAutoFillLineIndexer
                          numericInput("ESSRO_initval_A", "Initial Value of TFP", 5),
                          numericInput("ESSRO_initval_K", "Initial Value of Capital", 5),
                          numericInput("ESSRO_initval_L", "Initial Value of Labor", 5),
                          numericInput("ESSRO_initval_R", "Initial Value of the Oil Stock", 5)
                   ),
                   column(width = 6,
                          # Parameters ---------------------------------
                          titlePanel("Parameter Values"),
                          # ParameterCodeAutoFillLineIndexer
                          # sectiontitle ---------------------------------
                          numericInput("ESSRO_initparam_alpha", "Alpha", 0.3, step = 0.05),
                          checkboxInput("ESSRO_changeinparam_alpha", "Change in Alpha?"),
                          conditionalPanel(
                            condition = "input.ESSRO_changeinparam_alpha == true",
                            numericInput("ESSRO_pc_alpha_period", "Period of Change in Alpha", 10, min = 0, max = 50),
                            numericInput("ESSRO_pc_alpha_newval", "New Value of Alpha", 0.4, step = 0.05)),
                          hr(),
                          # sectiontitle ---------------------------------
                          numericInput("ESSRO_initparam_beta", "Beta", 0.3, step = 0.05),
                          checkboxInput("ESSRO_changeinparam_beta", "Change in Beta?"),
                          conditionalPanel(
                            condition = "input.ESSRO_changeinparam_beta == true",
                            numericInput("ESSRO_pc_beta_period", "Period of Change in Beta", 10, min = 0, max = 50),
                            numericInput("ESSRO_pc_beta_newval", "New Value of Beta", 0.4, step = 0.05)),
                          hr(),
                          # sectiontitle ---------------------------------
                          numericInput("ESSRO_initparam_popgrowth", "Population Growth", 0.05, step = 0.05),
                          checkboxInput("ESSRO_changeinparam_popgrowth", "Change in Population Growth?"),
                          conditionalPanel(
                            condition = "input.ESSRO_changeinparam_popgrowth == true",
                            numericInput("ESSRO_pc_popgrowth_period", "Period of Change in Population Growth", 10, min = 0, max = 50),
                            numericInput("ESSRO_pc_popgrowth_newval", "New Value of Population Growth", 0.4, step = 0.05)),
                          hr(),
                          # sectiontitle ---------------------------------
                          numericInput("ESSRO_initparam_tfpgrowth", "TFP Growth", 0.02, step = 0.01),
                          checkboxInput("ESSRO_changeinparam_tfpgrowth", "Change in TFP Growth?"),
                          conditionalPanel(
                            condition = "input.ESSRO_changeinparam_tfpgrowth == true",
                            numericInput("ESSRO_pc_tfpgrowth_period", "Period of Change in TFP Growth", 10, min = 0, max = 50),
                            numericInput("ESSRO_pc_tfpgrowth_newval", "New Value of TFP Growth", 0.4, step = 0.01)),
                          hr(),
                          # sectiontitle ---------------------------------
                          numericInput("ESSRO_initparam_energyconsumption", "Energy Consupmtion", 0.05, step = 0.01),
                          checkboxInput("ESSRO_changeinparam_energyconsumption", "Change in Energy Consupmtion?"),
                          conditionalPanel(
                            condition = "input.ESSRO_changeinparam_energyconsumption == true",
                            numericInput("ESSRO_pc_energyconsumption_period", "Period of Change in Energy Consupmtion", 10, min = 0, max = 50),
                            numericInput("ESSRO_pc_energyconsumption_newval", "New Value of Energy Consupmtion", 0.4, step = 0.05)),
                          hr(),
                          # sectiontitle ---------------------------------
                          numericInput("ESSRO_initparam_savings", "Savings Rate", 0.2, step = 0.05),
                          checkboxInput("ESSRO_changeinparam_savings", "Change in Savings Rate?"),
                          conditionalPanel(
                            condition = "input.ESSRO_changeinparam_savings == true",
                            numericInput("ESSRO_pc_savings_period", "Period of Change in Savings Rate", 10, min = 0, max = 50),
                            numericInput("ESSRO_pc_savings_newval", "New Value of Savings Rate", 0.4, step = 0.05)),
                          hr(),
                          # sectiontitle ---------------------------------
                          numericInput("ESSRO_initparam_delta", "Delta", 0.15, step = 0.05),
                          checkboxInput("ESSRO_changeinparam_delta", "Change in Delta?"),
                          conditionalPanel(
                            condition = "input.ESSRO_changeinparam_delta == true",
                            numericInput("ESSRO_pc_delta_period", "Period of Change in Delta", 10, min = 0, max = 50),
                            numericInput("ESSRO_pc_delta_newval", "New Value of Delta", 0.4, step = 0.05)),
                          hr(),
                          )
                 )),
    # Main Panel  ---------------------------------
    mainPanel(
      # Model Equations  ---------------------------------
      titlePanel("Model Equations"),
      withMathJax(),
      '$$
            \\begin{aligned}
          Y_t &= K_t^\\alpha  * (A_t * L_t)^{(1- \\beta)} * E_t^\\varepsilon: \\alpha + \\beta + \\varepsilon = 1 \\\\
          E_t &= s_ER_t\\\\
          R_t &= R_{t-1} - E_{t-1}\\\\
          K_{t+1} &= s_KY_t + (1-\\delta)K_{t} \\\\
          L_{t+1}&=(1+n)L_t \\\\
          A_{t+1}&=(1+g)A_t \\\\
          \\end{aligned}
          $$',
      # Visualisation  ---------------------------------
      # textOutput("test"),
      titlePanel("Simulation"),
      plotOutput("ESSRO_Viz", height = "1000px"),
      # Model Simulation Data ---------------------------------
      titlePanel("Simulation Data"),
      dataTableOutput("ESSRO_Data"),
      # Correctness Checker ---------------------------------
      # titlePanel("How does the simulation compare to the theoretic steady state values?"),
      # dataTableOutput("ESSRO_Correctness_Table")
      # "To be added."
    )
  ))
