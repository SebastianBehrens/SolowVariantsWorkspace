library(shiny)



shinyapp(
    
)
ui <- fluidPage(
    
    sidebarLayout(
        sidebarPanel(
            selectInput(
                inputId = 'y', 
                label = 'Y-Axis', 
                choices = c('e','d'),
                selected = 'd'
            ),
            
            selectInput(
                inputId = 'x', 
                label = 'X-Axis', 
                choices = c(
                    'IMDB Rating' = 'imdb_rating'
                )
            )
        ),# closing sidebarPanel
        
        mainPanel(
            
        ) # closing mainpanel
        
    ) # closing sidebarLayout
    
)# closing fluidPage
server <- function(input, output, session){
    
    session$onSessionEnded(stopApp)
}

