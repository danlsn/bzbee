#!/usr/local/bin/Rscript
suppressMessages(library(tidyverse))

setwd("~/Documents/Projects/IdeaProjects/bzbee/R")

BZLOGS <- "/Library/Backblaze.bzpkg/bzdata/bzlogs"
LOG_BACKUP <- "/Users/danlsn/Documents/DATABASE/Backblaze"
PAT <- "\\.(zip|log)"

# handle_bzlog_files: copy files, rename, then move to backup location
handle_bzlog_files <- function(files, temp_dir = tempdir(), dest = ".") {
  for (file in files) {
    dir_str <- str_extract(dirname(file), "bzlogs/.*")
    dest_path <- paste0(temp_dir, "/", dir_str, "/")
    # Check if {dest_path} exists, if not create directory
    if (!dir.exists(dest_path)) {
      dir.create(dest_path, recursive = TRUE, showWarnings = FALSE)
      # print(paste("Dir created:", dest_path))
    }
    # Copy file to {dest} and return
    file.copy(file, dest_path, overwrite = TRUE, copy.date = TRUE)
    out_file <- paste0(dest_path, basename(file))
    if (grepl("\\.zip", out_file)) {
      # Handle ZIP file
      unzipped <- unzip(out_file, exdir = dirname(out_file), overwrite = TRUE, setTimes = TRUE)
    }
  }
  log_files <- list.files(path = temp_dir, pattern = "\\.log", full.names = FALSE, recursive = TRUE)
  for (lf in log_files) {
    lf_path <- paste0(temp_dir, "/", lf)
    dir_str <- str_extract(dirname(lf_path), "bzlogs/.*")
    first_line <- read_lines(lf_path, n_max = 1)
    if (str_detect(first_line, "^(\\d{4}-\\d{2}-\\d{2})")) {
      dt <- str_extract(first_line, "^(\\d{4}-\\d{2}-\\d{2})")
    } else if (str_detect(first_line, "^\\d{14}")) {
      dt <- str_extract(first_line, "^(\\d{8})")
      dt <- gsub("^(\\d{4})(\\d{2})(\\d{2})", "\\1-\\2-\\3", dt)
    }
    out_file <- paste0(dest, "/", dir_str, "/", dt, ".log")
    if (!dir.exists(dirname(out_file))) {
      dir.create(dirname(out_file), recursive = TRUE, showWarnings = FALSE)
    }
    file.copy(lf_path, out_file, overwrite = TRUE, copy.date = TRUE)
    print(paste0("File Copied: from ", lf_path, " to ", out_file))
  }
}

# bzbee stash_logs: archive daily log files for backup and further analysis
stash_logs <- function(search_dir = BZLOGS, backup_dir = LOG_BACKUP, temp_dir = tempdir()) {
  # List all files in {search_dir} recursively, return full path names
  file_list <- list.files(path = search_dir, recursive = TRUE, full.names = TRUE, pattern = PAT)
  # Split {file_list} into lists containing only zip and log files
  zip_files <- file_list[grep("\\.zip", file_list)]
  log_files <- file_list[grep("\\.log", file_list)]
  handle_bzlog_files(zip_files, temp_dir = temp_dir, dest = backup_dir)
  handle_bzlog_files(log_files, temp_dir = temp_dir, dest = backup_dir)
}

stash_logs()
