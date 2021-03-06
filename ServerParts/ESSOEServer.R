ESSOE_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  ESSOE_parameternames <- getRequiredParams("ESSOE")
  # Periods of Changes ---------------------------------
  ESSOE_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$ESSOE_changeinparam_TFP) input$ESSOE_pc_TFP_period else NA, 
if(input$ESSOE_changeinparam_alpha) input$ESSOE_pc_alpha_period else NA, 
if(input$ESSOE_changeinparam_popgrowth) input$ESSOE_pc_popgrowth_period else NA, 
if(input$ESSOE_changeinparam_savings) input$ESSOE_pc_savings_period else NA, 
if(input$ESSOE_changeinparam_realint) input$ESSOE_pc_realint_period else NA 
    )
  # Starting Values of Parameters ---------------------------------
  ESSOE_parameterchange_valuebefore <- c(
    # auxspot2
input$ESSOE_initparam_TFP,
input$ESSOE_initparam_alpha,
input$ESSOE_initparam_popgrowth,
input$ESSOE_initparam_savings,
input$ESSOE_initparam_realint
  )
  # Values of Parameters after Change ---------------------------------
  ESSOE_parameterchange_valueafter <- c(
    # auxspot3
if(input$ESSOE_changeinparam_TFP) input$ESSOE_pc_TFP_newval else NA,
if(input$ESSOE_changeinparam_alpha) input$ESSOE_pc_alpha_newval else NA,
if(input$ESSOE_changeinparam_popgrowth) input$ESSOE_pc_popgrowth_newval else NA,
if(input$ESSOE_changeinparam_savings) input$ESSOE_pc_savings_newval else NA,
if(input$ESSOE_changeinparam_realint) input$ESSOE_pc_realint_newval else NA
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    ESSOE_parameternames,
    ESSOE_parameterchange_valuebefore,
    ESSOE_parameterchange_period,
    ESSOE_parameterchange_valueafter,
    input$ESSOE_nperiods_selected
  )
  
})
ESSOE_parametergrid_debounced <- ESSOE_parametergrid %>% debounce(500)

ESSOE_vtv_select_encoded <- reactive({
  variable_encoder(input$ESSOE_vtv)
})

ESSOE_aux_data <- reactive({
  SimulateExtendedSolowModelSmallOpenEconomy(
    ESSOE_parametergrid_debounced(), input$ESSOE_nperiods_selected,
    list(V = input$ESSOE_initval_V, L = input$ESSOE_initval_L)
  )
})

output$ESSOE_Data <- renderDataTable(
  ESSOE_aux_data() %>% mutate_all(round, digits = 3),
  extensions = c("Scroller"),
  options = list(
    scrollX = TRUE
  )
)

output$ESSOE_Viz <- renderPlot({
  VisualiseSimulation(ESSOE_aux_data(), ESSOE_vtv_select_encoded(), input$ESSOE_scales_free_or_fixed)
})

ESSOE_aux_correcttable <- reactive({
  steadystate_checker(
    ESSOE_aux_data(),
    ESSOE_parametergrid(),
    "ESSOE"
  )
})
output$ESSOE_Correctness_Table <- renderDataTable({
  ESSOE_aux_correcttable()
})
