# Automating Page Creation in Shiny App Macro Models
# Sketch on How To ---------------------------------
# 1. Fill parameter slots
# - list with parameters
# - translator function for n => popgrowth (g => tfpgrowth, ...)
# - create code for startvalue, change in parameter true or false, change in parameter new value, change in parameter period of change
# - create code for dynamic grid creation (each start value is filled in manually)
# 2. Fill start value slots
# - add inputs to list
# 3. fill model abbreviation to server part