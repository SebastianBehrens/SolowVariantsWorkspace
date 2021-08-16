StartPageTab <- 
  tabPanel("Start Page", fluid = TRUE,
           h3("This Shiny App aims to do the following:"),
           tags$ul(
             tags$li("Present macroeconomic growth models in their simplest form"), 
             tags$li("Present simulations"), 
             tags$li("Make the models and their inner workers more visual")
           ),
           p('This app is directly accompanying the book ', a(href = 'https://swisscovery.slsp.ch/discovery/fulldisplay?docid=alma991170526913405501&context=L&vid=41SLSP_NETWORK:VU1_UNION&lang=de&search_scope=DN_and_CI&adaptor=Local%20Search%20Engine&isFrbr=true&tab=41SLSP_NETWORK&query=any,contains,Introducing%20Advanced%20Macroeconomics:%20Growth%20and%20Business%20Cycles%20by%20Sorensen%20and%20Whitta-Jacobsen&sortby=date_d&facet=frbrgroupid,include,9040471419498156407&offset=0', 'Introducing Advanced Macroeconomics: Growth and Business Cycles by Sorensen and Whitta-Jacobsen', .noWS = "outside"), '.', .noWS = c("after-begin", "before-end"))
  )