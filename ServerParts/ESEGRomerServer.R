ESEGRomer_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESEGRomer_parameternames <- getRequiredParams("ESEGRomer")
  # Periods of Changes ---------------------------------
  ESEGRomer_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$ESEGRomer_changeinparam_alpha) input$ESEGRomer_pc_alpha_period else NA, 
if(input$ESEGRomer_changeinparam_phi) input$ESEGRomer_pc_phi_period else NA, 
if(input$ESEGRomer_changeinparam_lambda) input$ESEGRomer_pc_lambda_period else NA, 
if(input$ESEGRomer_changeinparam_rho) input$ESEGRomer_pc_rho_period else NA, 
if(input$ESEGRomer_changeinparam_savings) input$ESEGRomer_pc_savings_period else NA, 
if(input$ESEGRomer_changeinparam_sR) input$ESEGRomer_pc_sR_period else NA, 
if(input$ESEGRomer_changeinparam_delta) input$ESEGRomer_pc_delta_period else NA, 
if(input$ESEGRomer_changeinparam_popgrowth) input$ESEGRomer_pc_popgrowth_period else NA 
    )
  # Starting Values of Parameters ---------------------------------
  ESEGRomer_parameterchange_valuebefore <- c(
    # auxspot2
input$ESEGRomer_initparam_alpha,
input$ESEGRomer_initparam_phi,
input$ESEGRomer_initparam_lambda,
input$ESEGRomer_initparam_rho,
input$ESEGRomer_initparam_savings,
input$ESEGRomer_initparam_sR,
input$ESEGRomer_initparam_delta,
input$ESEGRomer_initparam_popgrowth
  )
  # Values of Parameters after Change ---------------------------------
  ESEGRomer_parameterchange_valueafter <- c(
    # auxspot3
if(input$ESEGRomer_changeinparam_alpha) input$ESEGRomer_pc_alpha_newval else NA,
if(input$ESEGRomer_changeinparam_phi) input$ESEGRomer_pc_phi_newval else NA,
if(input$ESEGRomer_changeinparam_lambda) input$ESEGRomer_pc_lambda_newval else NA,
if(input$ESEGRomer_changeinparam_rho) input$ESEGRomer_pc_rho_newval else NA,
if(input$ESEGRomer_changeinparam_savings) input$ESEGRomer_pc_savings_newval else NA,
if(input$ESEGRomer_changeinparam_sR) input$ESEGRomer_pc_sR_newval else NA,
if(input$ESEGRomer_changeinparam_delta) input$ESEGRomer_pc_delta_newval else NA,
if(input$ESEGRomer_changeinparam_popgrowth) input$ESEGRomer_pc_popgrowth_newval else NA
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    ESEGRomer_parameternames,
    ESEGRomer_parameterchange_valuebefore,
    ESEGRomer_parameterchange_period,
    ESEGRomer_parameterchange_valueafter,
    input$ESEGRomer_nperiods_selected
  )
  
})
ESEGRomer_parametergrid_debounced <- ESEGRomer_parametergrid %>% debounce(500)

ESEGRomer_vtv_select_encoded <- reactive({
  variable_encoder(input$ESEGRomer_vtv)
})

ESEGRomer_aux_data <- reactive({
  SimulateExtendedSolowModelEndogenousGrowthRomer(
    ESEGRomer_parametergrid_debounced(), input$ESEGRomer_nperiods_selected,
    list(L = input$ESEGRomer_initval_L, K = input$ESEGRomer_initval_K, A = input$ESEGRomer_initval_A)
  )
})

output$ESEGRomer_Data <- renderDataTable({
  ESEGRomer_aux_data() %>% mutate_all(round, digits = 3)
})

output$ESEGRomer_Viz <- renderPlot({
  VisualiseSimulation(ESEGRomer_aux_data(), ESEGRomer_vtv_select_encoded(), input$ESEGRomer_scales_free_or_fixed)
})

ESEGRomer_aux_correcttable <- reactive({
  steadystate_checker(
    ESEGRomer_aux_data(),
    ESEGRomer_parametergrid(),
    "ESEGRomer"
  )
})
output$ESEGRomer_Correctness_Table <- renderDataTable({
  ESEGRomer_aux_correcttable()
})
