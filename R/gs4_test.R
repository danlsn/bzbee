library(googlesheets4)

gs <- read_sheet("https://docs.google.com/spreadsheets/d/1Jn_aJ8KDgTN5ZM1U7pEEAGSBWpQ8VM819EBNKbmfa74/edit#gid=0")

sheet_properties("https://docs.google.com/spreadsheets/d/1Jn_aJ8KDgTN5ZM1U7pEEAGSBWpQ8VM819EBNKbmfa74/edit#gid=0")

gs4_get("https://docs.google.com/spreadsheets/d/1Jn_aJ8KDgTN5ZM1U7pEEAGSBWpQ8VM819EBNKbmfa74/edit#gid=0")
