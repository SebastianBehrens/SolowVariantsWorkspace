ESSRO_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESSRO_parameternames <- # replace on own — vector of parameters belong here (as supplied to the createpartb function)
  # Periods of Changes ---------------------------------
  ESSRO_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$ESSRO_changeinparam_alpha) input$ESSRO_pc_alpha_period else NA, 
if(input$ESSRO_changeinparam_beta) input$ESSRO_pc_beta_period else NA, 
if(input$ESSRO_changeinparam_popgrowth) input$ESSRO_pc_popgrowth_period else NA, 
if(input$ESSRO_changeinparam_tfpgrowth) input$ESSRO_pc_tfpgrowth_period else NA, 
if(input$ESSRO_changeinparam_energyconsumption) input$ESSRO_pc_energyconsumption_period else NA, 
if(input$ESSRO_changeinparam_savings) input$ESSRO_pc_savings_period else NA, 
if(input$ESSRO_changeinparam_delta) input$ESSRO_pc_delta_period else NA, 
    # removecomma
    )
  # Starting Values of Parameters ---------------------------------
  ESSRO_parameterchange_valuebefore <- c(
    # auxspot2
input$ESSRO_initparam_alpha,
input$ESSRO_initparam_beta,
input$ESSRO_initparam_popgrowth,
input$ESSRO_initparam_tfpgrowth,
input$ESSRO_initparam_energyconsumption,
input$ESSRO_initparam_savings,
input$ESSRO_initparam_delta,
    # removecomma
  )
  # Values of Parameters after Change ---------------------------------
  ESSRO_parameterchange_valueafter <- c(
    # auxspot3
if(input$ESSRO_changeinparam_alpha) input$ESSRO_pc_alpha_newval else NA,
if(input$ESSRO_changeinparam_beta) input$ESSRO_pc_beta_newval else NA,
if(input$ESSRO_changeinparam_popgrowth) input$ESSRO_pc_popgrowth_newval else NA,
if(input$ESSRO_changeinparam_tfpgrowth) input$ESSRO_pc_tfpgrowth_newval else NA,
if(input$ESSRO_changeinparam_energyconsumption) input$ESSRO_pc_energyconsumption_newval else NA,
if(input$ESSRO_changeinparam_savings) input$ESSRO_pc_savings_newval else NA,
if(input$ESSRO_changeinparam_delta) input$ESSRO_pc_delta_newval else NA,
    # removecomma
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    ESSRO_parameternames,
    ESSRO_parameterchange_valuebefore,
    ESSRO_parameterchange_period,
    ESSRO_parameterchange_valueafter,
    input$ESSRO_nperiods_selected
  )
  
})
