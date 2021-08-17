ComparisonTab <-
  tabPanel("Comparing Models", fluid = TRUE,
           sidebarLayout(
             sidebarPanel(width = 3, style = "position:fixed;width:24%;overflow-y:scroll;max-height:90%;padding-bottom:100px;",
                          fluidRow(
                              column(12,
                                     
                              titlePanel("Select Solow Variants")),
                            column(6,
                                   selectInput(
                                     "ComparingModels_VariantSelection1",
                                     "",
                                     c(
                                       "Basic Solow Model" = "BS",
                                       "General Solow Model" = "GS",
                                       "Extended Solow Model for a Small Open Economy" = "ESSOE",
                                       "Solow Model with Human Capital" = "ESHC",
                                       # "Solow Model with Scarce Resources (Land)" = "ESSRL",
                                       "Solow Model with Scarce Resources (Oil)" = "ESSRO"
                                       # "Solow Model with Scarce Resources (Oil and Land)" = "ESSROL"
                                     ),
                                     "BS"
                                   ),
                                   # Periods ---------------------------------
                                   numericInput("ComparingModels1_periods", "Periods", 200, step = 20),
                                   hr(),
                                   getShinyPart("D", "BS", 1),
                                   getShinyPart("D", "GS", 1),
                                   getShinyPart("D", "ESSOE", 1),
                                   getShinyPart("D", "ESHC", 1),
                                   getShinyPart("D", "ESSRO", 1)
                            ),
                            column(6,
                                   selectInput(
                                       "ComparingModels_VariantSelection2",
                                       "",
                                       c(
                                           "Basic Solow Model" = "BS",
                                           "General Solow Model" = "GS",
                                           "Extended Solow Model for a Small Open Economy" = "ESSOE",
                                           "Solow Model with Human Capital" = "ESHC",
                                           # "Solow Model with Scarce Resources (Land)" = "ESSRL",
                                           "Solow Model with Scarce Resources (Oil)" = "ESSRO"
                                           # "Solow Model with Scarce Resources (Oil and Land)" = "ESSROL"
                                       ),
                                       "GS"
                                   ),
                                   # Periods ---------------------------------
                                   numericInput("ComparingModels2_periods", "Periods", 200, step = 20),
                                   hr(),
                                   getShinyPart("D", "BS", 2),
                                   getShinyPart("D", "GS", 2),
                                   getShinyPart("D", "ESSOE", 2),
                                   getShinyPart("D", "ESHC", 2),
                                   getShinyPart("D", "ESSRO", 2)
                                   ),
                            column(12, 
                                   titlePanel("Shared Variables"),
                                   checkboxGroupInput("ModelComparison_VariableSelection",
                                                      label = "",
                                                      choices =c("Output"),
                                                      selected = "Output")
                                   ),
                            hr(), hr(), hr()),
                          
             ),
             mainPanel(
               # content
               plotOutput("ComparisonVisualisation", height = "1000px")
             )
             
           ))
