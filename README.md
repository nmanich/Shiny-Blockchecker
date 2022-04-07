# Shiny-Blockchecker
Shiny App allowing querying of ebird atlas data for proofing purposes.

This allows you to use drop-downs to instantly filter atlas data. As written, you can pull up and filter records by block, species, or breeding category. 
You could swap out these fields and insert your own to filter by different categories in the EBD.

My eventual intent was to also use it to screen for out of portal and invalid data as a final check on atlas blocks.

![shinypreview.PNG](https://github.com/nmanich/Shiny-Blockchecker/blob/main/shinypreview.PNG)

Short directions to get started:
The quick way to get it running is to run app2.R, pointing it to the file formatted like test3.csv. You can tell from the file names how polished a version this is, 
but I've got it running and working at the moment!

Longer directions to prepare files:
(I’m writing these directions for me, where I intend to use postgres to export. If the file is small you can ignore this entirely, just prepare it in excel with the proper columns based on the example csv.)

1. Run R-script called convert_subid_to_URL, which loads in the EBD data and spits out a csv file with unique subids as clickable URLs.

2. Output csv from Step 1 can be merged into the postgres database to join it to the EBD.  Use sql_for_shiny.sql if you wish (or with R, or manually). Basically you are merging in the URL column we made, also merging in a column with block names, and exporting it out in the correct order (see test3.csv file for formatting).

3. If your version has more than one portal, then load in output from step 2 and convert all non-atlas portals to a single name (using Portal consolidation.R). Actually I'm sure there's a more elegant way to do this, but this is brute force for now.

4. Use the output file from step 3 to run in the shiny app (called app2.R).


