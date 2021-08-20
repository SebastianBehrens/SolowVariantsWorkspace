ESSMYTab <-
  tabPanel("panetitle", fluid = TRUE, sidebarLayout(
    # Sidebar Panel  ---------------------------------
    sidebarPanel(
      width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height: 90%;",
      fluidRow(
        column(
          width = 6,
          # Variable Selector ---------------------------------
          titlePanel("Variables"),
          checkboxGroupInput("ESSMY_vtv",
            label = "",
            choices = meta_ESSMY_variables,
            selected = meta_ESSMY_variables[1:5]
          ),
          hr(),
          # Scale Selector ---------------------------------
          selectInput("ESSMY_scales_free_or_fixed", label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
          hr(),
          # Starting Values ---------------------------------
          titlePanel("Starting Values of Stocks"),
          # StartingValuesCodeAutoFillLineIndexer
          numericInput("ESSMY_initval_A", "Initial Value of _____________", 1),
          numericInput("ESSMY_initval_K", "Initial Value of _____________", 1),
          numericInput("ESSMY_initval_L", "Initial Value of _____________", 1)
        ),
        column(
          width = 6,
          # Periods ---------------------------------
          numericInput("ESSMY_nperiods_selected", "Periods", 200, step = 20),
          hr(),
          # Parameters ---------------------------------
          titlePanel("Parameter Values"),
          # ParameterCodeAutoFillLineIndexer
          # sectiontitle ---------------------------------
          numericInput("ESSMY_initparam_tfpgrowth", "TFP Growth", 0.3, step = 0.05),
          checkboxInput("ESSMY_changeinparam_tfpgrowth", "Change in TFP Growth?"),
          conditionalPanel(
            condition = "input.ESSMY_changeinparam_tfpgrowth == true",
            numericInput("ESSMY_pc_tfpgrowth_period", "Period of Change in TFP Growth", 10, min = 0, max = 50),
            numericInput("ESSMY_pc_tfpgrowth_newval", "New Value of TFP Growth", 0.4, step = 0.05)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSMY_initparam_popgrowth", "Population Growth", 0.3, step = 0.05),
          checkboxInput("ESSMY_changeinparam_popgrowth", "Change in Population Growth?"),
          conditionalPanel(
            condition = "input.ESSMY_changeinparam_popgrowth == true",
            numericInput("ESSMY_pc_popgrowth_period", "Period of Change in Population Growth", 10, min = 0, max = 50),
            numericInput("ESSMY_pc_popgrowth_newval", "New Value of Population Growth", 0.4, step = 0.05)
          ),
          hr(),



          # sectiontitle ---------------------------------
          numericInput("ESSMY_initparam_sK", "Savings Rate to Physical Capital", 0.3, step = 0.05),
          checkboxInput("ESSMY_changeinparam_sK", "Change in Savings Rate to Physical Capital?"),
          conditionalPanel(
            condition = "input.ESSMY_changeinparam_sK == true",
            numericInput("ESSMY_pc_sK_period", "Period of Change in Savings Rate to Physical Capital", 10, min = 0, max = 50),
            numericInput("ESSMY_pc_sK_newval", "New Value of Savings Rate to Physical Capital", 0.4, step = 0.05)
          ),
          hr()




          # removecomma
        )
      )
    ),
    # Main Panel  ---------------------------------
    mainPanel(
      # Model Equations  ---------------------------------
      titlePanel("Model Equations"),
      withMathJax(),
      # insert math here
      p("insertmathhere"),
      # Visualisation  ---------------------------------
      # textOutput("test"),
      titlePanel("Simulation"),
      plotOutput("ESSMY_Viz", height = "1000px"),
      # Model Simulation Data ---------------------------------
      titlePanel("Simulation Data"),
      dataTableOutput("ESSMY_Data"),
      # Correctness Checker ---------------------------------
      titlePanel("How does the simulation compare to the theoretic steady state values?"),
      dataTableOutput("ESSMY_Correctness_Table")
    )
  ))
