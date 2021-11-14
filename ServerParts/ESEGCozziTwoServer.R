ESEGCozziTwo_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESEGCozziTwo_parameternames <- getRequiredParams("ESEGCozziTwo")
  # Periods of Changes ---------------------------------
  ESEGCozziTwo_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$ESEGCozziTwo_changeinparam_alpha) input$ESEGCozziTwo_pc_alpha_period else NA, 
if(input$ESEGCozziTwo_changeinparam_phi) input$ESEGCozziTwo_pc_phi_period else NA, 
if(input$ESEGCozziTwo_changeinparam_lambda) input$ESEGCozziTwo_pc_lambda_period else NA, 
if(input$ESEGCozziTwo_changeinparam_rho) input$ESEGCozziTwo_pc_rho_period else NA, 
if(input$ESEGCozziTwo_changeinparam_savings) input$ESEGCozziTwo_pc_savings_period else NA, 
if(input$ESEGCozziTwo_changeinparam_sR) input$ESEGCozziTwo_pc_sR_period else NA, 
if(input$ESEGCozziTwo_changeinparam_delta) input$ESEGCozziTwo_pc_delta_period else NA, 
if(input$ESEGCozziTwo_changeinparam_popgrowth) input$ESEGCozziTwo_pc_popgrowth_period else NA, 
if(input$ESEGCozziTwo_changeinparam_k) input$ESEGCozziTwo_pc_k_period else NA 
    )
  # Starting Values of Parameters ---------------------------------
  ESEGCozziTwo_parameterchange_valuebefore <- c(
    # auxspot2
input$ESEGCozziTwo_initparam_alpha,
input$ESEGCozziTwo_initparam_phi,
input$ESEGCozziTwo_initparam_lambda,
input$ESEGCozziTwo_initparam_rho,
input$ESEGCozziTwo_initparam_savings,
input$ESEGCozziTwo_initparam_sR,
input$ESEGCozziTwo_initparam_delta,
input$ESEGCozziTwo_initparam_popgrowth,
input$ESEGCozziTwo_initparam_k
  )
  # Values of Parameters after Change ---------------------------------
  ESEGCozziTwo_parameterchange_valueafter <- c(
    # auxspot3
if(input$ESEGCozziTwo_changeinparam_alpha) input$ESEGCozziTwo_pc_alpha_newval else NA,
if(input$ESEGCozziTwo_changeinparam_phi) input$ESEGCozziTwo_pc_phi_newval else NA,
if(input$ESEGCozziTwo_changeinparam_lambda) input$ESEGCozziTwo_pc_lambda_newval else NA,
if(input$ESEGCozziTwo_changeinparam_rho) input$ESEGCozziTwo_pc_rho_newval else NA,
if(input$ESEGCozziTwo_changeinparam_savings) input$ESEGCozziTwo_pc_savings_newval else NA,
if(input$ESEGCozziTwo_changeinparam_sR) input$ESEGCozziTwo_pc_sR_newval else NA,
if(input$ESEGCozziTwo_changeinparam_delta) input$ESEGCozziTwo_pc_delta_newval else NA,
if(input$ESEGCozziTwo_changeinparam_popgrowth) input$ESEGCozziTwo_pc_popgrowth_newval else NA,
if(input$ESEGCozziTwo_changeinparam_k) input$ESEGCozziTwo_pc_k_newval else NA
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    ESEGCozziTwo_parameternames,
    ESEGCozziTwo_parameterchange_valuebefore,
    ESEGCozziTwo_parameterchange_period,
    ESEGCozziTwo_parameterchange_valueafter,
    input$ESEGCozziTwo_nperiods_selected
  )
  
})
ESEGCozziTwo_parametergrid_debounced <- ESEGCozziTwo_parametergrid %>% debounce(500)

ESEGCozziTwo_vtv_select_encoded <- reactive({
  variable_encoder(input$ESEGCozziTwo_vtv)
})

ESEGCozziTwo_aux_data <- reactive({
  SimulateExtendedSolowModelEndogenousGrowthCozziTwo(
    ESEGCozziTwo_parametergrid_debounced(), input$ESEGCozziTwo_nperiods_selected,
    list(L = input$ESEGCozziTwo_initval_L, K = input$ESEGCozziTwo_initval_K, A = input$ESEGCozziTwo_initval_A)
  )
})

output$ESEGCozziTwo_Data <- renderDataTable(
  ESEGCozziTwo_aux_data() %>% mutate_all(round, digits = 3),
  extensions = c("Scroller"),
  options = list(
    scrollX = TRUE
  )
)

output$ESEGCozziTwo_Viz <- renderPlot({
  VisualiseSimulation(ESEGCozziTwo_aux_data(), ESEGCozziTwo_vtv_select_encoded(), input$ESEGCozziTwo_scales_free_or_fixed)
})

ESEGCozziTwo_aux_correcttable <- reactive({
  steadystate_checker(
    ESEGCozziTwo_aux_data(),
    ESEGCozziTwo_parametergrid(),
    "ESEGCozziTwo"
  )
})
output$ESEGCozziTwo_Correctness_Table <- renderDataTable({
  ESEGCozziTwo_aux_correcttable()
})
