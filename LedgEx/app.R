#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(lubridate)
library(plotly)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
   
   # Application title
   titlePanel("LedgEx"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        sliderInput("Month", "Month:", min = 1, max = 12, value = 6),
        sliderInput("dThresh", "Debit Minimum:", min = 1, max = 10000, value = 100)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotlyOutput("pd")
      )
   )
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {

  ## Reactive plot: Debit pie chart with threshold slider
  output$pd <- renderPlotly({
    d1k<-datFinal[which(datFinal$Debit > input$dThresh),]
    dmon<-d1k[which(month(d1k$Date)==input$Month),]
    plot_ly(dmon, labels = ~Account, values = dmon$Debit, type = 'pie') %>%
      layout(title = 'Debits',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  })
  })


# Run the application 
shinyApp(ui = ui, server = server)

