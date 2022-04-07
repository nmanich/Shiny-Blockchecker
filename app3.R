# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
# 
# First prepare the EBD file. Then this app allows a user to query the WBBA Database.
#
# Thanks to Daniel Schlaepfer for help troubleshooting.
#

# Alternate version with different fields shown

library(shiny)
library(data.table) #for fread

# Load in database
df <- fread("dataforshiny2.csv")

#fixes issues with double quotes during import
df[, checklistlink := gsub('\"\"', '\'', checklistlink)]

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
           selectInput("breeding_category",
                       "Code Category:",
                       c("All",
                         unique(as.character(df$breeding_category))))
    ),
    column(4,
           selectInput("breeding_code",
                       "Breeding Code:",
                       c("All",
                         unique(as.character(df$breeding_code))))
    )
  ),
  # Create a new row for the table.
  DT::dataTableOutput("table")
)

# Server Side Script
server <- function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    
  #ids is an index that helps with subsetting
    ids <- rep(TRUE, nrow(df))
    if (input$block_name != "All") {
      ids <- ids & df$block_name == input$block_name
    }
    if (input$common_name != "All") {
      ids <- ids & df$common_name == input$common_name
    }
    if (input$breeding_category != "All") {
      ids <- ids & df$breeding_category == input$breeding_category
    }
    if (input$breeding_code != "All") {
      ids <- ids & df$breeding_code == input$breeding_code
    }
    # this number controls how many rows are shown in output table
    ids <- which(ids)
    if (length(ids) > 500) {
      ids <- ids[seq_len(500)]
    }
    df[ids, ]
    
    },escape = FALSE)) 
  
}

# Run the application 
shinyApp(ui = ui, server = server)

