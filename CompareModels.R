# source("HelperFunctions.R")
# source("AutomatingShinyAppPageCreation.R")



compareEconomies <- function(ModelCode1, ModelCode2, VariableVisualisationSelection, 
                             ParameterGrid1, ParameterGrid2, 
                             StartValues1, StartValues2, NumberPeriods1, NumberPeriods2) {
  
  # sourceSimulationFile(ModelCode1)
  # sourceSimulationFile(ModelCode2)
  simulation1 <- doCall(getSimFunction(ModelCode1), args = list(paragrid = ParameterGrid1, np = NumberPeriods1, startvals = StartValues1))
  simulation2 <- doCall(getSimFunction(ModelCode2), args = list(paragrid = ParameterGrid2, np = NumberPeriods2, startvals = StartValues2))
  
  sameModelCode <- ModelCode1 == ModelCode2
  combined <- simulation1 %>% mutate(Variant = ifelse(sameModelCode, paste0(ModelCode1, "1"), ModelCode1)) %>% 
    bind_rows(simulation2 %>% mutate(Variant = ifelse(sameModelCode, paste0(ModelCode1, "2"), ModelCode2))
              )
  
  visualisation <- combined %>% 
    mutate(Variant = factor(Variant)) %>%
    select(all_of(c("Variant", "period", VariableVisualisationSelection))) %>%
    pivot_longer(-c("period", "Variant"), names_to = "Variable") %>%
    mutate(Variable = as.factor(Variable)) %>%
    ggplot(aes(period, value, col = Variant, group = Variant)) +
    geom_line(alpha = 0.75) +
    facet_wrap(~Variable, scales = "free", ncol = 2) +
    labs(x = "Period", y = "Value") +
    theme(legend.position = "top", 
      legend.justification = "center",
      legend.text=element_text(size=18),
      legend.title = element_text(size = 24))
  
  return(visualisation)
}

