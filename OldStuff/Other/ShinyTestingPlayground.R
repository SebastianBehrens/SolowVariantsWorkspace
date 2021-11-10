# rm(list = ls())


library(tidyverse)
source("CompareModels.R")

getRequiredStartingValues <- function(ModelCode){
  out <- if (ModelCode == "BS") {
    out <- c("K", "L")
  } else if (ModelCode == "GS") {
    out <- c("A", "K", "L")
  } else if (ModelCode == "ESSOE") {
    out <- c("L", "V")
  } else if (ModelCode == "ESSRL") {
    out <- c("A", "K", "L")
  } else if (ModelCode == "ESSRO") {
    out <- c("A", "K", "L", "R")
  } else if (ModelCode == "ESSROL") {
    out <- NaN
  } else if (ModelCode == "ESHC") {
    out <- c("A", "K", "L", "H")
  } else {
    (
      out <- NaN
    )
  }
  if (is.na(out)) {
    warning("The entered shortcode for a model variant does not exist.")
  }
  return(out)
}

create_startvals_list <- function(ModelCode, n_ModelComparison, input){
  aux_list <- list()
  for(i in getRequiredStartingValues(ModelCode)){
    aux_var_as_string <- paste0("input$ComparingModels", n_ModelComparison, "_", ModelCode, "_initval_", i)
    # debugging start
    # issue is in line below
    aux_list <- eval(parse(text = paste0("append(aux_list, list(", i, " = ", aux_var_as_string, "))"))) # mistake seems to be here
    # print("Works 2") # is not printed!!!
    # debugging end
    
    
  }
  
  return(aux_list)
}


shinyApp(
  ui = fluidPage(
    tabsetPanel(
      sidebarLayout(
        sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll;max-height: 90%;",
          column(6,
                 numericInput("ComparingModels1_BS_initval_K", "Enter a value", 1),
                 numericInput("ComparingModels1_BS_initval_L", "Enter a value", 2)
                 )
        ),
        mainPanel(
          textOutput("test"),
          dataTableOutput("test2")
        )
      )
  )
  ),
  server <- function(input, output, session) {
    interim_testing_object <- reactive({create_startvals_list("BS", 1, input)})
      # print("ServerSide printing next")
      # print(interim_testing_object() %>% str())

    
    output$test <- renderText({interim_testing_object() %>% print()})
    output$test2 <- renderDataTable({data.frame(interim_testing_object())})
    # to be taken out when app is published
    session$onSessionEnded(stopApp)
  }
)

# what is supposed to be rendered with all this.
# test_list <- list(ComparingModels1_BS_initval_K = 2, ComparingModels1_BS_initval_L = 1)
# test_out <- create_startvals_list("BS", 1, test_list)
# test_out
