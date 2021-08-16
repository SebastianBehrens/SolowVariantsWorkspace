
# Comparing Models

ComparingModels_Paragrid1 <- reactive({
  create_parameter_grid_advanced(input$ComparingModels_VariantSelection1,
                                 input$ComparingModels1_periods,
                                 "1", input)
})
ComparingModels_Paragrid2 <- reactive({
  create_parameter_grid_advanced(input$ComparingModels_VariantSelection2,
                                 input$ComparingModels1_periods,
                                 "2", input)
})

ComparingModel_StartVals1 <- reactive({
    create_startvals_list(input$ComparingModels_VariantSelection1, 1, input)
})
ComparingModel_StartVals2 <- reactive({
    create_startvals_list(input$ComparingModels_VariantSelection2, 2, input)
})
ComparingModels_Visualisation <- reactive({
  compareEconomies(
    input$ComparingModels_VariantSelection1,
    input$ComparingModels_VariantSelection2,
    input$ModelComparison_VariableSelection,
    ComparingModels_Paragrid1(),
    ComparingModels_Paragrid2(),
    ComparingModel_StartVals1(), ComparingModel_StartVals2(), input$ComparingModels1_periods, input$ComparingModels2_periods
  )
})
output$ComparisonVisualisation <- renderPlot({
    ComparingModels_Visualisation()
})