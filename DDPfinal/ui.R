#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("bins",
                   "Number of bins:",
                   min = 1,
                   max = 50,
                   value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
###################################
shinyUI(
  navbarPage("LedgEx: Ledger Explorer",
             tabPanel("Plot",
                      sidebarPanel(
                        sliderInput("Month", 
                                    "Month:", 
                                    min = 1, 
                                    max = 12),
                        uiOutput("evtypeControls"),
                        actionButton(inputId = "clear_all", label = "Clear selection", icon = icon("check-square")),
                        actionButton(inputId = "select_all", label = "Select all", icon = icon("check-square-o"))
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          
                          # Data by state
                          tabPanel(p(icon("map-marker"), "By state"),
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
                                   column(7,
                                          plotOutput("populationImpactByState"),
                                          plotOutput("economicImpactByState")
                                   )
                                   
                          ),
                          
                          # Time series data
                          tabPanel(p(icon("line-chart"), "By year"),
                                   h4('Number of events by year', align = "center"),
                                   showOutput("eventsByYear", "nvd3"),
                                   h4('Population impact by year', align = "center"),
                                   showOutput("populationImpact", "nvd3"),
                                   h4('Economic impact by year', align = "center"),
                                   showOutput("economicImpact", "nvd3")
                          ),
                          
                          
                          
                          # Data 
                          tabPanel(p(icon("table"), "Data"),
                                   dataTableOutput(outputId="table"),
                                   downloadButton('downloadData', 'Download')
                          )
                        )
                      )
                      
             ),
             
             tabPanel("About",
                      mainPanel(
                        includeMarkdown("info.md")
                      )
             )
  )
)