ESSOEDynamicInterface <- 
    conditionalPanel(condition = "input.ComparingModels_VariantSelection1 == 'ESSOE'",
                                       # Starting Values ---------------------------------
                                       titlePanel("Starting Values of Stocks"),
                                       # StartingValuesCodeAutoFillLineIndexer
numericInput("ComparingModels1_ESSOE_initval_L", "Initial Value of Labor", 1),
numericInput("ComparingModels1_ESSOE_initval_V", "Initial Value of National Wealth", 1),
                                       
                                       titlePanel("Parameter Values"),
                                       # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESSOE_parameterchange_valuebefore_TFP", "TFP", 1, step = 1),
checkboxInput("ComparingModels1_ESSOE_parameterchange_indicator_TFP", "Change in TFP?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESSOE_parameterchange_indicator_TFP == true", 
    numericInput("ComparingModels1_ESSOE_parameterchange_period_TFP", "Period of Change in TFP", 50, min = 0),
    numericInput("ComparingModels1_ESSOE_parameterchange_valueafter_TFP", "New Value of TFP", 3, step = 1)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESSOE_parameterchange_valuebefore_alpha", "Alpha", 2/5, step = 0.05),
checkboxInput("ComparingModels1_ESSOE_parameterchange_indicator_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESSOE_parameterchange_indicator_alpha == true", 
    numericInput("ComparingModels1_ESSOE_parameterchange_period_alpha", "Period of Change in Alpha", 50, min = 0),
    numericInput("ComparingModels1_ESSOE_parameterchange_valueafter_alpha", "New Value of Alpha", 3/5, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESSOE_parameterchange_valuebefore_popgrowth", "Population Growth", 0.01, step = 0.01),
checkboxInput("ComparingModels1_ESSOE_parameterchange_indicator_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESSOE_parameterchange_indicator_popgrowth == true", 
    numericInput("ComparingModels1_ESSOE_parameterchange_period_popgrowth", "Period of Change in Population Growth", 50, min = 0),
    numericInput("ComparingModels1_ESSOE_parameterchange_valueafter_popgrowth", "New Value of Population Growth", 0.05, step = 0.01)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESSOE_parameterchange_valuebefore_savings", "Savings Rate", 0.2, step = 0.05),
checkboxInput("ComparingModels1_ESSOE_parameterchange_indicator_savings", "Change in Savings Rate?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESSOE_parameterchange_indicator_savings == true", 
    numericInput("ComparingModels1_ESSOE_parameterchange_period_savings", "Period of Change in Savings Rate", 50, min = 0),
    numericInput("ComparingModels1_ESSOE_parameterchange_valueafter_savings", "New Value of Savings Rate", 0.3, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESSOE_parameterchange_valuebefore_realint", "Real Interest Rate", 0.03, step = 0.01),
checkboxInput("ComparingModels1_ESSOE_parameterchange_indicator_realint", "Change in Real Interest Rate?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESSOE_parameterchange_indicator_realint == true", 
    numericInput("ComparingModels1_ESSOE_parameterchange_period_realint", "Period of Change in Real Interest Rate", 50, min = 0),
    numericInput("ComparingModels1_ESSOE_parameterchange_valueafter_realint", "New Value of Real Interest Rate", 0.05, step = 0.01)),
hr(),
                                       
)
