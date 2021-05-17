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

In every simulation function (one for every Solow Variant) one starts by defining the endogeneous variables within a model. A table with the time series (of n periods) for each of those variables is created. Then some initial starting values of certain endogeneous variables are filled into this simulation table. Then the simulation function iterates through all periods and computes 'all' variables. Specifically, those directly linked to the main mechanism of a model, such as Output, Labor Stock, Capital Stock. Once all those variables are computed, a second part comes in where certain variants of those main variables are computed such as Output divided by Labor Stock (i.e. Output per Worker). This is done for all remaining variables that are possible within a model (see the third sentence of this section).

Then the whole table of simulated variables is passed to a visualiser function that then visualises them.

# Elaboration on the Files
MacroModels.R — contains shiny whole app

<SolowVariant>ModelFunctions.R — model functions of every Solow Variant (Solow Variants are (for now) the Basic Solow Model (BS), the General Solow Model (GS), the Extended Solow Model for a Small Open Economy (ESSOE).
  
<SolowVariant>.R — the simulation function for every Solow Variant (the order of calculations as well as the variables differ (especially for extendended Variants, which is the reason why I created separate simulation functions (for now).
  

