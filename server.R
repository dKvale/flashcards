#server.R
#library(dplyr)
library(shiny)
#library(markdown)
library(readr)
library(knitr)

source("tbl_cards.R")


data_sets <- c("shopping"   = "https://raw.githubusercontent.com/dKvale/japanese/master/greetings.csv",
               "greetings"  = "https://raw.githubusercontent.com/dKvale/japanese/master/vocab/shopping.csv",
               "colors"     = "https://raw.githubusercontent.com/dKvale/japanese/master/vocab/colors.csv",
               "time"       = "https://raw.githubusercontent.com/dKvale/japanese/master/vocab/time.csv",
               "town"       = "https://raw.githubusercontent.com/dKvale/japanese/master/vocab/town.csv",
               "dates"      = "https://raw.githubusercontent.com/dKvale/japanese/master/vocab/dates.csv",
               "food"       = "https://raw.githubusercontent.com/dKvale/japanese/master/vocab/food.csv",
               "occupations"  = "https://raw.githubusercontent.com/dKvale/japanese/master/vocab/occupations.csv",
               "transit"  = "https://raw.githubusercontent.com/dKvale/japanese/master/vocab/transit.csv")


#-- Server for Flash cards
shinyServer(function(input, output, session) {
  
  
  # Generate data sets for cards
  updateSelectizeInput(session, "data_tbls",
                       choices  = c("All", data_sets),
                       selected = 'All'
  ) 
  
  
  combine_data_sets <- reactive({
    
    print(input$data_tbls)
    
    data_tbls <- input$data_tbls
    
    if(input$data_tbls == "All") data_tbls <- data_sets
    
    print(data_tbls)
    
    all_tbls <- data.frame()
    
    for(i in 1:length(data_tbls)) {
      all_tbls <- rbind(all_tbls, read_csv(data_tbls[i]))
    }
    
    
    updateSelectizeInput(session, "test_cols",
                         choices  = names(all_tbls),
                         selected = names(all_tbls)[1]
    ) 
    
    updateSelectizeInput(session, "ans_cols",
                         choices  = names(all_tbls),
                         selected = names(all_tbls)[2]
    ) 
    
    return(all_tbls)
  })   
  
  v <- reactiveValues(data = 1)
  
  
  observeEvent(input$next_slide, v$data <- v$data + 1)
  
  output$card <- renderUI({
    
    print(input$ans_cols)
    
    print(v$data)
    
    HTML(tbl_cards(x   = combine_data_sets(), 
              test_col = input$test_cols, 
              ans_col  = input$ans_cols, 
              ncards   = 1,
              output   = "html"))
           
  })
  
})