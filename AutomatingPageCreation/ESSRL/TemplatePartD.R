ESSRL_vtv_select_encoded <- reactive({
  variable_encoder(input$ESSRL_vtv)
})

ESSRL_aux_data <- reactive({
    SimulateExtendedSolowModelScarceResourceLand(ESSRL_parametergrid(), input$ESSRL_nperiods_selected,
                                           list(K = input$ESSRL_initval_K, L = input$ESSRL_initval_K, A = input$ESSRL_initval_A, H = input$ESSRL_initval_H))
})

output$ESSRL_Data <- renderDataTable({ESSRL_aux_data() %>% mutate_all(round, digits = 3)})

output$ESSRL_Viz <- renderPlot({
    VisualiseSimulation(ESSRL_aux_data(), ESSRL_vtv_select_encoded(), input$ESSRL_scales_free_or_fixed)
})

ESSRL_aux_correcttable <- reactive({
    simulation_correctness_checker(ESSRL_aux_data()[nrow(ESSRL_aux_data()), ],
                                   ESSRL_parametergrid()[nrow(ESSRL_parametergrid()), ],
                                   "ESSRL")
})
output$ESSRL_Correctness_Table <- renderDataTable({
    ESSRL_aux_correcttable()
})
