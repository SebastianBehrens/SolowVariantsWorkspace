# Basic Solow Growth Model =================================
# Parameter Grid ---------------------------------

BS_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  BS_parameternames <- c("B", "alpha", "delta", "n", "s")
  # Periods of Changes ---------------------------------
  BS_parameterchange_period <- c(if(input$BS_changeinparam_tfp) input$BS_pc_tfp_period else NA, 
                                 if(input$BS_changeinparam_alpha) input$BS_pc_alpha_period else NA,
                                 if(input$BS_changeinparam_delta) input$BS_pc_delta_period else NA, 
                                 if(input$BS_changeinparam_popgrowth) input$BS_pc_popgrowth_period else NA, 
                                 if(input$BS_changeinparam_savings) input$BS_pc_savings_period else NA)
  # Starting Values of Parameters ---------------------------------
  BS_parameterchange_valuebefore <- c(input$BS_initval_B,
                                      input$BS_initparam_alpha,
                                      input$BS_initparam_delta,
                                      input$BS_initparam_popgrowth,
                                      input$BS_initparam_savings
  )
  # Values of Parameters after Change ---------------------------------
  BS_parameterchange_valueafter <- c(if(input$BS_changeinparam_tfp) input$BS_pc_tfp_newval else NA,
                                     if(input$BS_changeinparam_alpha) input$BS_pc_alpha_newval else NA,
                                     if(input$BS_changeinparam_delta) input$BS_pc_delta_newval else NA, 
                                     if(input$BS_changeinparam_popgrowth) input$BS_pc_popgrowth_newval else NA,
                                     if(input$BS_changeinparam_savings) input$BS_pc_savings_newval else NA)
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    BS_parameternames,
    BS_parameterchange_valuebefore,
    BS_parameterchange_period,
    BS_parameterchange_valueafter,
    input$BS_nperiods_selected
  )
  
})

BS_vtv_select_encoded <- reactive({
  variable_encoder(input$BS_vtv)
})

BS_vtv_processed_sim <- reactive({
  aux <- BS_vtv_processed_encoded()
  aux_non_standard_detect <- aux %in% c("L", "K", "Y")
  aux[!aux_non_standard_detect]
})
# output$test <- renderText({output$plot_height})

BS_aux_data <- reactive({
  SimulateBasicSolowModel(BS_parametergrid(), input$BS_nperiods_selected,
                          list(K = input$BS_initval_K, L = input$BS_initval_K))
})

output$BS_Data <- renderDataTable(BS_aux_data() %>% mutate_all(round, digits = 3),
  extensions = c("Scroller"),
  options = list(
    scrollX = TRUE
  ))

output$BS_Viz <- renderPlot({
  VisualiseSimulation(BS_aux_data(), BS_vtv_select_encoded(), input$BS_scales_free_or_fixed)
})

BS_aux_correcttable <- reactive({
  simulation_correctness_checker(BS_aux_data()[nrow(BS_aux_data()), ],
                                 BS_parametergrid()[nrow(BS_parametergrid()), ],
                                 "BS")
})
output$BS_Correctness_Table <- renderDataTable({
  BS_aux_correcttable()
})
