library(tidyverse)
library(shiny)
library(arules)
library(arulesViz)
library(visNetwork)

# ----------------------------------------- Load Clean Data -----------------------------------------

# Load clean Online Retail data
df <- read.csv('online_retail_clean.csv')

# Convert columns to approprate data types
df$InvoiceNo <- as.factor(df$InvoiceNo)
df$Description <- as.factor(df$Description)
df$Country <- as.factor(df$Country)
df$InvoiceDate <- as.Date(df$InvoiceDate)

#------------------------------------------ User Interface ---------------------------------------------

ui <- fluidPage(
  
  titlePanel("Interactive Visualization of Association Rules"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      sliderInput(inputId = "support", 
                  label = "Support Threshold",
                  min = 0, max = 1,
                  value = 0.01),
      
      
      sliderInput(inputId = "confidence", 
                  label = "Confidence Threshold",
                  min = 0, max = 1,
                  value = 0.5),
      
      sliderInput(inputId = "lift", 
                  label = "Lift Threshold",
                  min = 1, max = 100,
                  value = 5),
      
      dateRangeInput(
        inputId = "daterange",
        label = "InvoiceDate",
        start = min(df$InvoiceDate),
        end = max(df$InvoiceDate),
        format = "yyyy-mm-dd"
      )
      
    ),
    
    mainPanel(
      
      fluidRow(
      visNetworkOutput(outputId = "arulesplot", height = "600px"), 
      tableOutput(outputId = "arulestable")
    )
    
  )
  
))

# ----------------------------------------------- Server --------------------------------------------------------------

server <- function(input, output) {
  
  # If date range input changed, data is filtered accordingly prior to association rule mining
  # Association rule mining based on support and confidence inputs
  # Resulting association rules filtered based on lift input
  
  rules <- reactive({  
    
    subset(apriori(
      as(split(subset(df, InvoiceDate >= input$daterange[1] & InvoiceDate <= input$daterange[2])$Description, 
               subset(df, InvoiceDate >= input$daterange[1] & InvoiceDate <= input$daterange[2])$InvoiceNo), 
         "transactions"), 
      parameter = list(support = input$support, confidence = input$confidence, minlen=2, 
                       target = "rules")), lift >= input$lift)
    
    })
  
  # Plot network graph of association rules
  output$arulesplot <- renderVisNetwork({
    plot(
      rules(), method = "graph", engine = "htmlwidget")
    })
  
  # Plot table of association rules
  output$arulestable <- renderTable({ 
    head(select(arrange(as(rules(), "data.frame"), desc(lift), desc(confidence)), rules, support, confidence, lift), 20)
  })
  
  
}

# -----------------------------------------Shiny app object ---------------------------------------------

shinyApp(ui = ui, server = server)


