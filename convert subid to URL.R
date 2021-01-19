#make URL link for Shiny table
#turns ebird subid into a clickable html URL

library(data.table) 

subidtable <- fread("shinytest.csv")

#rename column
setnames(subidtable, "SAMPLING EVENT IDENTIFIER", "SAMPLINGEVENTIDENTIFIER")

# Add new columns 
subidtable$front <- '<a href="https://ebird.org/checklist/'

subidtable$middle <- '/" target="_blank">https://ebird.org/checklist/'

subidtable$back <- '</a>'

# concatenate into eBird URL
subidtable$ChecklistLink <-  with(subidtable, paste0(front, SAMPLINGEVENTIDENTIFIER, middle, SAMPLINGEVENTIDENTIFIER, back))

#rename column back
setnames(subidtable, "SAMPLINGEVENTIDENTIFIER", "SAMPLING EVENT IDENTIFIER")

#Select columns for export:
#Select all columns and only the rows you want:
export <- subidtable[, c("SAMPLING EVENT IDENTIFIER","ChecklistLink")]

#Then export:
write.csv(export, file= "subids_with_url5.csv")
#export obsid and URL

