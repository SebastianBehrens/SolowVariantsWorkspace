GSDynamicInterface <- conditionalPanel(condition = "input.ComparingModels_VariantSelection1 == 'GS'",
                                       # Starting Values ---------------------------------
                                       titlePanel("Starting Values of Stocks"),
                                       # StartingValuesCodeAutoFillLineIndexer
numericInput("ComparingModels1_GS_initval_A", "Initial Value of _____________", 5),
numericInput("ComparingModels1_GS_initval_K", "Initial Value of _____________", 5),
numericInput("ComparingModels1_GS_initval_L", "Initial Value of _____________", 5),
                                       
                                       titlePanel("Parameter Values"),
                                       # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ComparingModels_GS_parameterchange_valuebefore_tfpgrowth", "TFP Growth", 0.3, step = 0.05),
checkboxInput("ComparingModels_GS_parameterchange_indicator_tfpgrowth", "Change in TFP Growth?"),
conditionalPanel(
    condition = "input.ComparingModels_GS_parameterchange_indicator_tfpgrowth == true", 
    numericInput("ComparingModels_GS_parameterchange_period_tfpgrowth", "Period of Change in TFP Growth", 10, min = 0, max = 50),
    numericInput("ComparingModels_GS_parameterchange_valueafter_tfpgrowth", "New Value of TFP Growth", 0.4, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels_GS_parameterchange_valuebefore_alpha", "Alpha", 0.3, step = 0.05),
checkboxInput("ComparingModels_GS_parameterchange_indicator_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ComparingModels_GS_parameterchange_indicator_alpha == true", 
    numericInput("ComparingModels_GS_parameterchange_period_alpha", "Period of Change in Alpha", 10, min = 0, max = 50),
    numericInput("ComparingModels_GS_parameterchange_valueafter_alpha", "New Value of Alpha", 0.4, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels_GS_parameterchange_valuebefore_delta", "Delta", 0.3, step = 0.05),
checkboxInput("ComparingModels_GS_parameterchange_indicator_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.ComparingModels_GS_parameterchange_indicator_delta == true", 
    numericInput("ComparingModels_GS_parameterchange_period_delta", "Period of Change in Delta", 10, min = 0, max = 50),
    numericInput("ComparingModels_GS_parameterchange_valueafter_delta", "New Value of Delta", 0.4, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels_GS_parameterchange_valuebefore_popgrowth", "Population Growth", 0.3, step = 0.05),
checkboxInput("ComparingModels_GS_parameterchange_indicator_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ComparingModels_GS_parameterchange_indicator_popgrowth == true", 
    numericInput("ComparingModels_GS_parameterchange_period_popgrowth", "Period of Change in Population Growth", 10, min = 0, max = 50),
    numericInput("ComparingModels_GS_parameterchange_valueafter_popgrowth", "New Value of Population Growth", 0.4, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels_GS_parameterchange_valuebefore_savings", "Savings Rate", 0.3, step = 0.05),
checkboxInput("ComparingModels_GS_parameterchange_indicator_savings", "Change in Savings Rate?"),
conditionalPanel(
    condition = "input.ComparingModels_GS_parameterchange_indicator_savings == true", 
    numericInput("ComparingModels_GS_parameterchange_period_savings", "Period of Change in Savings Rate", 10, min = 0, max = 50),
    numericInput("ComparingModels_GS_parameterchange_valueafter_savings", "New Value of Savings Rate", 0.4, step = 0.05)),
hr(),
                                       
)
