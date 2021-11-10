ESEGCozziTwoDynamicInterface <- 
    conditionalPanel(condition = "input.ComparingModels_VariantSelection1 == 'ESEGCozziTwo'",
                                       # Starting Values ---------------------------------
                                       titlePanel("Starting Values of Stocks"),
                                       # StartingValuesCodeAutoFillLineIndexer
numericInput("ComparingModels1_ESEGCozziTwo_initval_A", "Initial Value of Total Factor Productivity", 1),
numericInput("ComparingModels1_ESEGCozziTwo_initval_K", "Initial Value of Physical Capital", 1),
numericInput("ComparingModels1_ESEGCozziTwo_initval_L", "Initial Value of Labor", 1),
                                       
                                       titlePanel("Parameter Values"),
                                       # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valuebefore_alpha", "Alpha", 1/3, step = 0.05),
checkboxInput("ComparingModels1_ESEGCozziTwo_parameterchange_indicator_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESEGCozziTwo_parameterchange_indicator_alpha == true", 
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_period_alpha", "Period of Change in Alpha", 50, min = 0),
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valueafter_alpha", "New Value of Alpha", 3/5, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valuebefore_phi", "Phi", 1/6, step = 0.05),
checkboxInput("ComparingModels1_ESEGCozziTwo_parameterchange_indicator_phi", "Change in Phi?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESEGCozziTwo_parameterchange_indicator_phi == true", 
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_period_phi", "Period of Change in Phi", 50, min = 0),
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valueafter_phi", "New Value of Phi", 3/5, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valuebefore_lambda", "lambda", 1, step = 0.05),
checkboxInput("ComparingModels1_ESEGCozziTwo_parameterchange_indicator_lambda", "Change in lambda?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESEGCozziTwo_parameterchange_indicator_lambda == true", 
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_period_lambda", "Period of Change in lambda", 50, min = 0),
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valueafter_lambda", "New Value of lambda", 0.8, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valuebefore_rho", "Rho", 0.5, step = 0.1),
checkboxInput("ComparingModels1_ESEGCozziTwo_parameterchange_indicator_rho", "Change in Rho?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESEGCozziTwo_parameterchange_indicator_rho == true", 
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_period_rho", "Period of Change in Rho", 50, min = 0),
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valueafter_rho", "New Value of Rho", 0.6, step = 0.1)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valuebefore_savings", "Savings Rate", 0.2, step = 0.05),
checkboxInput("ComparingModels1_ESEGCozziTwo_parameterchange_indicator_savings", "Change in Savings Rate?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESEGCozziTwo_parameterchange_indicator_savings == true", 
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_period_savings", "Period of Change in Savings Rate", 50, min = 0),
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valueafter_savings", "New Value of Savings Rate", 0.3, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valuebefore_sR", "Prop. Labor Force in R&D", 0.05, step = 0.05),
checkboxInput("ComparingModels1_ESEGCozziTwo_parameterchange_indicator_sR", "Change in Prop. Labor Force in R&D?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESEGCozziTwo_parameterchange_indicator_sR == true", 
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_period_sR", "Period of Change in Prop. Labor Force in R&D", 50, min = 0),
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valueafter_sR", "New Value of Prop. Labor Force in R&D", 0.15, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valuebefore_delta", "Delta", 0.15, step = 0.05),
checkboxInput("ComparingModels1_ESEGCozziTwo_parameterchange_indicator_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESEGCozziTwo_parameterchange_indicator_delta == true", 
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_period_delta", "Period of Change in Delta", 50, min = 0),
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valueafter_delta", "New Value of Delta", 0.3, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valuebefore_popgrowth", "Population Growth", 0.01, step = 0.01),
checkboxInput("ComparingModels1_ESEGCozziTwo_parameterchange_indicator_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESEGCozziTwo_parameterchange_indicator_popgrowth == true", 
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_period_popgrowth", "Period of Change in Population Growth", 50, min = 0),
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valueafter_popgrowth", "New Value of Population Growth", 0.05, step = 0.01)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valuebefore_k", "k", 0.5, step = 0.05),
checkboxInput("ComparingModels1_ESEGCozziTwo_parameterchange_indicator_k", "Change in k?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESEGCozziTwo_parameterchange_indicator_k == true", 
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_period_k", "Period of Change in k", 50, min = 0),
    numericInput("ComparingModels1_ESEGCozziTwo_parameterchange_valueafter_k", "New Value of k", 0.75, step = 0.05)),
hr(),
                                       
)
