BS_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  BS_parameternames <- getRequiredParams("BS")
  # Periods of Changes ---------------------------------
  BS_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$BS_changeinparam_TFP) input$BS_pc_TFP_period else NA, 
if(input$BS_changeinparam_alpha) input$BS_pc_alpha_period else NA, 
if(input$BS_changeinparam_delta) input$BS_pc_delta_period else NA, 
if(input$BS_changeinparam_popgrowth) input$BS_pc_popgrowth_period else NA, 
if(input$BS_changeinparam_savings) input$BS_pc_savings_period else NA 
    )
  # Starting Values of Parameters ---------------------------------
  BS_parameterchange_valuebefore <- c(
    # auxspot2
input$BS_initparam_TFP,
input$BS_initparam_alpha,
input$BS_initparam_delta,
input$BS_initparam_popgrowth,
input$BS_initparam_savings
  )
  # Values of Parameters after Change ---------------------------------
  BS_parameterchange_valueafter <- c(
    # auxspot3
if(input$BS_changeinparam_TFP) input$BS_pc_TFP_newval else NA,
if(input$BS_changeinparam_alpha) input$BS_pc_alpha_newval else NA,
if(input$BS_changeinparam_delta) input$BS_pc_delta_newval else NA,
if(input$BS_changeinparam_popgrowth) input$BS_pc_popgrowth_newval else NA,
if(input$BS_changeinparam_savings) input$BS_pc_savings_newval else NA
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    BS_parameternames,
    BS_parameterchange_valuebefore,
    BS_parameterchange_period,
    BS_parameterchange_valueafter,
    input$BS_nperiods_selected
  )
  
})
BS_parametergrid_debounced <- BS_parametergrid %>% debounce(500)

BS_vtv_select_encoded <- reactive({
  variable_encoder(input$BS_vtv)
})

BS_aux_data <- reactive({
  SimulateBasicSolowModel(
    BS_parametergrid_debounced(), input$BS_nperiods_selected,
    list(L = input$BS_initval_L, K = input$BS_initval_K)
  )
})

output$BS_Data <- renderDataTable(
  BS_aux_data() %>% mutate_all(round, digits = 3),
  extensions = c("Scroller"),
  options = list(
    scrollX = TRUE
  )
)

output$BS_Viz <- renderPlot({
  VisualiseSimulation(BS_aux_data(), BS_vtv_select_encoded(), input$BS_scales_free_or_fixed)
})

BS_aux_correcttable <- reactive({
  steadystate_checker(
    BS_aux_data(),
    BS_parametergrid(),
    "BS"
  )
})
output$BS_Correctness_Table <- renderDataTable({
  BS_aux_correcttable()
})
