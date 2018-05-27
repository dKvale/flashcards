#ui.R
library(shiny)
library(markdown)

shinyUI(navbarPage("Flash card flipper", id = "nav_top",
                   navbarMenu("Options", 
                        tabPanel("No options available.",
                            div(class="outer",
                                tags$head(
                                  # Include custom CSS
                                  includeCSS("CSS//styles.css")
                                ),
                                
                                fluidRow(
                                  
                                  column(12, htmlOutput("card", width="50%", height="100%", class = "cards"))),
                                
                                absolutePanel(id = "controls", 
                                              class = "panel panel-default", 
                                              fixed = TRUE, draggable = FALSE, 
                                              top = 58, left = 20, right = "auto", bottom = "auto",  
                                              width = 330, height = "auto",
                                              
                                              h3("Flash cards"),
                                              
                                              selectizeInput("data_tbls", "Data sets",  multiple=TRUE, choices = "All", selected = "All"), 
                                              selectizeInput("test_cols", "Test columns", multiple=TRUE, choices = 1, selected = 1),
                                              selectizeInput("ans_cols", "Answer columns",  multiple=TRUE, choices = 2, selected = 2),
                                              br(),
                                              textInput("add_data",
                                                        "Add more data sets",
                                                        "http://"),
                                              
                                              actionButton("next_slide", "Next slide >"),
                                              br()
                                              
                                ))))
))

