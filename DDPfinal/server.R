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
  c1k<-datFinal[which(datFinal$Credit > input$cThresh),] 
  d1k<-datFinal[which(datFinal$Debit > input$dThresh),] 
  cmon<-c1k[which(month(c1k$Date)==input$Month),]
  dmon<-d1k[which(month(d1k$Date)==input$Month),]
  
  output$bc <- renderPlot({
    plot_ly(c1k, x = ~month(c1k$Date), y = ~Credit, 
            type = 'bar', name = 'Credits', color = ~Account) %>%
      layout(title = "2018 Credits by month", 
             yaxis = list(title = 'Dollars'), xaxis = list(title = "Month"), barmode = 'stack')
  })
  output$bd <- renderPlot({
    plot_ly(d1k, x = ~month(d1k$Date), y = ~Debit, 
            type = 'bar', name = 'Debits', color = ~Account) %>%
      layout(title = "2018 Debits by month", 
             yaxis = list(title = 'Dollars'), xaxis = list(title = "Month"), barmode = 'stack')
  })
## Reactive plot: Credit pie chart with threshold slider
    output$pc <- renderPlot({
    plot_ly(c1k, labels = ~Account, values = ~Credit, type = 'pie') %>%
      layout(title = 'Credits',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
      )
  })    
## Reactive plot: Debit pie chart with threshold slider
  output$pd <- renderPlot({
    plot_ly(d1k, labels = ~Account, values = d1k$Debit, type = 'pie') %>%
      layout(title = 'Debits',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
      )
  })
## Reactive plot: Credit pie chart with month slider
  output$pcmon <- renderPlot({
    plot_ly(cmon, labels = ~Account, values = cmon$Credit, type = 'pie') %>%
      layout(title = 'Crebits',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
      )
  })
## Reactive plot: Debit pie chart with month slider
  output$pdmon <- renderPlot({
    plot_ly(dmon, labels = ~Account, values = dmon$Debit, type = 'pie') %>%
      layout(title = 'Debits',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
      )
  })

})