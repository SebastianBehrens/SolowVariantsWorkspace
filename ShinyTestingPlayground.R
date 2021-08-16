# rm(list = ls())




shinyApp(
  ui = fluidPage(
    tabsetPanel(
      sidebarLayout(
        sidebarPanel(width = 3, style = "position:fixed;width:22%;overflow-y:scroll;max-height: 90%;",
          column(6,
                 textInput("test1", "yes?")),
          column(6, textInput("test2", "no?")),
          column(12, textInput("test3", "yes?"))
        ),
        mainPanel()
      )
  )
  ),
  server <- function(input, output, session) {


    # to be taken out when app is published
    session$onSessionEnded(stopApp)
  }
)

# what is supposed to be rendered with all this.
# tibble(testcolumn = c("A"))
