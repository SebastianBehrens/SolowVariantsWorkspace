# Project Reflection — What did I learn?

Having started with simplified mechanisms to simulate the functions when I initially took the course Macroeconomics III at University St. Gallen, I need to admit my initial approach to the complexity of those models was not enough. Simulations differed and the task to find the *why* to that was tedious.

So I decided to make a shiny-app of the models, to, for one, be able to study the material in a more fun way, and for the other, to have more fun coding in R.

Here’s what I learned (i.e. gained confidence) in:

- Finding commonalities between similar looking processes
  (e.g. simulating models that however have different parameters and different variables)
- Breaking down more complicated processes into smaller and simpler ones
  (e.g. creating a grid of values, where a grid are ‘parallel’ paths.  thus, to create a grid, I created a function that would make one path, and then used it in another function to create multiple paths and bind the paths together into a grid.)
- Related to the previous one: sowing small parts back together
  (Despite it being ‘memory intensive’ to keep multiple cascading functions in mind (e.g. $f(g(h(x), y), z)$), such as when working out where a mistake had arisen, it was very rewarding seeing them work in conjuction in the end.)
- ‘Meta-programming’ to automate writing of similar code
  (I could not really use the same code dynamically in two different places (or at least didn’t know how to), instead, formulated a mechanism (i.e. cascading functions :) ) that would spare me the tedious work of adjusting small bits in my variable naming ‘convention’ and generate the code dynamically from given inputs.)
- And after all: Solow Models :)

Summarised into one: This project truly helped me to get more comfortable at dealing with increasing complexity in a complicated system.