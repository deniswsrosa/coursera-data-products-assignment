

library(shiny)

library(rCharts)

shinyUI( 

  
    navbarPage("US Storm Data Explorer",
        tabPanel("Home",
                sidebarPanel(
                    sliderInput("range", 
                        "Range:", 
                        min = 1950, 
                        max = 2011, 
                        value = c(1993, 2011),
                        format="####"),
                    uiOutput("evtypeControls"),
                    actionButton(inputId = "clear_all", label = "Clear selection", icon = icon("check-square")),
                    actionButton(inputId = "select_all", label = "Select all", icon = icon("check-square-o"))
                ),
  
                mainPanel(
                    tabsetPanel(
                        
                      tabPanel(p("Graph Help"),
                               mainPanel(
                                 includeMarkdown("graphHelp.md")
                               )    
                      ),
                        
                        # Time series data
                        tabPanel(p(icon("line-chart"), "Graph Result"),
                                 column(3,
                                        wellPanel(
                                          radioButtons(
                                            "populationCategory",
                                            "Population impact category:",
                                            c("Both" = "both", "Injuries" = "injuries", "Fatalities" = "fatalities"))
                                        )
                                 ),
                                 column(3,
                                        wellPanel(
                                          radioButtons(
                                            "economicCategory",
                                            "Economic impact category:",
                                            c("Both" = "both", "Property damage" = "property", "Crops damage" = "crops"))
                                        )
                                 ),
                                 h4('Number of events by year', align = "center"),
                                 showOutput("eventsByYear", "nvd3"),
                                 p(''),
                                 h4('Population impact by year', align = "center"),
                                 showOutput("populationImpact", "nvd3")
                        )
                    )
                )
            
        ),
        
        tabPanel("About this app",
            mainPanel(
                includeMarkdown("about.md")
            )
        )
    )
)
