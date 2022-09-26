library(rex)
library(magrittr)

bz_file_ids <- scan(file = "/Library/Backblaze.bzpkg/bzdata/bzbackup/bzfileids.dat", what = "character", sep = "\n")

file_ids_parsed <- bz_file_ids %>%
  re_matches(
    rex(
      capture(
        name = "filename_id",
        alnum %>% n_times(16)
      ),
      space,
      capture(
        name = "filename",
        anything
      ),
      end
    )
  )
