# sectiontitle ---------------------------------
numericInput("ESHC_initparam_phi", "Phi", auxinitval, step = auxstep),
checkboxInput("ESHC_changeinparam_phi", "Change in Phi?"),
conditionalPanel(
    condition = "input.ESHC_changeinparam_phi == true", 
    numericInput("ESHC_pc_phi_period", "Period of Change in Phi", 50, min = 0),
    numericInput("ESHC_pc_phi_newval", "New Value of Phi", auxnewval, step = auxstep)),
hr(),



