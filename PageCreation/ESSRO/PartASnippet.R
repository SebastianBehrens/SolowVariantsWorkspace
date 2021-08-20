# sectiontitle ---------------------------------
numericInput("ESHC_initparam_phi", "Phi", 0.3, step = 0.05),
checkboxInput("ESHC_changeinparam_phi", "Change in Phi?"),
conditionalPanel(
    condition = "input.ESHC_changeinparam_phi == true", 
    numericInput("ESHC_pc_phi_period", "Period of Change in Phi", 10, min = 0, max = 50),
    numericInput("ESHC_pc_phi_newval", "New Value of Phi", 0.4, step = 0.05)),
hr(),



