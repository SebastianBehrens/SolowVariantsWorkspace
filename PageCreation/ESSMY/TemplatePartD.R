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
