# Archive Zipped Log Files
library(tidyverse)

# Create Temporary Directory
tmp_dir <- tempdir()

# List all lastfiletransmitted log files
path <- "~/Documents/Projects/IdeaProjects/bzbee/data/in/bzlogs/bzreports_lastfilestransmitted"
files <- list.files(path, full.names = TRUE)
zip_files <- files[grepl("\\.zip", files)]

for (zf in zip_files) {
  file.copy(zf, tmp_dir)
}
str(path)

tmp_files <- list.files(tmp_dir)
tmp_zips <- tmp_files[grepl("\\.zip", tmp_files)]

for (zf in tmp_zips) {
  zip_file <- file.path(tmp_dir, zf)
  unzipped <- unzip(zip_file, exdir = tmp_dir)
  log <- read_lines(unzipped, n_max = 1)
  dt <- str_extract(log, "^(\\d{4}-\\d{2}-\\d{2})")
  file.copy(unzipped, paste0("./", dt, ".log"),)
}


