ESHCDynamicInterface <- 
    conditionalPanel(condition = "input.ComparingModels_VariantSelection1 == 'ESHC'",
                                       # Starting Values ---------------------------------
                                       titlePanel("Starting Values of Stocks"),
                                       # StartingValuesCodeAutoFillLineIndexer
numericInput("ComparingModels1_ESHC_initval_A", "Initial Value of Total Factor Productivity", 1),
numericInput("ComparingModels1_ESHC_initval_K", "Initial Value of Physical Capital", 1),
numericInput("ComparingModels1_ESHC_initval_L", "Initial Value of Labor", 1),
numericInput("ComparingModels1_ESHC_initval_H", "Initial Value of Human Capital", 1),
                                       
                                       titlePanel("Parameter Values"),
                                       # ParameterCodeAutoFillLineIndexer
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESHC_parameterchange_valuebefore_alpha", "Alpha", 2/5, step = 0.05),
checkboxInput("ComparingModels1_ESHC_parameterchange_indicator_alpha", "Change in Alpha?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESHC_parameterchange_indicator_alpha == true", 
    numericInput("ComparingModels1_ESHC_parameterchange_period_alpha", "Period of Change in Alpha", 50, min = 0),
    numericInput("ComparingModels1_ESHC_parameterchange_valueafter_alpha", "New Value of Alpha", 3/5, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESHC_parameterchange_valuebefore_phi", "Phi", 2/5, step = 0.05),
checkboxInput("ComparingModels1_ESHC_parameterchange_indicator_phi", "Change in Phi?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESHC_parameterchange_indicator_phi == true", 
    numericInput("ComparingModels1_ESHC_parameterchange_period_phi", "Period of Change in Phi", 50, min = 0),
    numericInput("ComparingModels1_ESHC_parameterchange_valueafter_phi", "New Value of Phi", 3/5, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESHC_parameterchange_valuebefore_popgrowth", "Population Growth", 0.01, step = 0.01),
checkboxInput("ComparingModels1_ESHC_parameterchange_indicator_popgrowth", "Change in Population Growth?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESHC_parameterchange_indicator_popgrowth == true", 
    numericInput("ComparingModels1_ESHC_parameterchange_period_popgrowth", "Period of Change in Population Growth", 50, min = 0),
    numericInput("ComparingModels1_ESHC_parameterchange_valueafter_popgrowth", "New Value of Population Growth", 0.05, step = 0.01)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESHC_parameterchange_valuebefore_tfpgrowth", "TFP Growth", 0.02, step = 0.01),
checkboxInput("ComparingModels1_ESHC_parameterchange_indicator_tfpgrowth", "Change in TFP Growth?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESHC_parameterchange_indicator_tfpgrowth == true", 
    numericInput("ComparingModels1_ESHC_parameterchange_period_tfpgrowth", "Period of Change in TFP Growth", 50, min = 0),
    numericInput("ComparingModels1_ESHC_parameterchange_valueafter_tfpgrowth", "New Value of TFP Growth", 0.05, step = 0.01)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESHC_parameterchange_valuebefore_sK", "Savings Rate to Physical Capital", 0.1, step = 0.05),
checkboxInput("ComparingModels1_ESHC_parameterchange_indicator_sK", "Change in Savings Rate to Physical Capital?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESHC_parameterchange_indicator_sK == true", 
    numericInput("ComparingModels1_ESHC_parameterchange_period_sK", "Period of Change in Savings Rate to Physical Capital", 50, min = 0),
    numericInput("ComparingModels1_ESHC_parameterchange_valueafter_sK", "New Value of Savings Rate to Physical Capital", 0.2, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESHC_parameterchange_valuebefore_sH", "Savings Rate to Human Capital", 0.1, step = 0.05),
checkboxInput("ComparingModels1_ESHC_parameterchange_indicator_sH", "Change in Savings Rate to Human Capital?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESHC_parameterchange_indicator_sH == true", 
    numericInput("ComparingModels1_ESHC_parameterchange_period_sH", "Period of Change in Savings Rate to Human Capital", 50, min = 0),
    numericInput("ComparingModels1_ESHC_parameterchange_valueafter_sH", "New Value of Savings Rate to Human Capital", 0.2, step = 0.05)),
hr(),
# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESHC_parameterchange_valuebefore_delta", "Delta", 0.15, step = 0.05),
checkboxInput("ComparingModels1_ESHC_parameterchange_indicator_delta", "Change in Delta?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESHC_parameterchange_indicator_delta == true", 
    numericInput("ComparingModels1_ESHC_parameterchange_period_delta", "Period of Change in Delta", 50, min = 0),
    numericInput("ComparingModels1_ESHC_parameterchange_valueafter_delta", "New Value of Delta", 0.3, step = 0.05)),
hr(),
                                       
)
