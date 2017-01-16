#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

##install.packages("lubridate")
library(lubridate)
##install.packages("plotly")
library(plotly)
## stacked bar in plotly
mon<-month(datFinal$Date)
#Static plot of debits and credits
##bcd<-p <- plot_ly(datFinal, x = ~mon, y = ~Debit, type = 'bar', name = 'Debits') %>%
##  add_trace(y = ~Credit, name = 'Credits') %>%
##  layout(title = "2018 Credits and Debits by month", yaxis = list(title = 'Dollars'), xaxis = list(title = "Month"), barmode = 'stack')

# Define server logic required to draw charts
shinyServer(function(input, output) {

  ## Reactive plot: Credit bar chart with threshold slider  
  output$bc <- renderPlotly({
    plot_ly(datFinal, x = ~month(datFinal$Date), y = ~reactive({datFinal[which(datFinal$Credit > input$cThresh),]}), 
            type = 'bar', name = 'Credits', color = ~Account) %>%
      layout(title = "2018 Credits by month", 
             yaxis = list(title = 'Dollars'), xaxis = list(title = "Month"), barmode = 'stack')
  })
  ## Reactive plot: Debit bar chart with threshold slider
    output$bd <- renderPlotly({
    plot_ly(datFinal, x = ~month(datFinal$Date), y = ~reactive({datFinal[which(datFinal$Debit > input$dThresh),]}), 
            type = 'bar', name = 'Debits', color = ~Account) %>%
      layout(title = "2018 Debits by month", 
             yaxis = list(title = 'Dollars'), xaxis = list(title = "Month"), barmode = 'stack')
  })
## Reactive plot: Credit pie chart with threshold slider
    output$pc <- renderPlotly({
    plot_ly(datFinal, labels = ~Account, values = ~reactive({datFinal[which(datFinal$Credit > input$cThresh),]}), type = 'pie') %>%
      layout(title = 'Credits',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
      )
  })    
## Reactive plot: Debit pie chart with threshold slider
  output$pd <- renderPlotly({
    plot_ly(datFinal, labels = ~Account, values = reactive({datFinal[which(datFinal$Debit > input$dThresh),]}), type = 'pie') %>%
      layout(title = 'Debits',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
      )
  })
## Reactive plot: Credit pie chart with month slider
  output$pcmon <- renderPlotly({
    plot_ly(datFinal, labels = ~Account, values = reactive({datFinal$Credit[which(month(datFinal$Date)==input$Month),]}), type = 'pie') %>%
      layout(title = 'Crebits',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
      )
  })
## Reactive plot: Debit pie chart with month slider
  output$pdmon <- renderPlotly({
    plot_ly(datFinal, labels = ~Account, 
            values = reactive({datFinal$Debit[which(month(datFinal$Date)==input$Month),]}), type = 'pie') %>%
      layout(title = 'Debits',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
      )
  })

})