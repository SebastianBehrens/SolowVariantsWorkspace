ESSRO_vtv_select_encoded <- reactive({
  variable_encoder(input$ESSRO_vtv)
})

ESSRO_aux_data <- reactive({
    SimulateExtendedSolowModelScarceResourceOil(ESSRO_parametergrid(), input$ESSRO_nperiods_selected,
                                           list(K = input$ESSRO_initval_K, L = input$ESSRO_initval_K, A = input$ESSRO_initval_A, H = input$ESSRO_initval_H))
})

output$ESSRO_Data <- renderDataTable({ESSRO_aux_data() %>% mutate_all(round, digits = 3)})

output$ESSRO_Viz <- renderPlot({
    VisualiseSimulation(ESSRO_aux_data(), ESSRO_vtv_select_encoded(), input$ESSRO_scales_free_or_fixed)
})

ESSRO_aux_correcttable <- reactive({
    simulation_correctness_checker(ESSRO_aux_data()[nrow(ESSRO_aux_data()), ],
                                   ESSRO_parametergrid()[nrow(ESSRO_parametergrid()), ],
                                   "ESSRO")
})
output$ESSRO_Correctness_Table <- renderDataTable({
    ESSRO_aux_correcttable()
})
