# General Info

This repo simulates multiple versions of the Solow Growth Model.

One can select which variables to visualise as well as starting values of variables, parameters as well as changes in the parameters allowing for 'comparative statics' (rather comparative simulation).

Each page shows the model functions (defining how endogeneous variables develop), plots of simuated variables (as selected) and the raw data of the simulation itself. 

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

