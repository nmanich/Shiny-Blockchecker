#make URL link for Shiny table
#turns ebird subid into a clickable html URL

subidtable <- read.delim("ebd_US-WI_201501_201912_relDec-2020.txt", sep="\t", header=TRUE, quote = "", stringsAsFactors = FALSE, na.strings=c(""))

#keep only unique subids
subidunique <- subidtable[!duplicated(subidtable$SAMPLING.EVENT.IDENTIFIER), ]

# Add new columns 
subidunique$front <- '<a href="https://ebird.org/checklist/'

subidunique$middle <- '/" target="_blank">https://ebird.org/checklist/'

subidunique$back <- '</a>'

# concatenate into eBird URL
subidunique$ChecklistLink <-  with(subidunique, paste0(front, SAMPLING.EVENT.IDENTIFIER, middle, SAMPLING.EVENT.IDENTIFIER, back))

#Select columns for export:
#Select all columns and only the rows you want:
export <- subidunique[, c("SAMPLING.EVENT.IDENTIFIER","ChecklistLink")]

#Then export:
write.csv(export, file= "subids_with_url9.csv", row.names=FALSE)
