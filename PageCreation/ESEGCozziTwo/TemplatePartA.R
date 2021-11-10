ESEGCozziTwoTab <- 
    tabPanel("Extended Solow Model (Endogenous Growth Cozzi Hybrid Model)", fluid = TRUE, sidebarLayout(
    # Sidebar Panel  ---------------------------------
    sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height:90%;padding-bottom:100px;",
                 fluidRow(
                     column(width = 6,
                            # Variable Selector ---------------------------------
                            titlePanel("Variables"),
                            checkboxGroupInput("ESEGCozziTwo_vtv", 
                                               label = "",
                                               choices = getModelVars("ESEGCozziTwo"), 
                                               selected = getModelVars("ESEGCozziTwo")[1:5]
                            ),
                            hr(),
                            # Scale Selector ---------------------------------
                            selectInput("ESEGCozziTwo_scales_free_or_fixed",label = "scales free or fixed?", choices = c("fixed", "free"), selected = "free"),
                            hr()
                     ),
                     column(width = 6,
                            # Periods ---------------------------------
                            numericInput("ESEGCozziTwo_nperiods_selected", "Periods", 200, step = 20),
                            hr(),
                            # Starting Values ---------------------------------
                            titlePanel("Starting Values of Stocks"),
                            # StartingValuesCodeAutoFillLineIndexer
                            
                            # Parameters ---------------------------------
                            titlePanel("Parameter Values"),
                            # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ESEGCozziTwo_initparam_k", "k", 0.5, step = 0.05),
checkboxInput("ESEGCozziTwo_changeinparam_k", "Change in k?"),
conditionalPanel(
    condition = "input.ESEGCozziTwo_changeinparam_k == true", 
    numericInput("ESEGCozziTwo_pc_k_period", "Period of Change in k", 50, min = 0),
    numericInput("ESEGCozziTwo_pc_k_newval", "New Value of k", 0.75, step = 0.05)),
hr()



                            
                     )
                 )),
    # Main Panel  ---------------------------------
    mainPanel(
        # Model Equations  ---------------------------------
        titlePanel("Model Equations"),
        withMathJax(),
        aux_modelmath,
        # Visualisation  ---------------------------------
        # textOutput("test"),
        titlePanel("Simulation"),
        plotOutput("ESEGCozziTwo_Viz", height = "1000px"),
        # Model Simulation Data ---------------------------------
        titlePanel("Simulation Data"),
        dataTableOutput("ESEGCozziTwo_Data"),
        # Correctness Checker ---------------------------------
        titlePanel("How does the simulation compare to the theoretic steady state values?"),
        dataTableOutput("ESEGCozziTwo_Correctness_Table")
    )  
    )
    )
