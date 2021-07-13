# General Info

This repo simulates multiple versions of the Solow Growth Model.

The create shiny app allows one to select which variables to visualise as well as to set starting values of certain stocks and parameters that define the full evolution of all endogeneous variables. Additionally, one can also enter changes in the parameters and see what happens. That is especially useful, as this is commonly asked in questions around the Solow growth models.

# How to run the app:
1. Set the path at the top of the file MacroModels.R to where the repo lives. 
2. Run MacroModels.R 
3. Enjoy


# Explanations on the Structure of the Project:
MacroModels.R is the main file ('first layer') containing the code for the shiny app. 

The 'second layer' is/are the simulation functions created in solow-variant-separate files. (BasicSolowModel.R, GeneralSolowModel.R, ExtendedSolowModelSOE.R [SOE for Small Open Economy], ...)

In every simulation function (one for every Solow Variant) one starts by defining the endogeneous variables within a model and all variations thereof (logs, growth rates, per worker version, per efficient worker,...). 

Every simulation function does the following steps:

1. Fill a table (so-called simulation table — `sim_table` — which is the main table for the simulation of all variables) for all variables of $n$ periods with `NA`s
2. Fill in necessary start values
3. Iteratively compute the periods values of the model’s main variables ($L,K, A, H, Y$)
4. Fill in all variations of those main variables (logs, growth rates, per worker, ...) (done by `add_var_computer` — 'additional variable computer')

A visualisation function (`VisualiseSimulation`) can theb be used to visualize any variables in the simulation (`sim_table`).

# Elaboration on the Files
MacroModels.R — contains shiny whole app

\<SolowVariant\>ModelFunctions.R — model functions of every Solow Variant (Solow Variants are (for now) the Basic Solow Model (BS), the General Solow Model (GS), the Extended Solow Model for a Small Open Economy (ESSOE).

\<SolowVariant\>.R` — the simulation function for every Solow Variant (the order of calculations as well as the variables differ (especially for extendended Variants, which is the reason why I created separate simulation functions (for now).

