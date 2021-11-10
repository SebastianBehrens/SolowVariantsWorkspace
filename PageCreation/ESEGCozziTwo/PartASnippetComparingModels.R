# sectiontitle ---------------------------------
numericInput("ComparingModels_ESHC_parameterchange_valuebefore_phi", "Phi", auxinitval, step = auxstep),
checkboxInput("ComparingModels_ESHC_parameterchange_indicator_phi", "Change in Phi?"),
conditionalPanel(
    condition = "input.ComparingModels_ESHC_parameterchange_indicator_phi == true", 
    numericInput("ComparingModels_ESHC_parameterchange_period_phi", "Period of Change in Phi", 50, min = 0),
    numericInput("ComparingModels_ESHC_parameterchange_valueafter_phi", "New Value of Phi", auxnewval, step = auxstep)),
hr(),
