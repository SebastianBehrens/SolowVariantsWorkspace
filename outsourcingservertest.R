
interim <- reactive({
  my_function("testinput", input)
})
output$testoutput <- renderDataTable(interim())