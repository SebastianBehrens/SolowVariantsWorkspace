ESHC_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESHC_parameternames <- getRequiredParams("ESHC")
  # Periods of Changes ---------------------------------
  ESHC_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$ESHC_changeinparam_alpha) input$ESHC_pc_alpha_period else NA, 
if(input$ESHC_changeinparam_phi) input$ESHC_pc_phi_period else NA, 
if(input$ESHC_changeinparam_popgrowth) input$ESHC_pc_popgrowth_period else NA, 
if(input$ESHC_changeinparam_tfpgrowth) input$ESHC_pc_tfpgrowth_period else NA, 
if(input$ESHC_changeinparam_sK) input$ESHC_pc_sK_period else NA, 
if(input$ESHC_changeinparam_sH) input$ESHC_pc_sH_period else NA, 
if(input$ESHC_changeinparam_delta) input$ESHC_pc_delta_period else NA 
    )
  # Starting Values of Parameters ---------------------------------
  ESHC_parameterchange_valuebefore <- c(
    # auxspot2
input$ESHC_initparam_alpha,
input$ESHC_initparam_phi,
input$ESHC_initparam_popgrowth,
input$ESHC_initparam_tfpgrowth,
input$ESHC_initparam_sK,
input$ESHC_initparam_sH,
input$ESHC_initparam_delta
  )
  # Values of Parameters after Change ---------------------------------
  ESHC_parameterchange_valueafter <- c(
    # auxspot3
if(input$ESHC_changeinparam_alpha) input$ESHC_pc_alpha_newval else NA,
if(input$ESHC_changeinparam_phi) input$ESHC_pc_phi_newval else NA,
if(input$ESHC_changeinparam_popgrowth) input$ESHC_pc_popgrowth_newval else NA,
if(input$ESHC_changeinparam_tfpgrowth) input$ESHC_pc_tfpgrowth_newval else NA,
if(input$ESHC_changeinparam_sK) input$ESHC_pc_sK_newval else NA,
if(input$ESHC_changeinparam_sH) input$ESHC_pc_sH_newval else NA,
if(input$ESHC_changeinparam_delta) input$ESHC_pc_delta_newval else NA
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    ESHC_parameternames,
    ESHC_parameterchange_valuebefore,
    ESHC_parameterchange_period,
    ESHC_parameterchange_valueafter,
    input$ESHC_nperiods_selected
  )
  
})
ESHC_parametergrid_debounced <- ESHC_parametergrid %>% debounce(500)

ESHC_vtv_select_encoded <- reactive({
  variable_encoder(input$ESHC_vtv)
})

ESHC_aux_data <- reactive({
  SimulateExtendedSolowModelHumanCapital(
    ESHC_parametergrid_debounced(), input$ESHC_nperiods_selected,
    list(H = input$ESHC_initval_H, L = input$ESHC_initval_L, K = input$ESHC_initval_K, A = input$ESHC_initval_A)
  )
})

output$ESHC_Data <- renderDataTable(
  ESHC_aux_data() %>% mutate_all(round, digits = 3),
  extensions = c("Scroller"),
  options = list(
    scrollX = TRUE
  )
)

output$ESHC_Viz <- renderPlot({
  VisualiseSimulation(ESHC_aux_data(), ESHC_vtv_select_encoded(), input$ESHC_scales_free_or_fixed)
})

ESHC_aux_correcttable <- reactive({
  steadystate_checker(
    ESHC_aux_data(),
    ESHC_parametergrid(),
    "ESHC"
  )
})
output$ESHC_Correctness_Table <- renderDataTable({
  ESHC_aux_correcttable()
})
