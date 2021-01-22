# sort and portal consolidation for shiny table
library(data.table)

df <- fread("tableforshiny1.csv")

#fixes issues with double quotes during import
df[, checklistlink := gsub('\"', '\'', checklistlink)]

# group all other portals as just "other"

df[project_code == "EBIRD_NJ", project_code := "not"]

df[project_code == "EBIRD_PR", project_code := "not"]

df[project_code == "EBIRD_BCN", project_code := "not"]

df[project_code == "EBIRD_NZ", project_code := "not"]

df[project_code == "EBIRD_AU", project_code := "not"]

df[project_code == "EBIRD_VINS", project_code := "not"]

df[project_code == "EBIRD_TWN", project_code := "not"]

df[project_code == "EBIRD_NH", project_code := "not"]

df[project_code == "EBIRD_CAN", project_code := "not"]

df[project_code == "EBIRD", project_code := "not"]

df[project_code == "EBIRD", project_code := "not"]

df[project_code == "EBIRD_PNW", project_code := "not"]

df[project_code == "EBIRD_CL", project_code := "not"]

df[project_code == "EBIRD_COL", project_code := "not"]

df[project_code == "EBIRD_IND", project_code := "not"]

df[project_code == "EBIRD_MA", project_code := "not"]

df[project_code == "EBIRD_TX", project_code := "not"]

df[project_code == "EBIRD_PA", project_code := "not"]

df[project_code == "EBIRD_BRA", project_code := "not"]

df[project_code == "EBIRD_MO", project_code := "not"]

df[project_code == "EBIRD_CB", project_code := "not"]

df[project_code == "EBIRD_CAMERICA", project_code := "not"]

df[project_code == "EBIRD_VA", project_code := "not"]

df[project_code == "EBIRD_QC", project_code := "not"]

df[project_code == "EBIRD_AK", project_code := "not"]

df[project_code == "EBIRD_WI", project_code := "not"]

df[project_code == "EBIRD_MEX", project_code := "not"]

df[project_code == "EBIRD_ME", project_code := "not"]

df[project_code == "EBIRD_ARG", project_code := "not"]

df[project_code == "EBIRD_PE", project_code := "not"]

df[project_code == "EBIRD_ESP", project_code := "not"]

#Then export:
write.csv(df, file= "shinytable6.csv", row.names=FALSE)




