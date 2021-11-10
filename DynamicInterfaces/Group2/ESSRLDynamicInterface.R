ESSRLDynamicInterface <- 
    conditionalPanel(condition = "input.ComparingModels_VariantSelection2 == 'ESSRL'",
                                       # Starting Values ---------------------------------
                                       titlePanel("Starting Values of Stocks"),
                                       # StartingValuesCodeAutoFillLineIndexer
numericInput("ComparingModels2_ESSRL_initval_A", "Initial Value of Total Factor Productivity", 1),
numericInput("ComparingModels2_ESSRL_initval_K", "Initial Value of Physical Capital", 1),
numericInput("ComparingModels2_ESSRL_initval_L", "Initial Value of Labor", 1),
                                       
                                       titlePanel("Parameter Values"),
                                       # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ComparingModels2_ESSRL_parameterchange_valuebefore_alpha", "Alpha", 1/3, step = 0.05),
checkboxInput("ComparingModels2_ESSRL_parameterchange_indicator_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ComparingModels2_ESSRL_parameterchange_indicator_alpha == true", 
    numericInput("ComparingModels2_ESSRL_parameterchange_period_alpha", "Period of Change in Alpha", 50, min = 0),
    numericInput("ComparingModels2_ESSRL_parameterchange_valueafter_alpha", "New Value of Alpha", 3/5, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels2_ESSRL_parameterchange_valuebefore_beta", "Beta", 1/3, step = 0.05),
checkboxInput("ComparingModels2_ESSRL_parameterchange_indicator_beta", "Change in Beta?"),
conditionalPanel(
    condition = "input.ComparingModels2_ESSRL_parameterchange_indicator_beta == true", 
    numericInput("ComparingModels2_ESSRL_parameterchange_period_beta", "Period of Change in Beta", 50, min = 0),
    numericInput("ComparingModels2_ESSRL_parameterchange_valueafter_beta", "New Value of Beta", 3/5, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels2_ESSRL_parameterchange_valuebefore_delta", "Delta", 0.15, step = 0.05),
checkboxInput("ComparingModels2_ESSRL_parameterchange_indicator_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.ComparingModels2_ESSRL_parameterchange_indicator_delta == true", 
    numericInput("ComparingModels2_ESSRL_parameterchange_period_delta", "Period of Change in Delta", 50, min = 0),
    numericInput("ComparingModels2_ESSRL_parameterchange_valueafter_delta", "New Value of Delta", 0.3, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels2_ESSRL_parameterchange_valuebefore_popgrowth", "Population Growth", 0.01, step = 0.01),
checkboxInput("ComparingModels2_ESSRL_parameterchange_indicator_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ComparingModels2_ESSRL_parameterchange_indicator_popgrowth == true", 
    numericInput("ComparingModels2_ESSRL_parameterchange_period_popgrowth", "Period of Change in Population Growth", 50, min = 0),
    numericInput("ComparingModels2_ESSRL_parameterchange_valueafter_popgrowth", "New Value of Population Growth", 0.05, step = 0.01)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels2_ESSRL_parameterchange_valuebefore_savings", "Savings Rate", 0.2, step = 0.05),
checkboxInput("ComparingModels2_ESSRL_parameterchange_indicator_savings", "Change in Savings Rate?"),
conditionalPanel(
    condition = "input.ComparingModels2_ESSRL_parameterchange_indicator_savings == true", 
    numericInput("ComparingModels2_ESSRL_parameterchange_period_savings", "Period of Change in Savings Rate", 50, min = 0),
    numericInput("ComparingModels2_ESSRL_parameterchange_valueafter_savings", "New Value of Savings Rate", 0.3, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels2_ESSRL_parameterchange_valuebefore_tfpgrowth", "TFP Growth", 0.02, step = 0.01),
checkboxInput("ComparingModels2_ESSRL_parameterchange_indicator_tfpgrowth", "Change in TFP Growth?"),
conditionalPanel(
    condition = "input.ComparingModels2_ESSRL_parameterchange_indicator_tfpgrowth == true", 
    numericInput("ComparingModels2_ESSRL_parameterchange_period_tfpgrowth", "Period of Change in TFP Growth", 50, min = 0),
    numericInput("ComparingModels2_ESSRL_parameterchange_valueafter_tfpgrowth", "New Value of TFP Growth", 0.05, step = 0.01)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels2_ESSRL_parameterchange_valuebefore_land", "Land", 1, step = 1),
checkboxInput("ComparingModels2_ESSRL_parameterchange_indicator_land", "Change in Land?"),
conditionalPanel(
    condition = "input.ComparingModels2_ESSRL_parameterchange_indicator_land == true", 
    numericInput("ComparingModels2_ESSRL_parameterchange_period_land", "Period of Change in Land", 50, min = 0),
    numericInput("ComparingModels2_ESSRL_parameterchange_valueafter_land", "New Value of Land", 3, step = 1)),
hr(),
                                       
)
