ESEG_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESEG_parameternames <- getRequiredParams("ESEG")
  # Periods of Changes ---------------------------------
  ESEG_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$ESEG_changeinparam_alpha) input$ESEG_pc_alpha_period else NA, 
if(input$ESEG_changeinparam_phi) input$ESEG_pc_phi_period else NA, 
if(input$ESEG_changeinparam_savings) input$ESEG_pc_savings_period else NA, 
if(input$ESEG_changeinparam_delta) input$ESEG_pc_delta_period else NA, 
if(input$ESEG_changeinparam_popgrowth) input$ESEG_pc_popgrowth_period else NA 
    )
  # Starting Values of Parameters ---------------------------------
  ESEG_parameterchange_valuebefore <- c(
    # auxspot2
input$ESEG_initparam_alpha,
input$ESEG_initparam_phi,
input$ESEG_initparam_savings,
input$ESEG_initparam_delta,
input$ESEG_initparam_popgrowth
  )
  # Values of Parameters after Change ---------------------------------
  ESEG_parameterchange_valueafter <- c(
    # auxspot3
if(input$ESEG_changeinparam_alpha) input$ESEG_pc_alpha_newval else NA,
if(input$ESEG_changeinparam_phi) input$ESEG_pc_phi_newval else NA,
if(input$ESEG_changeinparam_savings) input$ESEG_pc_savings_newval else NA,
if(input$ESEG_changeinparam_delta) input$ESEG_pc_delta_newval else NA,
if(input$ESEG_changeinparam_popgrowth) input$ESEG_pc_popgrowth_newval else NA
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    ESEG_parameternames,
    ESEG_parameterchange_valuebefore,
    ESEG_parameterchange_period,
    ESEG_parameterchange_valueafter,
    input$ESEG_nperiods_selected
  )
  
})
ESEG_parametergrid_debounced <- ESEG_parametergrid %>% debounce(500)

ESEG_vtv_select_encoded <- reactive({
  variable_encoder(input$ESEG_vtv)
})

ESEG_aux_data <- reactive({
  SimulateExtendedSolowModelEndogenousGrowth(
    ESEG_parametergrid_debounced(), input$ESEG_nperiods_selected,
    list(L = input$ESEG_initval_L, K = input$ESEG_initval_K)
  )
})

output$ESEG_Data <- renderDataTable(
  ESEG_aux_data() %>% mutate_all(round, digits = 3),
  extensions = c("Scroller"),
  options = list(
    scrollX = TRUE
  )
)

output$ESEG_Viz <- renderPlot({
  VisualiseSimulation(ESEG_aux_data(), ESEG_vtv_select_encoded(), input$ESEG_scales_free_or_fixed)
})

ESEG_aux_correcttable <- reactive({
  steadystate_checker(
    ESEG_aux_data(),
    ESEG_parametergrid(),
    "ESEG"
  )
})
output$ESEG_Correctness_Table <- renderDataTable({
  ESEG_aux_correcttable()
})
