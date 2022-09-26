library(rex)
library(magrittr)

filelist <- scan(file = "/Library/Backblaze.bzpkg/bzdata/bzfilelists/v0008f1032df349b41f38c330611_root_filelist.dat", what = "character", sep = "\n")

filelist_parsed <- filelist %>%
  re_matches(
    rex(
      start,
      capture(
        name = "file_type",
        letter
      ),
      space,
      capture(
        name = "mod_time_millis",
        alnum %>% n_times(16)
      ),
      space,
      capture(
        name = "filesize_bytes",
        digits
      ),
      space,
      capture(
        name = "filename",
        anything
      ),
      end
    )
  )

rex(
  start,
  capture(
    name = "file_type",
    letter
  ),
  space,
  capture(
    name = "mod_time_millis",
    alnum %>% n_times(16)
  ),
  space,
  capture(
    name = "filesize_bytes",
    digits
  ),
  space,
  capture(
    name = "filename",
    anything
  ),
  end
)
