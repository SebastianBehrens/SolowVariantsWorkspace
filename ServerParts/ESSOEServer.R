# Extended Solow Growth Model — Small Open Economy =================================
# Parameter Grid ---------------------------------
ESSOE_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESSOE_parameternames <- c("B", "alpha", "r", "n", "s")
  # Periods of Changes ---------------------------------
  ESSOE_parameterchange_period <- c(if(input$ESSOE_changeinparam_tfp) input$ESSOE_pc_tfp_period else NA,
                                    if(input$ESSOE_changeinparam_alpha) input$ESSOE_pc_alpha_period else NA,
                                    if(input$ESSOE_changeinparam_realint) input$ESSOE_pc_realint_period else NA,
                                    if(input$ESSOE_changeinparam_popgrowth) input$ESSOE_pc_popgrowth_period else NA,
                                    if(input$ESSOE_changeinparam_savings) input$ESSOE_pc_savings_period else NA)
  # Starting Values of Parameters ---------------------------------
  ESSOE_parameterchange_valuebefore <- c(input$ESSOE_initval_B,
                                         input$ESSOE_initparam_alpha,
                                         input$ESSOE_initparam_realint,
                                         input$ESSOE_initparam_popgrowth,
                                         input$ESSOE_initparam_savings
  )
  # Values of Parameters after Change ---------------------------------
  ESSOE_parameterchange_valueafter <- c(if(input$ESSOE_changeinparam_tfp) input$ESSOE_pc_tfp_newval else NA,
                                        if(input$ESSOE_changeinparam_alpha) input$ESSOE_pc_alpha_newval else NA,
                                        if(input$ESSOE_changeinparam_realint) input$ESSOE_pc_realint_newval else NA,
                                        if(input$ESSOE_changeinparam_popgrowth) input$ESSOE_pc_popgrowth_newval else NA,
                                        if(input$ESSOE_changeinparam_savings) input$ESSOE_pc_savings_newval else NA)
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    ESSOE_parameternames,
    ESSOE_parameterchange_valuebefore,
    ESSOE_parameterchange_period,
    ESSOE_parameterchange_valueafter,
    input$ESSOE_nperiods_selected
  )
  
})
# Encoding the selected Variables (for use in visualise function) ---------------------------------
ESSOE_vtv_select_encoded <- reactive({
  variable_encoder(input$ESSOE_vtv)
})
# unnecessary ---------------------------------
ESSOE_vtv_processed_sim <- reactive({
  aux <- ESSOE_vtv_processed_encoded()
  aux_non_standard_detect <- aux %in% c("L", "K", "Y")
  aux[!aux_non_standard_detect]
})
# output$test <- renderText({output$plot_height})
# Simulating the Economy ---------------------------------
ESSOE_aux_data <- reactive({
  SimulateExtendedSolowModelSmallOpenEconomy(ESSOE_parametergrid(), input$ESSOE_nperiods_selected,
                                             list(L = input$ESSOE_initval_L, V = input$ESSOE_initval_V))
})
# Rendering the Simulation as a table ---------------------------------
output$ESSOE_Data <- renderDataTable({ESSOE_aux_data() %>% mutate_all(round, digits = 3)})
# Visualising the Simulation (the selected variables respectively) ---------------------------------
output$ESSOE_Viz <- renderPlot({
  VisualiseSimulation(ESSOE_aux_data(), ESSOE_vtv_select_encoded(), input$ESSOE_scales_free_or_fixed)
})

ESSOE_aux_correcttable <- reactive({
  simulation_correctness_checker(ESSOE_aux_data()[nrow(ESSOE_aux_data()), ],
                                 ESSOE_parametergrid()[nrow(ESSOE_parametergrid()), ],
                                 "ESSOE")
})
output$ESSOE_Correctness_Table <- renderDataTable({
  ESSOE_aux_correcttable()
})
