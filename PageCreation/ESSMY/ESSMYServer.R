ESSMY_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESSMY_parameternames <- # replace on own — vector of parameters belong here (as supplied to the createpartb function)
  # Periods of Changes ---------------------------------
  ESSMY_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$ESSMY_changeinparam_tfpgrowth) input$ESSMY_pc_tfpgrowth_period else NA, 
if(input$ESSMY_changeinparam_popgrowth) input$ESSMY_pc_popgrowth_period else NA, 
if(input$ESSMY_changeinparam_sK) input$ESSMY_pc_sK_period else NA, 
    # removecomma
    )
  # Starting Values of Parameters ---------------------------------
  ESSMY_parameterchange_valuebefore <- c(
    # auxspot2
input$ESSMY_initparam_tfpgrowth,
input$ESSMY_initparam_popgrowth,
input$ESSMY_initparam_sK,
    # removecomma
  )
  # Values of Parameters after Change ---------------------------------
  ESSMY_parameterchange_valueafter <- c(
    # auxspot3
if(input$ESSMY_changeinparam_tfpgrowth) input$ESSMY_pc_tfpgrowth_newval else NA,
if(input$ESSMY_changeinparam_popgrowth) input$ESSMY_pc_popgrowth_newval else NA,
if(input$ESSMY_changeinparam_sK) input$ESSMY_pc_sK_newval else NA,
    # removecomma
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    ESSMY_parameternames,
    ESSMY_parameterchange_valuebefore,
    ESSMY_parameterchange_period,
    ESSMY_parameterchange_valueafter,
    input$ESSMY_nperiods_selected
  )
  
})
BS_parametergrid_debounced <- BS_parametergrid %>% debounce(500)

ESSMY_vtv_select_encoded <- reactive({
  variable_encoder(input$ESSMY_vtv)
})

ESSMY_aux_data <- reactive({
  my_custom_simulation_function(
    ESSMY_parametergrid(), input$ESSMY_nperiods_selected,
    list(K = input$ESSMY_initval_K, L = input$ESSMY_initval_K, A = input$ESSMY_initval_A, H = input$ESSMY_initval_H)
  )
})

output$ESSMY_Data <- renderDataTable({
  ESSMY_aux_data() %>% mutate_all(round, digits = 3)
})

output$ESSMY_Viz <- renderPlot({
  VisualiseSimulation(ESSMY_aux_data(), ESSMY_vtv_select_encoded(), input$ESSMY_scales_free_or_fixed)
})

ESSMY_aux_correcttable <- reactive({
  simulation_correctness_checker(
    ESSMY_aux_data()[nrow(ESSMY_aux_data()), ],
    ESSMY_parametergrid()[nrow(ESSMY_parametergrid()), ],
    "ESSMY"
  )
})
output$ESSMY_Correctness_Table <- renderDataTable({
  ESSMY_aux_correcttable()
})
