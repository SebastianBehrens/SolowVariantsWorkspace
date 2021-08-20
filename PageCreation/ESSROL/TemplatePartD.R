ESSROL_vtv_select_encoded <- reactive({
  variable_encoder(input$ESSROL_vtv)
})

ESSROL_aux_data <- reactive({
  SimulateExtendedSolowModelScarceResourceOilAndLand(
    ESSROL_parametergrid(), input$ESSROL_nperiods_selected,
    list(K = input$ESSROL_initval_K, L = input$ESSROL_initval_K, A = input$ESSROL_initval_A, H = input$ESSROL_initval_H)
  )
})

output$ESSROL_Data <- renderDataTable({
  ESSROL_aux_data() %>% mutate_all(round, digits = 3)
})

output$ESSROL_Viz <- renderPlot({
  VisualiseSimulation(ESSROL_aux_data(), ESSROL_vtv_select_encoded(), input$ESSROL_scales_free_or_fixed)
})

ESSROL_aux_correcttable <- reactive({
  simulation_correctness_checker(
    ESSROL_aux_data()[nrow(ESSROL_aux_data()), ],
    ESSROL_parametergrid()[nrow(ESSROL_parametergrid()), ],
    "ESSROL"
  )
})
output$ESSROL_Correctness_Table <- renderDataTable({
  ESSROL_aux_correcttable()
})
