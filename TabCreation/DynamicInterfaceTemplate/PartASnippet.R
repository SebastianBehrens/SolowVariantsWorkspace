# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESHC_parameterchange_valuebefore_phi", "Phi", 0.3, step = 0.05),
checkboxInput("ComparingModels1_ESHC_parameterchange_indicator_phi", "Change in Phi?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESHC_parameterchange_indicator_phi == true", 
    numericInput("ComparingModels1_ESHC_parameterchange_period_phi", "Period of Change in Phi", 10, min = 0, max = 50),
    numericInput("ComparingModels1_ESHC_parameterchange_valueafter_phi", "New Value of Phi", 0.4, step = 0.05)),
hr(),
