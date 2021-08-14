tabPanel("panetitle", fluid = TRUE, sidebarLayout(
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
                            # StartingValuesCodeAutoFillLineIndexer
                     ),
                     column(width = 6,
                            # Parameters ---------------------------------
                            titlePanel("Parameter Values"),
                            # Periods ---------------------------------
                            numericInput("ESHC_nperiods_selected", "Periods", 200, step = 20),
                            hr(),
                            # ParameterCodeAutoFillLineIndexer
                            
                            # removecomma
                     )
                 )),
    # Main Panel  ---------------------------------
    mainPanel(
        # Model Equations  ---------------------------------
        titlePanel("Model Equations"),
        withMathJax(),
# insert math here        
        p('insertmathhere'),
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
)),
