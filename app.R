#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table) #for fread

# Load in database
df <- fread("test3.csv")

#fixes issues with double quotes during import
df[, ChecklistLink := gsub('\"', '\'', ChecklistLink)]


# Define UI for block dropdowns
ui <- fluidPage(
  titlePanel("Block Summary"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("block_name",
                             "Block Name:",
                             c("All",
                               unique(as.character(df$block_name))))
    ),
    column(4,
           selectInput("common_name",
                       "Species:",
                       c("All",
                         unique(as.character(df$common_name))))
    ),
    column(4,
           selectInput("breeding_bird_atlas_category",
                       "Code Category:",
                       c("All",
                         unique(as.character(df$breeding_bird_atlas_category))))
    ),
    
    column(4,
           selectInput("project_code",
                       "Portal:",
                       c("All",
                         unique(as.character(df$project_code))))
    ),
    column(4,
           selectInput("approved",
                       "Accepted in eBird:",
                       c("All",
                         unique(as.character(df$approved))))
    )
  ),
  # Create a new row for the table.
  DT::dataTableOutput("table")
)

# Server Side Script
server <- function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- df 
    if (input$block_name != "All") {
      data <- data[data$block_name == input$block_name,]
    }
    if (input$common_name != "All") {
      data <- data[data$common_name == input$common_name,]
    }
    if (input$breeding_bird_atlas_category != "All") {
      data <- data[data$breeding_bird_atlas_category == input$breeding_bird_atlas_category,]
    }
    if (input$project_code != "All") {
      data <- data[data$project_code == input$project_code,]
    }
    if (input$approved != "All") {
      data <- data[data$approved == input$approved,]
    }
    data
  },escape = FALSE)) 
  
}

# Run the application 
shinyApp(ui = ui, server = server)

