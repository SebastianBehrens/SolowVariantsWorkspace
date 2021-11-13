ESSROL_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESSROL_parameternames <- getRequiredParams("ESSROL")
  # Periods of Changes ---------------------------------
  ESSROL_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$ESSROL_changeinparam_alpha) input$ESSROL_pc_alpha_period else NA, 
if(input$ESSROL_changeinparam_beta) input$ESSROL_pc_beta_period else NA, 
if(input$ESSROL_changeinparam_kappa) input$ESSROL_pc_kappa_period else NA, 
if(input$ESSROL_changeinparam_delta) input$ESSROL_pc_delta_period else NA, 
if(input$ESSROL_changeinparam_popgrowth) input$ESSROL_pc_popgrowth_period else NA, 
if(input$ESSROL_changeinparam_savings) input$ESSROL_pc_savings_period else NA, 
if(input$ESSROL_changeinparam_energyconsumption) input$ESSROL_pc_energyconsumption_period else NA, 
if(input$ESSROL_changeinparam_tfpgrowth) input$ESSROL_pc_tfpgrowth_period else NA, 
if(input$ESSROL_changeinparam_land) input$ESSROL_pc_land_period else NA 
    )
  # Starting Values of Parameters ---------------------------------
  ESSROL_parameterchange_valuebefore <- c(
    # auxspot2
input$ESSROL_initparam_alpha,
input$ESSROL_initparam_beta,
input$ESSROL_initparam_kappa,
input$ESSROL_initparam_delta,
input$ESSROL_initparam_popgrowth,
input$ESSROL_initparam_savings,
input$ESSROL_initparam_energyconsumption,
input$ESSROL_initparam_tfpgrowth,
input$ESSROL_initparam_land
  )
  # Values of Parameters after Change ---------------------------------
  ESSROL_parameterchange_valueafter <- c(
    # auxspot3
if(input$ESSROL_changeinparam_alpha) input$ESSROL_pc_alpha_newval else NA,
if(input$ESSROL_changeinparam_beta) input$ESSROL_pc_beta_newval else NA,
if(input$ESSROL_changeinparam_kappa) input$ESSROL_pc_kappa_newval else NA,
if(input$ESSROL_changeinparam_delta) input$ESSROL_pc_delta_newval else NA,
if(input$ESSROL_changeinparam_popgrowth) input$ESSROL_pc_popgrowth_newval else NA,
if(input$ESSROL_changeinparam_savings) input$ESSROL_pc_savings_newval else NA,
if(input$ESSROL_changeinparam_energyconsumption) input$ESSROL_pc_energyconsumption_newval else NA,
if(input$ESSROL_changeinparam_tfpgrowth) input$ESSROL_pc_tfpgrowth_newval else NA,
if(input$ESSROL_changeinparam_land) input$ESSROL_pc_land_newval else NA
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    ESSROL_parameternames,
    ESSROL_parameterchange_valuebefore,
    ESSROL_parameterchange_period,
    ESSROL_parameterchange_valueafter,
    input$ESSROL_nperiods_selected
  )
  
})
ESSROL_parametergrid_debounced <- ESSROL_parametergrid %>% debounce(500)

ESSROL_vtv_select_encoded <- reactive({
  variable_encoder(input$ESSROL_vtv)
})

ESSROL_aux_data <- reactive({
  SimulateExtendedSolowModelScarceResourceOilAndLand(
    ESSROL_parametergrid_debounced(), input$ESSROL_nperiods_selected,
    list(R = input$ESSROL_initval_R, L = input$ESSROL_initval_L, K = input$ESSROL_initval_K, A = input$ESSROL_initval_A)
  )
})

output$ESSROL_Data <- renderDataTable({
  ESSROL_aux_data() %>% mutate_all(round, digits = 3)
})

output$ESSROL_Viz <- renderPlot({
  VisualiseSimulation(ESSROL_aux_data(), ESSROL_vtv_select_encoded(), input$ESSROL_scales_free_or_fixed)
})

ESSROL_aux_correcttable <- reactive({
  steadystate_checker(
    ESSROL_aux_data(),
    ESSROL_parametergrid(),
    "ESSROL"
  )
})
output$ESSROL_Correctness_Table <- renderDataTable({
  ESSROL_aux_correcttable()
})
