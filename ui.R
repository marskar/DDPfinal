#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


###################################
shinyUI(
  navbarPage("LedgEx: Ledger Explorer",
    tabPanel("Plots",
      sidebarPanel(
        sliderInput("Month", "Month:", min = 1, max = 12, value = 6),
        sliderInput("cThresh", "Credit Minimum:", min = 1, max = 10000, value = 100),
        sliderInput("dThresh", "Debit Minimum:", min = 1, max = 10000, value = 100)
      ),
      mainPanel(
        tabsetPanel(
          # Bars
          tabPanel("Bar charts"),
            textOutput('2018 Credits by Month'),
            plotlyOutput("bc"),
            textOutput('2018 Debits by Month'),
            plotlyOutput("bd")
          ),
          # Pies
          tabPanel("Pie charts"),
            textOutput('2018 Credits by Month'),
            plotlyOutput("pc"),
            textOutput('2018 Debits by Month'),
            plotlyOutput("pd")
          ),
          # Data panel
          tabPanel(p(icon("table"), "Data"),
            dataTableOutput(outputId="table"),
            downloadButton('downloadData', 'Download')
          ),
          ## About panel
          tabPanel("About",
            mainPanel(includeMarkdown("info.md"))
          )
      
    )
  )
)
