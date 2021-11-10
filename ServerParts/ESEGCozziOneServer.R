ESEGCozziOne_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESEGCozziOne_parameternames <- getRequiredParams("ESEGCozziOne")
  # Periods of Changes ---------------------------------
  ESEGCozziOne_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$ESEGCozziOne_changeinparam_alpha) input$ESEGCozziOne_pc_alpha_period else NA, 
if(input$ESEGCozziOne_changeinparam_phi) input$ESEGCozziOne_pc_phi_period else NA, 
if(input$ESEGCozziOne_changeinparam_lambda) input$ESEGCozziOne_pc_lambda_period else NA, 
if(input$ESEGCozziOne_changeinparam_rho) input$ESEGCozziOne_pc_rho_period else NA, 
if(input$ESEGCozziOne_changeinparam_savings) input$ESEGCozziOne_pc_savings_period else NA, 
if(input$ESEGCozziOne_changeinparam_sR) input$ESEGCozziOne_pc_sR_period else NA, 
if(input$ESEGCozziOne_changeinparam_delta) input$ESEGCozziOne_pc_delta_period else NA, 
if(input$ESEGCozziOne_changeinparam_popgrowth) input$ESEGCozziOne_pc_popgrowth_period else NA 
    )
  # Starting Values of Parameters ---------------------------------
  ESEGCozziOne_parameterchange_valuebefore <- c(
    # auxspot2
input$ESEGCozziOne_initparam_alpha,
input$ESEGCozziOne_initparam_phi,
input$ESEGCozziOne_initparam_lambda,
input$ESEGCozziOne_initparam_rho,
input$ESEGCozziOne_initparam_savings,
input$ESEGCozziOne_initparam_sR,
input$ESEGCozziOne_initparam_delta,
input$ESEGCozziOne_initparam_popgrowth
  )
  # Values of Parameters after Change ---------------------------------
  ESEGCozziOne_parameterchange_valueafter <- c(
    # auxspot3
if(input$ESEGCozziOne_changeinparam_alpha) input$ESEGCozziOne_pc_alpha_newval else NA,
if(input$ESEGCozziOne_changeinparam_phi) input$ESEGCozziOne_pc_phi_newval else NA,
if(input$ESEGCozziOne_changeinparam_lambda) input$ESEGCozziOne_pc_lambda_newval else NA,
if(input$ESEGCozziOne_changeinparam_rho) input$ESEGCozziOne_pc_rho_newval else NA,
if(input$ESEGCozziOne_changeinparam_savings) input$ESEGCozziOne_pc_savings_newval else NA,
if(input$ESEGCozziOne_changeinparam_sR) input$ESEGCozziOne_pc_sR_newval else NA,
if(input$ESEGCozziOne_changeinparam_delta) input$ESEGCozziOne_pc_delta_newval else NA,
if(input$ESEGCozziOne_changeinparam_popgrowth) input$ESEGCozziOne_pc_popgrowth_newval else NA
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    ESEGCozziOne_parameternames,
    ESEGCozziOne_parameterchange_valuebefore,
    ESEGCozziOne_parameterchange_period,
    ESEGCozziOne_parameterchange_valueafter,
    input$ESEGCozziOne_nperiods_selected
  )
  
})
ESEGCozziOne_parametergrid_debounced <- ESEGCozziOne_parametergrid %>% debounce(500)

ESEGCozziOne_vtv_select_encoded <- reactive({
  variable_encoder(input$ESEGCozziOne_vtv)
})

ESEGCozziOne_aux_data <- reactive({
  SimulateExtendedSolowModelEndogenousGrowthCozziOne(
    ESEGCozziOne_parametergrid_debounced(), input$ESEGCozziOne_nperiods_selected,
    list(L = input$ESEGCozziOne_initval_L, K = input$ESEGCozziOne_initval_K, A = input$ESEGCozziOne_initval_A)
  )
})

output$ESEGCozziOne_Data <- renderDataTable({
  ESEGCozziOne_aux_data() %>% mutate_all(round, digits = 3)
})

output$ESEGCozziOne_Viz <- renderPlot({
  VisualiseSimulation(ESEGCozziOne_aux_data(), ESEGCozziOne_vtv_select_encoded(), input$ESEGCozziOne_scales_free_or_fixed)
})

ESEGCozziOne_aux_correcttable <- reactive({
  steadystate_checker(
    ESEGCozziOne_aux_data(),
    ESEGCozziOne_parametergrid(),
    "ESEGCozziOne"
  )
})
output$ESEGCozziOne_Correctness_Table <- renderDataTable({
  ESEGCozziOne_aux_correcttable()
})
