ComparisonTab <-
  tabPanel("Comparing Models", fluid = TRUE,
           sidebarLayout(
             sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll; max-height: 90%;",
                          fluidRow(
                            column(6,
                                   selectInput(
                                     "ComparingModels_VariantSelection1",
                                     "Select a Solow Variant",
                                     c(
                                       "Basic Solow Model" = "BS",
                                       "General Solow Model" = "GS",
                                       "Extended Solow Model for a Small Open Economy" = "ESSOE",
                                       "Solow Model with Human Capital" = "ESHC",
                                       "Solow Model with Scarce Resources (Land)" = "ESSRL",
                                       "Solow Model with Scarce Resources (Oil)" = "ESSRO",
                                       "Solow Model with Scarce Resources (Oil and Land)" = "ESSROL"
                                     ),
                                     "BS"
                                   ),
                                   # Periods ---------------------------------
                                   numericInput("ComparingModels1_periods", "Periods", 200, step = 20),
                                   hr(),
                                   getShinyPart("D", "BS", 1),
                                   getShinyPart("D", "GS", 1)
                            ),
                            column(6,
                                   selectInput(
                                       "ComparingModels_VariantSelection2",
                                       "Select a Solow Variant",
                                       c(
                                           "Basic Solow Model" = "BS",
                                           "General Solow Model" = "GS",
                                           "Extended Solow Model for a Small Open Economy" = "ESSOE",
                                           "Solow Model with Human Capital" = "ESHC",
                                           "Solow Model with Scarce Resources (Land)" = "ESSRL",
                                           "Solow Model with Scarce Resources (Oil)" = "ESSRO",
                                           "Solow Model with Scarce Resources (Oil and Land)" = "ESSROL"
                                       ),
                                       "BS"
                                   ),
                                   # Periods ---------------------------------
                                   numericInput("ComparingModels2_periods", "Periods", 200, step = 20),
                                   hr()),
                            column(12, 
                                   titlePanel("Shared Variables"),
                                   # checkboxGroupInput("ModelComparison_VariableSelection",
                                   #                    label = "",
                                   #                    choices = getVariablesAvailableToBeVisualised(input$ComparingModels_VariantSelection1, input$ComparingModels_VariantSelection2),
                                   #                    selected = getVariablesAvailableToBeVisualised(input$ComparingModels_VariantSelection1, 
                                   #                                                                   input$ComparingModels_VariantSelection2)[sample(
                                   #                                                                       c(1:length(getVariablesAvailableToBeVisualised(input$ComparingModels_VariantSelection1, input$ComparingModels_VariantSelection2))), 
                                   #                                                                       5)])
                                   )),
                          
             ),
             mainPanel(
               # content
               plotOutput("ComparisonVisualisation")
             )
             
           ))
