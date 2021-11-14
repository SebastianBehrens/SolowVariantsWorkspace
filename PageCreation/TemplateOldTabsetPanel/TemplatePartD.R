ESHC_parametergrid_debounced <- ESHC_parametergrid %>% debounce(500)

ESHC_vtv_select_encoded <- reactive({
  variable_encoder(input$ESHC_vtv)
})

ESHC_aux_data <- reactive({
  SimulateExtendedSolowModelHumanCapital(
    ESHC_parametergrid_debounced(), input$ESHC_nperiods_selected,
    InitialValueListCodeAutoFillLineIndexer
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
