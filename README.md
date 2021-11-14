# Purpose

The create shiny app allows one to play around with macroeconomic Solow growth models.

# How to use the app:
Two options are available.

- Access the published version on shinyapps.io.
  Click [here](https://sebastianshinyapps.shinyapps.io/SolowVariants/).
- Run the Shiny App locally on your machine.
  1. Open the R-Project file `SolowVariantProject.Rproj`.
  2. In it open the file `MacroModels.R`.
  3. The Shiny App will be launched on your machine.


<!-- # Explanations on the Structure of the Project:
MacroModels.R is the main file ('first layer') containing the code for the shiny app. 

The 'second layer' is/are the simulation functions created in solow-variant-separate files. (BasicSolowModel.R, GeneralSolowModel.R, ExtendedSolowModelSOE.R [SOE for Small Open Economy], ...)

In every simulation function (one to each solow variant) one starts by defining the endogeneous variables within a model and all variations thereof (logs, growth rates, per worker version, per efficient worker,...). 

Every simulation function follows the following steps:

1. Fill a table (so-called simulation table — `sim_table` — which is the main table for the simulation of all variables) with $n+1$ rows (period $0$ and $n$ periods) with `NA`s
2. Fill in start values to the simulation
3. Iteratively compute the periods values of the model’s <u>main</u> variables (often $A, K, L, Y$).
4. Fill in all variations of the aforementioned model-specific <u>main</u> variables (logs, growth rates, per worker, ...) (done by `add_var_computer` — 'additional variable computer') by which the simulation is finished.

A visualisation function (`VisualiseSimulation`) can then be used to visualize specific variables in the simulation (`sim_table`).

Remark: The codebase does not really have robust error handling. When locating errors, it is advisable to execute functions manually. 

# Elaboration on the Files
MacroModels.R — contains the whole shiny app

\<SolowVariant\>ModelFunctions.R — contain model functions (so-called structural equations) of every solow variant as well as formulae for the steady state values of some key endogeneous variables.
(Solow Variants are (for now) the Basic Solow Model (BS), the General Solow Model (GS), the Extended Solow Model for a Small Open Economy (ESSOE).

`\<SolowVariant\>.R` — each contain the simulation function for the respective Solow Variant as outlined above with steps 1. to 4..

The shiny app uses the frontend code written in (and sourced from) the folders `ServerParts` and `Tabs`. -->

# Reflection

If you’re interested, check out my reflection on the project [here](https://github.com/SebastianBehrens/SolowVariants/blob/main/Project%20Reflection.md).

