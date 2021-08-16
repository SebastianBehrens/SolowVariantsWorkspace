Tab1 <- 
  tabPanel("Tab1", fluid = TRUE,
           sidebarLayout(
             sidebarPanel(
               radioButtons(
                 "testinput", "This is just a testinput. Just select something.",
                 c("A", "B", "C"), "A"
               )
             ),
             mainPanel(
               dataTableOutput("testoutput")
             )
           )
  )