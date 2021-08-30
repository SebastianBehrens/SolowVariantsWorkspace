
# Comparing Models

ComparingModels_Paragrid1 <- reactive({
  create_parameter_grid_advanced(input$ComparingModels_VariantSelection1,
                                 # 200,
                                 input$ComparingModels1_periods,
                                 1, input)
})
ComparingModels_Paragrid2 <- reactive({
  create_parameter_grid_advanced(input$ComparingModels_VariantSelection2,
                                 # 200,
                                 input$ComparingModels2_periods,
                                 2, input)
})
# ComparingModels_Paragrid1_debounced <- ComparingModels_Paragrid1 %>% debounce(1000)
# ComparingModels_Paragrid2_debounced <- ComparingModels_Paragrid2 %>% debounce(1000)

ComparingModels_StartVals1 <- reactive({
    create_startvals_list(input$ComparingModels_VariantSelection1, 1, input)
})
ComparingModels_StartVals2 <- reactive({
    create_startvals_list(input$ComparingModels_VariantSelection2, 2, input)
})
observe({
  updateCheckboxGroupInput(session, "ModelComparison_VariableSelection",
                   label = "",
                   choices = getVariablesAvailableToBeVisualised(input$ComparingModels_VariantSelection1, input$ComparingModels_VariantSelection2),
                   selected = getVariablesAvailableToBeVisualised(input$ComparingModels_VariantSelection1,
                                                                  input$ComparingModels_VariantSelection2)[c(14, 13, 15, 20, 10)])
})
ModelComparison_VariableSelectionEncoded <- reactive({
  variable_encoder(input$ModelComparison_VariableSelection)
})
# ComparingModels_Visualisation <- reactive({
#   compareEconomies(
#     input$ComparingModels_VariantSelection1,
#     input$ComparingModels_VariantSelection2,
#     ModelComparison_VariableSelectionEncoded(),
#     ComparingModels_Paragrid1(),
#     ComparingModels_Paragrid2(),
#     list(K = 1, L = 1),  list(K = 1, L = 1, A = 1), input$ComparingModels1_periods, input$ComparingModels2_periods
#   )
# })
ComparingModels_Visualisation <- reactive({
  compareEconomies(
    input$ComparingModels_VariantSelection1,
    input$ComparingModels_VariantSelection2,
    ModelComparison_VariableSelectionEncoded(),
    ComparingModels_Paragrid1(),
    ComparingModels_Paragrid2(),
    ComparingModels_StartVals1(), ComparingModels_StartVals2(), input$ComparingModels1_periods, input$ComparingModels2_periods
  )
})

output$ComparisonVisualisation <- renderPlot({
  ComparingModels_Visualisation()
})