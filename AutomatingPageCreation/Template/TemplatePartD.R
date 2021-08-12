ESHC_vtv_select_encoded <- reactive({
  variable_encoder(input$ESHC_vtv)
})

ESHC_aux_data <- reactive({
    SimulateExtendedSolowModelHumanCapital(ESHC_parametergrid(), input$ESHC_nperiods_selected,
                                           list(K = input$ESHC_initval_K, L = input$ESHC_initval_K, A = input$ESHC_initval_A, H = input$ESHC_initval_H))
})

output$ESHC_Data <- renderDataTable({ESHC_aux_data() %>% mutate_all(round, digits = 3)})

output$ESHC_Viz <- renderPlot({
    VisualiseSimulation(ESHC_aux_data(), ESHC_vtv_select_encoded(), input$ESHC_scales_free_or_fixed)
})

ESHC_aux_correcttable <- reactive({
    simulation_correctness_checker(ESHC_aux_data()[nrow(ESHC_aux_data()), ],
                                   ESHC_parametergrid()[nrow(ESHC_parametergrid()), ],
                                   "ESHC")
})
output$ESHC_Correctness_Table <- renderDataTable({
    ESHC_aux_correcttable()
})
