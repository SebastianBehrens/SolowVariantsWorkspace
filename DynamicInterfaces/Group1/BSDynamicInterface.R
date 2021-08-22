BSDynamicInterface <- 
    conditionalPanel(condition = "input.ComparingModels_VariantSelection1 == 'BS'",
                                       # Starting Values ---------------------------------
                                       titlePanel("Starting Values of Stocks"),
                                       # StartingValuesCodeAutoFillLineIndexer
numericInput("ComparingModels1_BS_initval_K", "Initial Value of Physical Capital", 1),
numericInput("ComparingModels1_BS_initval_L", "Initial Value of Labor", 1),
                                       
                                       titlePanel("Parameter Values"),
                                       # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ComparingModels1_BS_parameterchange_valuebefore_TFP", "TFP", 1, step = 1),
checkboxInput("ComparingModels1_BS_parameterchange_indicator_TFP", "Change in TFP?"),
conditionalPanel(
    condition = "input.ComparingModels1_BS_parameterchange_indicator_TFP == true", 
    numericInput("ComparingModels1_BS_parameterchange_period_TFP", "Period of Change in TFP", 50, min = 0),
    numericInput("ComparingModels1_BS_parameterchange_valueafter_TFP", "New Value of TFP", 3, step = 1)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_BS_parameterchange_valuebefore_alpha", "Alpha", 2/5, step = 0.05),
checkboxInput("ComparingModels1_BS_parameterchange_indicator_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ComparingModels1_BS_parameterchange_indicator_alpha == true", 
    numericInput("ComparingModels1_BS_parameterchange_period_alpha", "Period of Change in Alpha", 50, min = 0),
    numericInput("ComparingModels1_BS_parameterchange_valueafter_alpha", "New Value of Alpha", 3/5, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_BS_parameterchange_valuebefore_delta", "Delta", 0.15, step = 0.05),
checkboxInput("ComparingModels1_BS_parameterchange_indicator_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.ComparingModels1_BS_parameterchange_indicator_delta == true", 
    numericInput("ComparingModels1_BS_parameterchange_period_delta", "Period of Change in Delta", 50, min = 0),
    numericInput("ComparingModels1_BS_parameterchange_valueafter_delta", "New Value of Delta", 0.3, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_BS_parameterchange_valuebefore_popgrowth", "Population Growth", 0.01, step = 0.01),
checkboxInput("ComparingModels1_BS_parameterchange_indicator_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ComparingModels1_BS_parameterchange_indicator_popgrowth == true", 
    numericInput("ComparingModels1_BS_parameterchange_period_popgrowth", "Period of Change in Population Growth", 50, min = 0),
    numericInput("ComparingModels1_BS_parameterchange_valueafter_popgrowth", "New Value of Population Growth", 0.05, step = 0.01)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_BS_parameterchange_valuebefore_savings", "Savings Rate", 0.2, step = 0.05),
checkboxInput("ComparingModels1_BS_parameterchange_indicator_savings", "Change in Savings Rate?"),
conditionalPanel(
    condition = "input.ComparingModels1_BS_parameterchange_indicator_savings == true", 
    numericInput("ComparingModels1_BS_parameterchange_period_savings", "Period of Change in Savings Rate", 50, min = 0),
    numericInput("ComparingModels1_BS_parameterchange_valueafter_savings", "New Value of Savings Rate", 0.3, step = 0.05)),
hr(),
                                       
)
