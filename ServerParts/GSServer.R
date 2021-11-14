GS_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  GS_parameternames <- getRequiredParams("GS")
  # Periods of Changes ---------------------------------
  GS_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
if(input$GS_changeinparam_tfpgrowth) input$GS_pc_tfpgrowth_period else NA, 
if(input$GS_changeinparam_alpha) input$GS_pc_alpha_period else NA, 
if(input$GS_changeinparam_delta) input$GS_pc_delta_period else NA, 
if(input$GS_changeinparam_popgrowth) input$GS_pc_popgrowth_period else NA, 
if(input$GS_changeinparam_savings) input$GS_pc_savings_period else NA 
    )
  # Starting Values of Parameters ---------------------------------
  GS_parameterchange_valuebefore <- c(
    # auxspot2
input$GS_initparam_tfpgrowth,
input$GS_initparam_alpha,
input$GS_initparam_delta,
input$GS_initparam_popgrowth,
input$GS_initparam_savings
  )
  # Values of Parameters after Change ---------------------------------
  GS_parameterchange_valueafter <- c(
    # auxspot3
if(input$GS_changeinparam_tfpgrowth) input$GS_pc_tfpgrowth_newval else NA,
if(input$GS_changeinparam_alpha) input$GS_pc_alpha_newval else NA,
if(input$GS_changeinparam_delta) input$GS_pc_delta_newval else NA,
if(input$GS_changeinparam_popgrowth) input$GS_pc_popgrowth_newval else NA,
if(input$GS_changeinparam_savings) input$GS_pc_savings_newval else NA
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    GS_parameternames,
    GS_parameterchange_valuebefore,
    GS_parameterchange_period,
    GS_parameterchange_valueafter,
    input$GS_nperiods_selected
  )
  
})
GS_parametergrid_debounced <- GS_parametergrid %>% debounce(500)

GS_vtv_select_encoded <- reactive({
  variable_encoder(input$GS_vtv)
})

GS_aux_data <- reactive({
  SimulateGeneralSolowModel(
    GS_parametergrid_debounced(), input$GS_nperiods_selected,
    list(L = input$GS_initval_L, K = input$GS_initval_K, A = input$GS_initval_A)
  )
})

output$GS_Data <- renderDataTable(
  GS_aux_data() %>% mutate_all(round, digits = 3),
  extensions = c("Scroller"),
  options = list(
    scrollX = TRUE
  )
)

output$GS_Viz <- renderPlot({
  VisualiseSimulation(GS_aux_data(), GS_vtv_select_encoded(), input$GS_scales_free_or_fixed)
})

GS_aux_correcttable <- reactive({
  steadystate_checker(
    GS_aux_data(),
    GS_parametergrid(),
    "GS"
  )
})
output$GS_Correctness_Table <- renderDataTable({
  GS_aux_correcttable()
})
