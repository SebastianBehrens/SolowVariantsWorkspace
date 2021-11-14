ComparisonTab <-
  tabItem("Comparison",
           sidebarLayout(
             sidebarPanel(width = 3,
                          fluidRow(
                              column(12,
                                     
                              titlePanel("Select Solow Variants")),
                            column(6,
                                   selectInput(
                                     "ComparingModels_VariantSelection1",
                                     "",
                                     c(
                                       "BS" = "BS",
                                       "GS" = "GS",
                                       "ESSOE" = "ESSOE",
                                       "ESHC" = "ESHC",
                                       "ESSRO" = "ESSRO",
                                       "ESSRL" = "ESSRL",
                                       "ESSROL" = "ESSROL",
                                       "ESEG" = "ESEG",
                                       "ESEG (Romer Extension)" = "ESEGRomer",
                                       "ESEG (Cozzi Extension)" = "ESEGCozziOne",
                                       "ESEG (Cozzi Hybrid Model)" = "ESEGCozziTwo"
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
                                   getShinyPart("D", "ESSRO", 1),
                                   getShinyPart("D", "ESSRL", 1),
                                   getShinyPart("D", "ESSROL", 1),
                                   getShinyPart("D", "ESEG", 1),
                                   getShinyPart("D", "ESEGRomer", 1),
                                   getShinyPart("D", "ESEGCozziOne", 1),
                                   getShinyPart("D", "ESEGCozziTwo", 1)
                            ),
                            column(6,
                                   selectInput(
                                       "ComparingModels_VariantSelection2",
                                       "",
                                       c(
                                       "BS" = "BS",
                                       "GS" = "GS",
                                       "ESSOE" = "ESSOE",
                                       "ESHC" = "ESHC",
                                       "ESSRO" = "ESSRO",
                                       "ESSRL" = "ESSRL",
                                       "ESSROL" = "ESSROL",
                                       "ESEG" = "ESEG",
                                       "ESEG (Romer Extension)" = "ESEGRomer",
                                       "ESEG (Cozzi Extension)" = "ESEGCozziOne",
                                       "ESEG (Cozzi Hybrid Model)" = "ESEGCozziTwo"
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
                                   getShinyPart("D", "ESSRO", 2),
                                   getShinyPart("D", "ESSRL", 2),
                                   getShinyPart("D", "ESSROL", 2),
                                   getShinyPart("D", "ESEG", 2),
                                   getShinyPart("D", "ESEGRomer", 2),
                                   getShinyPart("D", "ESEGCozziOne", 2),
                                   getShinyPart("D", "ESEGCozziTwo", 2)
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
