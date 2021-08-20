BS_parametergrid <- reactive({
  # Names of Parameters ---------------------------------
  BS_parameternames <- # replace on own — vector of parameters belong here (as supplied to the createpartb function)
  # Periods of Changes ---------------------------------
  BS_parameterchange_period <- c(
    # auxspot1 (first spot to fill in the code for dynamically created code)
    # removecomma
    )
  # Starting Values of Parameters ---------------------------------
  BS_parameterchange_valuebefore <- c(
    # auxspot2
    # removecomma
  )
  # Values of Parameters after Change ---------------------------------
  BS_parameterchange_valueafter <- c(
    # auxspot3
    # removecomma
    )
  # Creating the Grid ---------------------------------
  create_parameter_grid(
    BS_parameternames,
    BS_parameterchange_valuebefore,
    BS_parameterchange_period,
    BS_parameterchange_valueafter,
    input$BS_nperiods_selected
  )
  
})