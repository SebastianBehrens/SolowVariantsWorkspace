# Extended Solow Growth Model — Scarce Resources — Land =================================
ESSRL_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESSRL_parameternames <- c("alpha", "beta", "kappa", "delta", "n", "s", "g", "X")
  # Periods of Changes ---------------------------------
  ESSRL_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
    if(input$ESSRL_changeinparam_alpha) input$ESSRL_pc_alpha_period else NA,
    if(input$ESSRL_changeinparam_beta) input$ESSRL_pc_beta_period else NA,
    if(input$ESSRL_changeinparam_kappa) input$ESSRL_pc_kappa_period else NA,
    if(input$ESSRL_changeinparam_delta) input$ESSRL_pc_delta_period else NA,
    if(input$ESSRL_changeinparam_popgrowth) input$ESSRL_pc_popgrowth_period else NA,
    if(input$ESSRL_changeinparam_savings) input$ESSRL_pc_savings_period else NA,
    if(input$ESSRL_changeinparam_tfpgrowth) input$ESSRL_pc_tfpgrowth_period else NA,
    if(input$ESSRL_changeinparam_land) input$ESSRL_pc_land_period else NA
  )
  # Starting Values of Parameters ---------------------------------
  ESSRL_parameterchange_valuebefore <- c(
    # auxspot2
    input$ESSRL_initparam_alpha,
    input$ESSRL_initparam_beta,
    input$ESSRL_initparam_kappa,
    input$ESSRL_initparam_delta,
    input$ESSRL_initparam_popgrowth,
    input$ESSRL_initparam_savings,
    input$ESSRL_initparam_tfpgrowth,
    input$ESSRL_initparam_land
  )
  # Values of Parameters after Change ---------------------------------
  ESSRL_parameterchange_valueafter <- c(
    # auxspot3
    if(input$ESSRL_changeinparam_alpha) input$ESSRL_pc_alpha_newval else NA,
    if(input$ESSRL_changeinparam_beta) input$ESSRL_pc_beta_newval else NA,
    if(input$ESSRL_changeinparam_kappa) input$ESSRL_pc_kappa_newval else NA,
    if(input$ESSRL_changeinparam_delta) input$ESSRL_pc_delta_newval else NA,
    if(input$ESSRL_changeinparam_popgrowth) input$ESSRL_pc_popgrowth_newval else NA,
    if(input$ESSRL_changeinparam_savings) input$ESSRL_pc_savings_newval else NA,
    if(input$ESSRL_changeinparam_tfpgrowth) input$ESSRL_pc_tfpgrowth_newval else NA,
    if(input$ESSRL_changeinparam_land) input$ESSRL_pc_land_newval else NA
  )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    ESSRL_parameternames,
    ESSRL_parameterchange_valuebefore,
    ESSRL_parameterchange_period,
    ESSRL_parameterchange_valueafter,
    input$ESSRL_nperiods_selected
  )
  
})

ESSRL_parametergrid_debounced <- ESSRL_parametergrid %>% debounce(500)

ESSRL_vtv_select_encoded <- reactive({
  variable_encoder(input$ESSRL_vtv)
})

ESSRL_aux_data <- reactive({
  SimulateExtendedSolowModelScarceResourceLand(ESSRL_parametergrid_debounced(), input$ESSRL_nperiods_selected,
                                               list(
                                                 #auxspot1
                                                 L = input$ESSRL_initval_L,
                                                 K = input$ESSRL_initval_K,
                                                 A = input$ESSRL_initval_A
                                               ))
})

output$ESSRL_Data <- renderDataTable(ESSRL_aux_data() %>% mutate_all(round, digits = 3),
                                     extensions = c("Scroller"),
                                     options = list(
                                       scrollX = TRUE
                                     ))

output$ESSRL_Viz <- renderPlot({
  VisualiseSimulation(ESSRL_aux_data(), ESSRL_vtv_select_encoded(), input$ESSRL_scales_free_or_fixed)
})

ESSRL_aux_correcttable <- reactive({
  simulation_correctness_checker(ESSRL_aux_data()[nrow(ESSRL_aux_data()), ],
                                 ESSRL_parametergrid()[nrow(ESSRL_parametergrid()), ],
                                 "ESSRL")
})
output$ESSRL_Correctness_Table <- renderDataTable({
  ESSRL_aux_correcttable()
})
