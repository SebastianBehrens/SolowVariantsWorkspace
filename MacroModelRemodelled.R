if (interactive()) {
    
    library(shiny)
    library(shinyWidgets)
    
    ui <- fluidPage(
        fluidRow(
            column(
                width = 5, offset = 1,
                tags$h2("Vertical tab panel example"),
                verticalTabsetPanel(
                    verticalTabPanel(
                        title = "Title 1",
                        "Content panel 1"
                    ),
                    verticalTabPanel(
                        title = "Title 2",
                        "Content panel 2"
                    ),
                    verticalTabPanel(
                        title = "Title 3",
                        "Content panel 3"
                    )
                )
            )
        )
    )
    
    server <- function(input, output, session) {
        session$onSessionEnded(stopApp)
    }
    
    shinyApp(ui, server)
    
}