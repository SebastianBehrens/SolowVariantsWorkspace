# sectiontitle ---------------------------------
numericInput("ComparingModels1_ESHC_parameterchange_valuebefore_phi", "Phi", auxinitval, step = auxstep),
checkboxInput("ComparingModels1_ESHC_parameterchange_indicator_phi", "Change in Phi?"),
conditionalPanel(
    condition = "input.ComparingModels1_ESHC_parameterchange_indicator_phi == true", 
    numericInput("ComparingModels1_ESHC_parameterchange_period_phi", "Period of Change in Phi", 50, min = 0),
    numericInput("ComparingModels1_ESHC_parameterchange_valueafter_phi", "New Value of Phi", auxnewval, step = auxstep)),
hr(),
