library(shiny)

library(ggplot2)
library(rCharts)
library(ggvis)

library(data.table)
library(reshape2)
library(dplyr)

library(markdown)

library(mapproj)
library(maps)

source("helpers.R", local = TRUE)


states_map <- map_data("state")
dt <- fread('data/events.agg.csv') %>% mutate(EVTYPE = tolower(EVTYPE))
evtypes <- sort(unique(dt$EVTYPE))


shinyServer(function(input, output, session) {
    
    values <- reactiveValues()
    values$evtypes <- evtypes
    
    
    output$evtypeControls <- renderUI({
        checkboxGroupInput('evtypes', 'Event types', evtypes, selected=values$evtypes)
    })

     dt.agg <- reactive({
         aggregate_by_year(dt, input$range[1], input$range[2], input$evtypes)
       
     })
    
    # Events by year
    output$eventsByYear <- renderChart({
      plot_events_by_year(dt.agg())
    })
    
    # Population impact by year
    output$populationImpact <- renderChart({
       plot_impact_by_year(
            dt = dt.agg() %>% select(Year, Injuries, Fatalities),
            dom = "populationImpact",
            yAxisLabel = "Affected",
            desc = TRUE
        )
    })

    

})


