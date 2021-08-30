ESSRO_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESSRO_parameternames <- c("alpha", "beta", "n", "g", "sE", "s", "delta")
  # Periods of Changes ---------------------------------
  ESSRO_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$ESSRO_changeinparam_alpha) input$ESSRO_pc_alpha_period else NA, 
if(input$ESSRO_changeinparam_beta) input$ESSRO_pc_beta_period else NA, 
if(input$ESSRO_changeinparam_popgrowth) input$ESSRO_pc_popgrowth_period else NA, 
if(input$ESSRO_changeinparam_tfpgrowth) input$ESSRO_pc_tfpgrowth_period else NA, 
if(input$ESSRO_changeinparam_energyconsumption) input$ESSRO_pc_energyconsumption_period else NA, 
if(input$ESSRO_changeinparam_savings) input$ESSRO_pc_savings_period else NA, 
if(input$ESSRO_changeinparam_delta) input$ESSRO_pc_delta_period else NA 
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
input$ESSRO_initparam_delta
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
if(input$ESSRO_changeinparam_delta) input$ESSRO_pc_delta_newval else NA
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
ESSRO_parametergrid_debounced <- ESSRO_parametergrid %>% debounce(1000)

ESSRO_vtv_select_encoded <- reactive({
  variable_encoder(input$ESSRO_vtv)
})

ESSRO_aux_data <- reactive({
  SimulateExtendedSolowModelScarceResourceOil(
    ESSRO_parametergrid(), input$ESSRO_nperiods_selected,
    list(R = input$ESSRO_initval_R, L = input$ESSRO_initval_L, K = input$ESSRO_initval_K, A = input$ESSRO_initval_A)
  )
})

output$ESSRO_Data <- renderDataTable(
  ESSRO_aux_data() %>% mutate_all(round, digits = 3),
  extensions = c("Scroller"),
  options = list(
    scrollX = TRUE
  )
)

output$ESSRO_Viz <- renderPlot({
  VisualiseSimulation(ESSRO_aux_data(), ESSRO_vtv_select_encoded(), input$ESSRO_scales_free_or_fixed)
})

ESSRO_aux_correcttable <- reactive({
  simulation_correctness_checker(
    ESSRO_aux_data()[nrow(ESSRO_aux_data()), ],
    ESSRO_parametergrid()[nrow(ESSRO_parametergrid()), ],
    "ESSRO"
  )
})
output$ESSRO_Correctness_Table <- renderDataTable({
  ESSRO_aux_correcttable()
})
